module 0xa8f1f7366c27be20f0c24bdc96fb22ea54fab311d166ad5a9a4967f71602b776::dola {
    struct DOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOLA>(arg0, 6, b"DOLA", b"Dolphin Agent", x"f09f92ab2032342f37204461746120547261636b696e672ef09f91be2041492052616461722053797374656d2ef09f939d2050726f636573736564204461746120416e616c797369732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2_5334db3347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

