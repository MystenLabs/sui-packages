module 0xc33978b1495fe0919ae47762fdcd26265680bbfe197357ff147d22d4beddd7c7::zz2 {
    struct ZZ2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZ2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZ2>(arg0, 9, b"ZZ2", b"zz2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZ2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZ2>>(v1);
    }

    // decompiled from Move bytecode v6
}

