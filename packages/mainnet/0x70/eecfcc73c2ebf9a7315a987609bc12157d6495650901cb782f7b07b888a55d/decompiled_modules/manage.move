module 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::manage {
    public fun create_flash_loan_asset<T0>(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::Config, arg2: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::Storage, arg3: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_reserves_count(arg2), 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::reserve_not_found());
        let v0 = 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::get_coin_type(arg2, arg4);
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == v0, 0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::error::invalid_coin_type());
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::create_asset(arg1, arg4, v0, 0x2::object::uid_to_address(0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::pool::uid<T0>(arg3)), arg5, arg6, arg7, arg8, arg9);
    }

    public fun create_flash_loan_config(arg0: &0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::storage::StorageAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xa49c5d1c8f0a9eaa4e1c0c461c2b5dfb6e88213876739e56db1afb3649a8af26::flash_loan::create_config(arg1);
    }

    // decompiled from Move bytecode v6
}

