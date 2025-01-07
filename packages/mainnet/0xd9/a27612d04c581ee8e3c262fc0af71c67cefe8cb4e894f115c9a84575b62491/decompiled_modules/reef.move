module 0xd9a27612d04c581ee8e3c262fc0af71c67cefe8cb4e894f115c9a84575b62491::reef {
    struct REEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEF>(arg0, 6, b"REEF", b"Carl Reefer", b"Carl reefer! He is moral with coral. He is always protective of his reef.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/reef_51714c5406.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

