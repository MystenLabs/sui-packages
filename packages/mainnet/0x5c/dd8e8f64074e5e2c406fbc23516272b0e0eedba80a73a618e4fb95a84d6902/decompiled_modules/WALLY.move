module 0x5cdd8e8f64074e5e2c406fbc23516272b0e0eedba80a73a618e4fb95a84d6902::WALLY {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WALLY>(arg0, 2, b"WALLY", b"Emotional Support Alligator", b"Emotional Support Alligator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Q1pygPUbmSbzZmcvh1uREGaQZv-Y3i8c9R3i7E-BOVU?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WALLY>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WALLY>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<WALLY>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<WALLY>(arg0, v1)) {
                0x2::coin::deny_list_add<WALLY>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

