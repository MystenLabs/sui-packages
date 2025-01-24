module 0xed2425f990ea05a13b2c8813e170e0e3f8038e40186459c0270d03bb8a232107::HUDO {
    struct HUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUDO>(arg0, 9, b"HUDO", b"HUDO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUDO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HUDO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<HUDO>>(0x2::coin::mint<HUDO>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

