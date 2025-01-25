module 0xf1e5d7f8802bd783ade81a944fcc8e694257bf7209a462992f3d01ac01440f59::integ {
    struct INTEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTEG>(arg0, 6, b"INTEG", b"Integrate AI", x"496e74656772617465416c206973206275696c64696e6720416c20706f776572656420736f6c7574696f6e7320666f72206f7074696d6973696e67206461746120666c6f772e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737790940128.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INTEG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTEG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

