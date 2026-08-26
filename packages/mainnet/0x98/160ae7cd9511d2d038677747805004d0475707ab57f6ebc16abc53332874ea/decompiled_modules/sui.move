module 0x98160ae7cd9511d2d038677747805004d0475707ab57f6ebc16abc53332874ea::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"SUI", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/7uixCz27z6AznDX7Tou9YE5y9XTyzAcFCodW43WL61oj")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v7
}

