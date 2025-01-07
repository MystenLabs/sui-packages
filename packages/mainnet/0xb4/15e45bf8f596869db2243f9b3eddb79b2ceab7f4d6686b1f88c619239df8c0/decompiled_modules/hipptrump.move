module 0xb415e45bf8f596869db2243f9b3eddb79b2ceab7f4d6686b1f88c619239df8c0::hipptrump {
    struct HIPPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPTRUMP>(arg0, 6, b"HIPPTRUMP", b"HIPPO TRUMP", b" HIPPO TRUMP fuses HIPPO and TRUMP cultures into a meme coin. Utilizing blockchain tech and decentralized storage, it immortalizes memes while offering unique trading and engagement opportunities within a revolutionary digital culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4122_2aeedfbf24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

