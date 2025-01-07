module 0xf31c0457a2928a3af7a3a2aa61dd19498fa6749cd5ea27be43beca44c7da7ea8::talisman {
    struct TALISMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALISMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALISMAN>(arg0, 9, b"TALISMAN", b"Magic Talisman", b"God Ra eye spiritual amulet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JwJWOla.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TALISMAN>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALISMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TALISMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

