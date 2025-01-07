module 0x90335bc67759402be03c121992edbd0fa4fc563f9118ed13d19ed4d9dd831ecb::suibidi {
    struct SUIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIDI>(arg0, 6, b"SUIBIDI", b"SUIBIDI TOILET", b"Suibidi is a parody of Skibidi Toiletis amachinimaweb seriesreleased throughYouTube, Suibidi is first skibidi Toilet on Sui meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOLIR_8b0adea5fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

