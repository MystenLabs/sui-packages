module 0xbd6b6d00ea3cd2afa99c5cd5c5127adc79d3ca2b89df958180176c03c127ca3b::TITANX {
    struct TITANX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TITANX>(arg0, 2, b"TITANX", b"TITANX", b"TITANX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/qe-shhzMEwSlD6I3o2MUvLitN8i_CRYjZHUbj9gvdyo?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITANX>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TITANX>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TITANX>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANX>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TITANX>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<TITANX>(arg0, v1)) {
                0x2::coin::deny_list_add<TITANX>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

