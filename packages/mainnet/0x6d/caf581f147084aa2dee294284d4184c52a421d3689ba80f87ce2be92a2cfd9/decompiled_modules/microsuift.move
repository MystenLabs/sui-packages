module 0x6dcaf581f147084aa2dee294284d4184c52a421d3689ba80f87ce2be92a2cfd9::microsuift {
    struct MICROSUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICROSUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICROSUIFT>(arg0, 6, b"MICROSUIFT", b"Microsuift", b"Whether youre sharing laughs or trading memes, Microsuift encourages creativity and connection, making it more than just a currencyit's a movement. Join the fun and be part of the meme revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Microsuift_26b315f893.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICROSUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICROSUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

