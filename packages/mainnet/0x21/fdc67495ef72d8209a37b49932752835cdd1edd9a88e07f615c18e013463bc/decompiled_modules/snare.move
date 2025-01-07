module 0x21fdc67495ef72d8209a37b49932752835cdd1edd9a88e07f615c18e013463bc::snare {
    struct SNARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNARE>(arg0, 6, b"SNARE", b"Snare on sui", b"Time to hunt all bears.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241130_224538_810_d7a27f1046.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

