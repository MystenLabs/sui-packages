module 0x8dff0993f9b3bfb4da4fe6b2a1b3de9b8e741dc47b20930c1e16815b6c420886::SUIPUMP {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SUIPUMP>(arg0, 2, b"SPUMP", b"SUI PUMP", b"SUI PUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/yB6WhuSdu2sKN4xHIBQOmTBWvEFm8dqT-Pq9TsU5c3I?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SUIPUMP>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIPUMP>(&mut v3, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SUIPUMP>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<SUIPUMP>(arg0, v1)) {
                0x2::coin::deny_list_add<SUIPUMP>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

