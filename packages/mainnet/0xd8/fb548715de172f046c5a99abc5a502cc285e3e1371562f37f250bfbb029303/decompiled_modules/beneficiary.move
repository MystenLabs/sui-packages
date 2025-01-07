module 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_emergency(arg0), 302);
        assert!(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::get_mut_pool<T0, T1>(arg0, 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::event::withdrew_event(0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::global_id<T0, T1>(v0), 0xd8fb548715de172f046c5a99abc5a502cc285e3e1371562f37f250bfbb029303::factory::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

