module 0xe8b6a7a01a4d840658b1b0c72e9f08f35f9bcb298a9a98bcbc59187e2ea20c26::BARSIK {
    struct BARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<BARSIK>(arg0, 2, b"BARSIK", b"Hasbulla's Cat", b"Hasbulla's Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/NTo_mg5TqrUqWxcwVLLjd5zEEwWsny6HH8RO6c6fPXo?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARSIK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<BARSIK>>(v1, @0x7c3c58155b85c3ecf4864777fce255a7e405ffa3b6e443e736976588910f0e8d);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BARSIK>(&mut v3, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSIK>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<BARSIK>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<BARSIK>(arg0, v1)) {
                0x2::coin::deny_list_add<BARSIK>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

