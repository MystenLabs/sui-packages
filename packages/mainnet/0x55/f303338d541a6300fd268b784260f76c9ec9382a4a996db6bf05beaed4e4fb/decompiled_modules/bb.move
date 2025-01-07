module 0x55f303338d541a6300fd268b784260f76c9ec9382a4a996db6bf05beaed4e4fb::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"Beer Bird", b"To foster a fun and inclusive community of crypto enthusiasts who appreciate humor, meme culture, and the joy of a cold one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_54a3ccd7_4249_43f8_90ff_4ff4a1478b1a_png_358c46e182.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

