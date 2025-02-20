module 0x6994df563bbd46966559f903a10d8fa07c9f069ad122d948b3a4d73af9f9cabe::token_factory {
    struct MANAGED_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun create_token(arg0: u64, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 18, 0);
        assert!(arg0 > 0, 1);
        let v0 = MANAGED_TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<MANAGED_TOKEN>(v0, arg1, arg2, arg3, arg4, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg5)), arg6);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED_TOKEN>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MANAGED_TOKEN>>(v2, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGED_TOKEN>>(0x2::coin::mint<MANAGED_TOKEN>(&mut v3, arg0, arg6), v4);
    }

    // decompiled from Move bytecode v6
}

