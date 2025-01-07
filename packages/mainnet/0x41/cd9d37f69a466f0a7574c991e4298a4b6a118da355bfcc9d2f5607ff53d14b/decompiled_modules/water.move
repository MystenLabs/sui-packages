module 0x41cd9d37f69a466f0a7574c991e4298a4b6a118da355bfcc9d2f5607ff53d14b::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"Water", b"Water Emoji", b"Is the first water Emoji reflecting the hot narative in the meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sweat_droplets_d47a3013c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

