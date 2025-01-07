module 0x9e1bb1d460564761bd102299ec3d92ebd0ac8d124746ff622e54dbb5192e367::sue {
    struct SUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUE>(arg0, 6, b"SUE", b"Sui emoji", b"Sui emoji is an emoji memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1501_e45d419e64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

