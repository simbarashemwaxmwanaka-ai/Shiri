from django.db import models

class Member(models.Model):
    SEX_CHOICES = [
        ('Male', 'Male'),
        ('Female', 'Female'),
        ('Other', 'Other'),
    ]

    index = models.AutoField(primary_key=True)
    member_number = models.CharField(max_length=50, unique=True)
    name = models.CharField(max_length=100)
    surname = models.CharField(max_length=100)
    address = models.TextField()
    id_number = models.CharField(max_length=50, unique=True)
    date_of_birth = models.DateField()
    contact = models.CharField(max_length=100)
    sex = models.CharField(max_length=20, choices=SEX_CHOICES)
    educational_qualification = models.CharField(max_length=150)
    display_order = models.IntegerField(default=0)

    class Meta:
        ordering = ['display_order', 'index']

    def __str__(self):
        return f"{self.name} {self.surname} ({self.member_number})"
