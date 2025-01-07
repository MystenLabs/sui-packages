module 0xcd06bdbd0c49bd798ecd07e7cf5ca9048d3347c194b7c451497816545b88b6a::ptnt {
    struct PTNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTNT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PTNT>(arg0, 3, b"PTNT", b"PORTOMASONET", b"PORTOMASONET is a coin for the PORTOMASONET project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/d7cFZXt/portomasonet.png")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTNT>>(v2);
        0x2::coin::mint_and_transfer<PTNT>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTNT>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

