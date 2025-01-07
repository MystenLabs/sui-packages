module 0xc4577d484229135d89ae09185f8899687fa222b42789f8a14c97da304a77f549::fartduck {
    struct FARTDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTDUCK>(arg0, 6, b"FARTDUCK", b"FARTDUCK2025", x"20464152544455434b200a20544845204d4f53542042554c4c4953482046415254494e47204455434b20494e2043525950544f20535041434520544841542057494c4c204252494e4720594f5520544f20544845204d4f4f4e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fart_oops_0987af2255.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

