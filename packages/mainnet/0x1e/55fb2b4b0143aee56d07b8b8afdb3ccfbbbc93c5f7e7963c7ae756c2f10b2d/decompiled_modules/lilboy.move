module 0x1e55fb2b4b0143aee56d07b8b8afdb3ccfbbbc93c5f7e7963c7ae756c2f10b2d::lilboy {
    struct LILBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILBOY>(arg0, 6, b"LILBOY", b"LIL BOY SUI", b"Furry's Folly, A Whimsical Journey of LilBoy: Small Meme, Big Dreams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_16_04_08_757901a173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

