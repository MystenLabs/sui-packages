module 0x192403adaf3d84d4df4f02e74d48f1f278ca64489f96d0e4c6d98a41be80551b::nifty {
    struct NIFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIFTY>(arg0, 6, b"Nifty", b"NiftySui", b"The neatest meme coin in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_084143228_6dd43480f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIFTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIFTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

