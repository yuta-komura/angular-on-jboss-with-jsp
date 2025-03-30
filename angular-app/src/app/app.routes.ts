import { Routes } from '@angular/router';
import { AppComponent } from './app.component'; // ルートで表示したいコンポーネント

export const routes: Routes = [
  {
    path: 'hello',
    component: AppComponent,
  },
  {
    path: '',
    redirectTo: 'hello',
    pathMatch: 'full',
  },
];
