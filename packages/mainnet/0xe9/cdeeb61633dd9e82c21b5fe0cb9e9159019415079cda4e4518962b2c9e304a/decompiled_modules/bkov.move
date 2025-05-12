module 0xe9cdeeb61633dd9e82c21b5fe0cb9e9159019415079cda4e4518962b2c9e304a::bkov {
    struct BKOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKOV>(arg0, 9, b"Bkov", b"Cak$", b"Ghjjncg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/dceb3210-2ef2-11f0-852e-3585a1f35c1e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKOV>>(v1);
        0x2::coin::mint_and_transfer<BKOV>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKOV>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

