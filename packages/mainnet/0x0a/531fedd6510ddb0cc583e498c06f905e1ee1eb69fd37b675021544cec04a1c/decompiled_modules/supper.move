module 0xa531fedd6510ddb0cc583e498c06f905e1ee1eb69fd37b675021544cec04a1c::supper {
    struct SUPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPPER>(arg0, 6, b"SUPPER", b"The Last Supper", b"\"The Last Supper\" by Leonardo da Vinci, painted around 1495-1498, portrays Jesus Christ's final meal with his apostles, capturing the moment he announces his betrayal. Located in Milan, Italy, it's celebrated for its emotional depth and use of perspective, focusing on Jesus with the apostles reacting around him. Leonardo's techniques, while innovative, led to the painting's deterioration over time, yet it remains a fundamental piece of Renaissance art and Christian iconography.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1121_5f5a43654a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

