module 0x63d8feb9fbf7b5033e2ed217adceb3fc7b968effa60cb1015824a8eb0c2c050c::tote {
    struct TOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTE>(arg0, 6, b"TOTE", b"Sui ToTe", b"TOTE BAG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tote_5654ef5421.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

