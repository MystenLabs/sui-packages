module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &ProtocolFeeCap, arg1: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::verify_version(arg1);
        let v0 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::get_protocol_fee_for_coin_a<T0, T1>(arg2);
        let v1 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::get_protocol_fee_for_coin_b<T0, T1>(arg2);
        assert!(arg3 <= v0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_amount());
        assert!(arg4 <= v1, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_amount());
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::set_protocol_fee_coin_a<T0, T1>(arg2, v0 - arg3);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::set_protocol_fee_coin_b<T0, T1>(arg2, v1 - arg4);
        let (v2, v3) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::withdraw_balances<T0, T1>(arg2, arg3, arg4);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T0>(v2, arg5, arg6);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T1>(v3, arg5, arg6);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_protocol_fee_claimed(0x2::object::id<0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>>(arg2), 0x2::tx_context::sender(arg6), arg5, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ProtocolFeeCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v2);
        0x2::transfer::transfer<ProtocolFeeCap>(v1, v2);
    }

    public entry fun transer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_admin_cap_transfer_event(arg1);
    }

    public entry fun transer_protocol_fee_cap(arg0: ProtocolFeeCap, arg1: address) {
        0x2::transfer::transfer<ProtocolFeeCap>(arg0, arg1);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::events::emit_protocol_fee_cap_transfer_event(arg1);
    }

    // decompiled from Move bytecode v6
}

