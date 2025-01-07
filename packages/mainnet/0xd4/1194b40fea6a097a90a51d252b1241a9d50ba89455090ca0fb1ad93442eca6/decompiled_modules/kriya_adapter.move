module 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::kriya_adapter {
    public fun swap<T0, T1>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::RouterAcl, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::access(arg2);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::bag_value::unwrap(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::bag_value::Value, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds");
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds", 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v4, 0x2::coin::value<T0>(&v4), 0, arg3));
        } else {
            let v5 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds");
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"funds", 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v5, 0x2::coin::value<T1>(&v5), 0, arg3));
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xd41194b40fea6a097a90a51d252b1241a9d50ba89455090ca0fb1ad93442eca6::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

