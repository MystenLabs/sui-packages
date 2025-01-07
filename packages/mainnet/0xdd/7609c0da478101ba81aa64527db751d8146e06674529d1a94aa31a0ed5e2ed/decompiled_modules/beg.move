module 0xdd7609c0da478101ba81aa64527db751d8146e06674529d1a94aa31a0ed5e2ed::beg {
    struct BEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEG>(arg0, 6, b"BEG", b"BEEGG", b"LET'S GO TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_5b32c5a6bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

