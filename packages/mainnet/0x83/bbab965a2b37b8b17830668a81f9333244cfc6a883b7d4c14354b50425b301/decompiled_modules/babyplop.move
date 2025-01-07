module 0x83bbab965a2b37b8b17830668a81f9333244cfc6a883b7d4c14354b50425b301::babyplop {
    struct BABYPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPLOP>(arg0, 6, b"BABYPLOP", b"BabyPlop", b"A little plop of my mum $PLOP 7.41M, sent me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_48_38_6350ad8e49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

