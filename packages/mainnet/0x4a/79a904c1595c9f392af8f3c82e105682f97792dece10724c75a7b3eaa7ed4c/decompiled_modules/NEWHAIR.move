module 0x4a79a904c1595c9f392af8f3c82e105682f97792dece10724c75a7b3eaa7ed4c::NEWHAIR {
    struct NEWHAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWHAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWHAIR>(arg0, 9, b"NEWHAIR", b"NEWHAIR", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWHAIR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEWHAIR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWHAIR>>(0x2::coin::mint<NEWHAIR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

