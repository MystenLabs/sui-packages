module 0xc16e20d1049876183c47faadc9ff6945e2c1fa4fb6886b7fe901f83bda87210c::bbnny {
    struct BBNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBNNY>(arg0, 6, b"BBNNY", b"BOLD BUNNY", b"Hopping into the meme game with confidence and speed. Bold Bunny is here for the big wins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_041648305_89b0d3eae3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

