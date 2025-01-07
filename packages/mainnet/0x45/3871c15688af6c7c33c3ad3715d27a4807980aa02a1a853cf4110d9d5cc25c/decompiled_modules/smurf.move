module 0x453871c15688af6c7c33c3ad3715d27a4807980aa02a1a853cf4110d9d5cc25c::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"BLUE SMURFCAT", b"Smurf Cat, Blue Mushroom Cat or We Live We Love We Lie, originally called  or Shailushai in English, is a meme that began on the Russian speaking internet which gained popularity on TikTok in August 2023.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3820_4eb25e3533.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

