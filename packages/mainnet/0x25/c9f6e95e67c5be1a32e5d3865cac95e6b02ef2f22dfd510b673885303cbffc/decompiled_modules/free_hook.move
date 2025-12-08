module 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::free_hook {
    struct FreeHook has drop {
        dummy_field: bool,
    }

    public fun free_balance<T0>(arg0: &mut 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::distributor::ClaimedBalance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::distributor::hook_call_info<T0, FreeHook>(arg0);
        let v1 = 0x2::bcs::new(0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::distributor::calldata(&v0));
        let v2 = FreeHook{dummy_field: false};
        0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::distributor::extract_claimed_balance<T0, FreeHook>(arg0, v2, 0x2::bcs::peel_u64(&mut v1))
    }

    public fun free_coin<T0>(arg0: &mut 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::distributor::ClaimedBalance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(free_balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

