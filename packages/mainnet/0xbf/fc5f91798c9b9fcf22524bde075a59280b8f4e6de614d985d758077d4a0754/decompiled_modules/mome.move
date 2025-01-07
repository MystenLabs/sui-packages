module 0xbffc5f91798c9b9fcf22524bde075a59280b8f4e6de614d985d758077d4a0754::mome {
    struct MOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOME>(arg0, 6, b"MOME", b"Movie of Meme", b"Movie of Meme  | The best memes brought to the SUI blockchain!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_05_22_29_12_82595f0144.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

