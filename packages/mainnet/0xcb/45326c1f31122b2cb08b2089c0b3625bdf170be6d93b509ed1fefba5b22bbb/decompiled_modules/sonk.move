module 0xcb45326c1f31122b2cb08b2089c0b3625bdf170be6d93b509ed1fefba5b22bbb::sonk {
    struct SONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONK>(arg0, 6, b"Sonk", b"Bonk Sui", b"Sui Bonk. Bonk Bonk Bonk Bonk CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6966_df99022787.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

