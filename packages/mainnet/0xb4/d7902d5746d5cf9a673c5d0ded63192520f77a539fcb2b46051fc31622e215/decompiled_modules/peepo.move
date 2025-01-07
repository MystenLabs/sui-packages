module 0xb4d7902d5746d5cf9a673c5d0ded63192520f77a539fcb2b46051fc31622e215::peepo {
    struct PEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPO>(arg0, 6, b"PEEPO", b"Peepo Rise", b"The son of $Pepe $Peepo new memecoin on #Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_00_33_42_4b27af0d7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

