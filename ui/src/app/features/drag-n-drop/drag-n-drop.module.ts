/*
 * Copyright (c) 2020 the original author or authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';

import { DragNDropComponent } from './drag-n-drop.component';
import { DragNDropDirective } from './drag-n-drop.directive';
import {MatIconModule} from "@angular/material/icon";

@NgModule({
  declarations: [DragNDropComponent, DragNDropDirective],
  exports: [DragNDropComponent],
    imports: [CommonModule, TranslateModule, MatIconModule],
})
export class DragNDropModule {}
