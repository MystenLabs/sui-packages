module 0x4957dc9fc1467af1c3ee66835dc8b2e4140a02df45c8afe1ecf0e607aa75ded4::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<S>(arg0, 9, untag(b"SS"), untag(b"NAgent S"), untag(b"D||{\"twitter\":\"https://x.com/0xAgent_S\",\"website\":\"https://agent-s.site/\",\"telegram\":\"https://t.me/agentS_portal\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihv24f67hkr26y35qnrdviex7czq6mrw6k4uxiiix3wnwehk523hy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<S>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<S>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<S>>(0x2::coin::mint<S>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

