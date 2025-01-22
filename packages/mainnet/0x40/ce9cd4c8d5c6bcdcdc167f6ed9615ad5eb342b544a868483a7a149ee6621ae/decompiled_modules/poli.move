module 0x40ce9cd4c8d5c6bcdcdc167f6ed9615ad5eb342b544a868483a7a149ee6621ae::poli {
    struct POLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLI>(arg0, 6, b"POLI", b"POLITICAL", b"$POLI turns political chaos into profit. Trade, meme, and engage in weekly battles while shaping the narrative. A coin for the politically bold and meme-savvy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/politicalimage_c691721d40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

