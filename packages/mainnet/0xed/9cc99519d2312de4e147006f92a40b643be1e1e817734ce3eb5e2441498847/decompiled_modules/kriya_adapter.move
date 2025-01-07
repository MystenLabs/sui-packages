module 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::kriya_adapter {
    public fun swap<T0, T1>(arg0: &mut 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::StratsReceipt, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::RouterAcl, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg2);
        let v1 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::borrow_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::unwrap(0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1) == v2, 0);
        if (v3) {
            let v4 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(arg0, v0, b"funds");
            0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>>(arg0, b"funds", 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, v4, 0x2::coin::value<T0>(&v4), 0, arg3));
        } else {
            let v5 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(arg0, v0, b"funds");
            0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>>(arg0, b"funds", 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, v5, 0x2::coin::value<T1>(&v5), 0, arg3));
        };
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u8>(arg0, b"current_index", v1 + 1);
    }

    entry fun swap_entry<T0, T1, T2, T3>(arg0: &0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::RouterAcl, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::issue<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0))), arg4);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>>(&mut v0, b"funds", arg3);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"current_index", 0);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"final_index", 1);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), true));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2), true));
        let v1 = &mut v0;
        swap<T0, T1>(v1, arg1, arg0, arg4);
        let v2 = &mut v0;
        swap<T2, T3>(v2, arg2, arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T2>, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"funds"), 0x2::tx_context::sender(arg4));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"current_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"final_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::burn(v0);
    }

    public fun swap_entry_1<T0, T1, T2, T3>(arg0: &0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::RouterAcl, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::issue<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0))), arg6);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>>(&mut v0, b"funds", arg3);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"current_index", 0);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"final_index", 1);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), arg4));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 1, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2), arg5));
        let v1 = &mut v0;
        swap<T0, T1>(v1, arg1, arg0, arg6);
        let v2 = &mut v0;
        swap<T2, T3>(v2, arg2, arg0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T2>, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"funds"), 0x2::tx_context::sender(arg6));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"current_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"final_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::burn(v0);
    }

    public fun swap_entry_2<T0, T1, T2, T3>(arg0: &0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::RouterAcl, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::issue<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0))), arg6);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, 0x2::coin::Coin<T1>>(&mut v0, b"funds", arg3);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"current_index", 0);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<vector<u8>, u64>(&mut v0, b"final_index", 1);
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg1), arg4));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::add_data<u64, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::Value>(&mut v0, 1, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::bag_value::new(0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg2), arg5));
        let v1 = &mut v0;
        swap<T0, T1>(v1, arg1, arg0, arg6);
        let v2 = &mut v0;
        swap<T2, T3>(v2, arg2, arg0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T2>, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"funds"), 0x2::tx_context::sender(arg6));
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"current_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::remove_data<vector<u8>, u8, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::Access>(&mut v0, 0xed9cc99519d2312de4e147006f92a40b643be1e1e817734ce3eb5e2441498847::acl::access(arg0), b"final_index");
        0xbb63acc26794e3764cdc60b621af09053aa12ea0578dc7708466ddb91d4bb124::receipt::burn(v0);
    }

    // decompiled from Move bytecode v6
}

