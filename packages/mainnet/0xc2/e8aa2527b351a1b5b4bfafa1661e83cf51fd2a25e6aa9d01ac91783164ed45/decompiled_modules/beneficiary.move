module 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::is_emergency(arg0), 302);
        assert!(0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::get_mut_pool<T0, T1>(arg0, 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::event::withdrew_event(0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::global_id<T0, T1>(v0), 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

