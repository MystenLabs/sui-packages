module 0x4c19c3f17b9f1b66dd90d57ad6a0f56bba356abe593573899b038a2c8d5210df::eih {
    struct EIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIH>(arg0, 6, b"EIH", b"EVERYONE IS HAPPY", x"4d6167696320636f696e20746861742063616e206d616b652070656f706c652068617070792e20536f6369616c204d656469612077696c6c2062652063726561746564206c617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HAPPY_cfc71f079a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIH>>(v1);
    }

    // decompiled from Move bytecode v6
}

