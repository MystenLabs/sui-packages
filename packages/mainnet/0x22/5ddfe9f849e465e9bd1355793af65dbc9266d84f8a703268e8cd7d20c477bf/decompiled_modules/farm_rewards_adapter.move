module 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::farm_rewards_adapter {
    public fun clmm_rewards_router<T0, T1, T2>(arg0: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::farm::Farm<T0>, arg2: &0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::RouterAcl, arg3: &0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::admin::ManageCap, arg4: &0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::access(arg2);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::borrow_data<vector<u8>, u8, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, _) = 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::bag_value::unwrap(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<u8, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::bag_value::Value, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::farm::Farm<T0>>(arg1) == v2, 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T2>, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, b"funds", 0x2::coin::zero<T2>(arg6));
        0x46a792d5ddc5d462b781fdcb2f421385e71f5ce112efc200243d3aaa5363bf4::admin::add_reward_balance<T0, T1>(arg3, arg1, 0x2::coin::into_balance<T1>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, b"funds")), arg4, arg5, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x225ddfe9f849e465e9bd1355793af65dbc9266d84f8a703268e8cd7d20c477bf::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

