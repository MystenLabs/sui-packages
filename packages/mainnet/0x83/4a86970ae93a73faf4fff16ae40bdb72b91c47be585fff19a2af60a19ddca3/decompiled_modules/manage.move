module 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::manage {
    public fun create_flash_loan_asset<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg2), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::reserve_not_found());
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, arg4);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_coin_type());
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::create_asset(arg1, arg4, v0, 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg3)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun create_flash_loan_config(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::create_config(arg1);
    }

    public fun set_flash_loan_asset_max<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: u64) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::set_asset_max(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_min<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: u64) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::set_asset_min(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_rate_to_supplier<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: u64) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::set_asset_rate_to_supplier(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    public fun set_flash_loan_asset_rate_to_treasury<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg2: u64) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::set_asset_rate_to_treasury(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg2);
    }

    // decompiled from Move bytecode v6
}

