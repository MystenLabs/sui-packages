module 0x89ed54802577d310cb070566b761ac4ccce01f7d2124dca0e58c0a3bb6cfd313::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"SUI ZILLA", b"In 2024, SUI grew like Godzilla awakening from the depths of the sea. Thats why this meme named SUI ZILLA, representing SUI strength and immortality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/04e94a05_30a3_4f24_a681_421e8bff954d_6aba106aa6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

