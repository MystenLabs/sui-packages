module 0x59bfdb6d2f355780baf5d10197b580aaa1189a55582287e13dfa056d3154e5e::rgoo {
    struct RGOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGOO>(arg0, 6, b"RGOO", b"ROCKET GOOSE", b"Flapping its wings all the way to the moon, Rocket Goose is the meme coin of flight and might.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_041448678_8865632890.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RGOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

