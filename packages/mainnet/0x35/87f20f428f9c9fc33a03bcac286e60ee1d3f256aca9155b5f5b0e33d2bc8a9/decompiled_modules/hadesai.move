module 0x3587f20f428f9c9fc33a03bcac286e60ee1d3f256aca9155b5f5b0e33d2bc8a9::hadesai {
    struct HADESAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADESAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADESAI>(arg0, 6, b"HADESAI", b"HadesAI", b"Original $HADES from @Hades__ai for future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2435_81eaaafc2f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADESAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HADESAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

