module 0xecf01513468b4d72eed81733749301ee1a63ffd204bf7347f518f237d3356a3e::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZ>(arg0, 6, b"BUZZ", b"$BUZZ SUI MEME$", b"Enjoy, invest, earn, and reach for the stars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Buzzz_fab103ebfc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

