from django import forms
from .models import Member

class MemberForm(forms.ModelForm):
    class Meta:
        model = Member
        fields = ['member_number', 'name', 'surname', 'address', 'id_number', 'date_of_birth', 'contact', 'sex', 'educational_qualification']
        widgets = {
            'date_of_birth': forms.DateInput(attrs={'type': 'date'}),
        }
