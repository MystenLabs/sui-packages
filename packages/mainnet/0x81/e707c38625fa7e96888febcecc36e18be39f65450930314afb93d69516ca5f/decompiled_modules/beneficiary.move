module 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::is_emergency(arg0), 302);
        assert!(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::get_mut_pool<T0, T1>(arg0, 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::event::withdrew_event(0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::global_id<T0, T1>(v0), 0x81e707c38625fa7e96888febcecc36e18be39f65450930314afb93d69516ca5f::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

