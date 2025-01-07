module 0xc4169b767527c4ca289e6f0e4b269fb9172e941f0a5c5d3e352f1413ed290f6::banzai {
    struct BANZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANZAI>(arg0, 6, b"BANZAI", b"Banzai Cats Club", b"Banzai Cats Club is your new favorite meme coin on the #SUI Network platform! Let the word \"BANZAI\" become your motto, a symbol of swiftness and determination. Ready for a sudden rise and exciting adventures?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/android_chrome_512x512_23e20aa44d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

