/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.liferay.nativity.modules.contextmenu.listeners;

/**
 * @author Dennis Ju
 */
public abstract class MenuItemListener {

	/**
	 * Called when a context menu item is selected
	 *
	 * @param text value of the selected menu item
	 *
	 * @param array of selected file paths
	 */
	public abstract void onMenuItemSelected(String menuText, String[] paths);

}