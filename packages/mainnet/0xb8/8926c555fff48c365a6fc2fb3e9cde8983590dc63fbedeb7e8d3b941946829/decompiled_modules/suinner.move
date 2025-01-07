module 0xb88926c555fff48c365a6fc2fb3e9cde8983590dc63fbedeb7e8d3b941946829::suinner {
    struct SUINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNER>(arg0, 6, b"SUINNER", b"$SUINNER", b"The combination of MovePump and Sui into a fidget spinner creates a highly powerful community that is always in motion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_gerak_9ca8c6ed39.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

