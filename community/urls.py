from django.urls import path
from . import views

urlpatterns = [
    path('', views.home_dashboard, name='home_dashboard'),
    path('add/', views.add_member, name='add_member'),
    path('edit/<int:index>/', views.edit_member, name='edit_member'),
    path('delete/<int:index>/', views.delete_member, name='delete_member'),
    path('success/', views.success, name='success'),
    path('api/members/', views.api_members, name='api_members'),
    path('api/reorder/', views.reorder_members, name='reorder_members'),
    path('export/csv/', views.export_csv, name='export_csv'),
    path('export/excel/', views.export_excel, name='export_excel'),
    path('export/word/', views.export_word, name='export_word'),
    path('export/pdf/', views.export_pdf, name='export_pdf'),
    path('import/excel/', views.import_excel, name='import_excel'),
    path('delete-all/', views.delete_all_members, name='delete_all_members'),
]
