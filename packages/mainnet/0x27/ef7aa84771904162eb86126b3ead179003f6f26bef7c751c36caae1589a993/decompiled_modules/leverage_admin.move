module 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg2: 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::PackageCallerCap) {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg1);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun migrate(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp) : u64 {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::migrate(arg1)
    }

    public fun onboard_market<T0>(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp, arg2: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg1);
        0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::assert_emode_group_exists<T0>(arg2, arg3);
        let v0 = 0x2::object::id<0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::market::Market<T0>>(arg2);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::add_market(arg1, v0, arg3);
        0x2::transfer::public_share_object<0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::LeverageMarket>(0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_market::new_market(v0, arg3, arg4));
    }

    public fun remove_protocol_caller_cap(arg0: &0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::AdminCap, arg1: &mut 0xf619885d1fcaee3a6581881ab740e93ba919078e7cdc8247796b6934a8aeaa74::app::ProtocolApp, arg2: &mut 0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::LeverageApp) {
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::ensure_version_matches(arg2);
        0x27ef7aa84771904162eb86126b3ead179003f6f26bef7c751c36caae1589a993::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

