import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApplicationComponent } from './application.component';
import {ApplicationService} from "./application.service";
import {MatButtonModule} from "@angular/material/button";
import {RouterModule} from "@angular/router";
import {AuthGuard} from "../../core/auth/auth.guard";
import {ToolBarModule} from "../../features/tool-bar/tool-bar.module";
import {OrganizationHeaderModule} from "../../features/organization-header/organization-header.module";
import {ApplicationHeaderModule} from "../../features/application-header/application-header.module";
import {BreadcrumbsModule} from "../../features/breadcrumbs/breadcrumbs.module";



@NgModule({
  declarations: [ApplicationComponent],
  imports: [
    CommonModule,
    MatButtonModule,
    ApplicationHeaderModule,
    RouterModule.forChild([
      {path: '', component: ApplicationComponent, canActivate: [AuthGuard]},
    ]),
    ToolBarModule,
    OrganizationHeaderModule,
    BreadcrumbsModule
  ],
  providers: [ApplicationService]
})
export class ApplicationModule { }
