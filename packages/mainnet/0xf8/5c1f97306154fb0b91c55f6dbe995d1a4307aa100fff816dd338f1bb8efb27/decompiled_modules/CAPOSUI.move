module 0xf85c1f97306154fb0b91c55f6dbe995d1a4307aa100fff816dd338f1bb8efb27::CAPOSUI {
    struct CAPOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOSUI>(arg0, 9, b"CAPOSUI", b"CAPOSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPOSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPOSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPOSUI>>(0x2::coin::mint<CAPOSUI>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

