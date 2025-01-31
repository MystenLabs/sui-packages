module 0x66c88d3510876a638a66338bf0d19fabe281d6610f2b4394b8b29ef1aacd00c5::HPL {
    struct HPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPL>(arg0, 9, b"HPL", b"HPL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HPL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HPL>>(0x2::coin::mint<HPL>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

