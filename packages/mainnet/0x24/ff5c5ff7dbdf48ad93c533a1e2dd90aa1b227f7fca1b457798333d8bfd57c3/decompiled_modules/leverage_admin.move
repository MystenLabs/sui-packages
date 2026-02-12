module 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_admin {
    public fun inject_protocol_caller_cap(arg0: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::AdminCap, arg1: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::LeverageApp, arg2: 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::PackageCallerCap) {
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::accept_protocol_caller_cap(arg1, arg2);
    }

    public fun onboard_market<T0>(arg0: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::AdminCap, arg1: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::assert_emode_group_exists<T0>(arg1, arg2);
        0x2::transfer::public_share_object<0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::LeverageMarket>(0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_market::new_market(0x2::object::id<0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::market::Market<T0>>(arg1), arg2, arg3));
    }

    public fun remove_protocol_caller_cap(arg0: &0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::AdminCap, arg1: &mut 0x7f95f91d4e21a5f9c0f1699242bc39c7f83da7b1b74e8629dda083d639542229::app::ProtocolApp, arg2: &mut 0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::LeverageApp) {
        0x24ff5c5ff7dbdf48ad93c533a1e2dd90aa1b227f7fca1b457798333d8bfd57c3::leverage_app::revoke_protocol_caller_cap(arg2, arg1);
    }

    // decompiled from Move bytecode v6
}

