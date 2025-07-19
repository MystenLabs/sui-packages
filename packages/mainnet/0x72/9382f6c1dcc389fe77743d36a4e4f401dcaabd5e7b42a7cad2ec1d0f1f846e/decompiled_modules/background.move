module 0x729382f6c1dcc389fe77743d36a4e4f401dcaabd5e7b42a7cad2ec1d0f1f846e::background {
    struct BACKGROUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACKGROUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACKGROUND>(arg0, 6, b"BACKGROUND", b"Bg on SUI", b"Bg on SUI - BACKGROUND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesflse5ds3wl4cfwd5zkvjtt6h56ohg5r4s3ohnw3ifflwjmpjbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACKGROUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BACKGROUND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

