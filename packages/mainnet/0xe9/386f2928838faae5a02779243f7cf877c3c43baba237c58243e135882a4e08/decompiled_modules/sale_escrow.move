module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::sale_escrow {
    struct EscrowOrder<phantom T0> has key {
        id: 0x2::object::UID,
        rev: u64,
        maker: address,
        item: 0x2::object::ID,
        ask: u64,
        bps: u16,
    }

    fun announce<T0>(arg0: &EscrowOrder<T0>, arg1: bool) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_posted(0x2::object::id<EscrowOrder<T0>>(arg0), arg0.maker, arg0.item, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x2::object::ID>(), arg0.ask, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.ask, arg0.bps), arg1);
    }

    public fun ask<T0>(arg0: &EscrowOrder<T0>) : u64 {
        arg0.ask
    }

    public fun cut<T0>(arg0: &EscrowOrder<T0>) : u64 {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.ask, arg0.bps)
    }

    public fun item<T0>(arg0: &EscrowOrder<T0>) : 0x2::object::ID {
        arg0.item
    }

    public fun maker<T0>(arg0: &EscrowOrder<T0>) : address {
        arg0.maker
    }

    fun open<T0: store + key>(arg0: EscrowOrder<T0>) : (T0, 0x2::object::ID, address, 0x2::object::ID, u64, u16) {
        let EscrowOrder {
            id    : v0,
            rev   : _,
            maker : v2,
            item  : v3,
            ask   : v4,
            bps   : v5,
        } = arg0;
        let v6 = v0;
        0x2::object::delete(v6);
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v6, v3), 0x2::object::uid_to_inner(&v6), v2, v3, v4, v5)
    }

    public fun post<T0: store + key>(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg0);
        assert!(arg2 != 0, 40);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = EscrowOrder<T0>{
            id    : 0x2::object::new(arg3),
            rev   : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::rev(),
            maker : 0x2::tx_context::sender(arg3),
            item  : v0,
            ask   : arg2,
            bps   : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::listing_bps(arg0),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v1.id, v0, arg1);
        announce<T0>(&v1, false);
        0x2::transfer::share_object<EscrowOrder<T0>>(v1);
        0x2::object::id<EscrowOrder<T0>>(&v1)
    }

    public fun pull<T0: store + key>(arg0: EscrowOrder<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.maker == 0x2::tx_context::sender(arg1), 10);
        let (v0, v1, v2, v3, v4, _) = open<T0>(arg0);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_withdrawn(v1, v2, v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x2::object::ID>(), v4);
        v0
    }

    public fun reprice<T0: store + key>(arg0: &mut EscrowOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(arg0.maker == 0x2::tx_context::sender(arg3), 10);
        assert!(arg2 != 0, 40);
        arg0.ask = arg2;
        arg0.bps = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::listing_bps(arg1);
        announce<T0>(arg0, true);
    }

    public fun take<T0: store + key>(arg0: EscrowOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.ask, 30);
        let (v0, v1, v2, v3, v4, v5) = open<T0>(arg0);
        let v6 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(v4, v5);
        let v7 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v4);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(0x2::balance::split<0x2::sui::SUI>(&mut v7, v6), 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::treasury(arg1), arg3);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v7, v2, arg3);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_filled(v1, v2, 0x2::tx_context::sender(arg3), v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), v4, v6, 0);
        v0
    }

    // decompiled from Move bytecode v7
}

