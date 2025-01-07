module 0x1f4922d7e7ecea65a7e9e730ba3790fea19eccdd2efb26c1bce3cdde6e2fe5a7::BULLY {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<BULLY>(arg0, 2, b"BULLY", b"BULLY", b"BULLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/86QFooCNwKjlZZVZEg3lCboRTfEfxe4I0EPE_wk1yyQ?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<BULLY>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BULLY>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<BULLY>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<BULLY>(arg0, v1)) {
                0x2::coin::deny_list_add<BULLY>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

