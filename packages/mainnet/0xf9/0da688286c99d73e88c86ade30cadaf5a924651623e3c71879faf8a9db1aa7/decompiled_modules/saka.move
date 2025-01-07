module 0xf90da688286c99d73e88c86ade30cadaf5a924651623e3c71879faf8a9db1aa7::saka {
    struct SAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKA>(arg0, 9, b"SAKA", x"5355492057494620414b4120e1a195e1a0b5e38387e6b094e4baa0", b"SUI WIF AKA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAKA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKA>>(v2, @0x58b81996937477af46f7139c5d8b4c91bc94f73bbf36e03b6bf36f8e8b1b33d0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

