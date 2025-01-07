module 0xa5967f8590b5736292bc49118aa1763c42cb28be61194c0f37e73967f901ee8a::suimarine {
    struct SUIMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMARINE>(arg0, 6, b"SUIMARINE", b"SUBMARINE of SUI SEAS", b"SUIMARINE is ready to take you on an underwater adventure through the depths of the Sui network. Whether you're navigating the deep seas of crypto or exploring hidden treasures, SUIMARINE is built for those who love to go deep. Get ready to submerge and discover the riches lurking beneath the surface. Full steam ahead! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/preview_962738a029.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMARINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

