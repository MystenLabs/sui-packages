module 0x81df71f3de1b260c3665bc54c6d34cea8d90fe07335ff8071f989fce0adfd750::sumika {
    struct SUMIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMIKA>(arg0, 6, b"SUMIKA", b"Sumika Meme", b"Yo, its #SUMIKA in the #SUI  house! Im not your kawaii idol, Im here to flip coins, vibe hard, and send it straight to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/buy4_ceb24aedda.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

