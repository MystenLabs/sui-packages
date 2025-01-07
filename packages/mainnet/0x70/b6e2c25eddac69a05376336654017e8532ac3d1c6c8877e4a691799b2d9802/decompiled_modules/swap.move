module 0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::VaultCap, arg1: &mut 0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::version::Version) {
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::version::assert_current_version(arg3);
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::VaultCap, arg1: &mut 0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::Vault<T0, T1, T2>, arg2: &0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::version::Version) {
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::version::assert_current_version(arg2);
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x70b6e2c25eddac69a05376336654017e8532ac3d1c6c8877e4a691799b2d9802::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

