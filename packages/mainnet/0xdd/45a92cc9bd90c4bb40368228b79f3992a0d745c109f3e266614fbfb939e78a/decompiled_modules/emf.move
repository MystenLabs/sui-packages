module 0xdd45a92cc9bd90c4bb40368228b79f3992a0d745c109f3e266614fbfb939e78a::emf {
    struct EMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMF>(arg0, 6, b"EMF", b"ELON MEME FUTURE", b"Elon mask like doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004427_eaaa47fda8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

