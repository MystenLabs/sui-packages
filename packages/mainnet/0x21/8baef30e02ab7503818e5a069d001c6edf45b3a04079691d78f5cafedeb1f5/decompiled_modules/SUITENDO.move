module 0x218baef30e02ab7503818e5a069d001c6edf45b3a04079691d78f5cafedeb1f5::SUITENDO {
    struct SUITENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITENDO>(arg0, 9, b"SUITENDO", b"SUITENDO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITENDO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITENDO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITENDO>>(0x2::coin::mint<SUITENDO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

