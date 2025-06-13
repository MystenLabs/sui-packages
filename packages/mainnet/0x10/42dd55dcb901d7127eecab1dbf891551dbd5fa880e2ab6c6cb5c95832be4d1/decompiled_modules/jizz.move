module 0x1042dd55dcb901d7127eecab1dbf891551dbd5fa880e2ab6c6cb5c95832be4d1::jizz {
    struct JIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIZZ>(arg0, 6, b"JIZZ", b"JIZZ DOGE", b"Before there was Doge, there was JIZZ DOGE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jizz_doge_logo_fabf8511f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

