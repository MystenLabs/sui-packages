module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &ProtocolFeeCap, arg1: &0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::GlobalConfig, arg2: &mut 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::config::verify_version(arg1);
        let v0 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::get_protocol_fee_for_coin_a<T0, T1>(arg2);
        let v1 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::get_protocol_fee_for_coin_b<T0, T1>(arg2);
        assert!(arg3 <= v0, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::insufficient_amount());
        assert!(arg4 <= v1, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::insufficient_amount());
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::set_protocol_fee_amount<T0, T1>(arg2, v0 - arg3, v1 - arg4);
        let (v2, v3) = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::withdraw_balances<T0, T1>(arg2, arg3, arg4);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T0>(v2, arg5, arg6);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::utils::transfer_balance<T1>(v3, arg5, arg6);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_protocol_fee_collected(0x2::object::id<0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::Pool<T0, T1>>(arg2), 0x2::tx_context::sender(arg6), arg5, arg3, arg4, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::pool::sequence_number<T0, T1>(arg2));
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
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_admin_cap_transfer_event(arg1);
    }

    public entry fun transer_protocol_fee_cap(arg0: ProtocolFeeCap, arg1: address) {
        0x2::transfer::transfer<ProtocolFeeCap>(arg0, arg1);
        0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::events::emit_protocol_fee_cap_transfer_event(arg1);
    }

    // decompiled from Move bytecode v6
}

