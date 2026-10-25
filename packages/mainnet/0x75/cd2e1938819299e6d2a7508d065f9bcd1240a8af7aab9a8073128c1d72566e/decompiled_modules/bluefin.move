module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bluefin {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun migrate<T0, T1>(arg0: &mut 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch::Launch<T0, T1>, arg1: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::PackageVersion, arg2: &mut 0x2::tx_context::TxContext) {
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch::migrate_to_creator<T0, T1>(arg0, arg1, arg2);
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u8, arg2: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::PackageVersion, arg3: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch_config::LaunchConfig, arg4: u32, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch::LaunchInitializer<T0, T1> {
        let v0 = if (arg4 >= 1) {
            if (arg4 <= 400) {
                if (arg5 >= 1) {
                    arg5 <= 20000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = Witness{dummy_field: false};
        0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch::new<T0, T1, Witness>(v1, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

