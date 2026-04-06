module 0xe96dddf48eab0658be7d6fc1309f4be15b5c85cdf6b24da33d82f2f4c20d8359::beta_token {
    struct BETA_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETA_TOKEN>(arg0, 8, b"BETA", b"BETA Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETA_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<BETA_TOKEN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETA_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

