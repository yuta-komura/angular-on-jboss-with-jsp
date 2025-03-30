import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';

export const routes: Routes = [
  {
    path: 'hello',
    component: HomeComponent,
  },
  {
    path: '',
    redirectTo: 'hello',
    pathMatch: 'full',
  },
];
