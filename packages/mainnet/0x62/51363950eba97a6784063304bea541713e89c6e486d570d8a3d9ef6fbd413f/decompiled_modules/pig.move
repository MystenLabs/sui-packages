module 0x6251363950eba97a6784063304bea541713e89c6e486d570d8a3d9ef6fbd413f::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"Pig", b"Sui pig", b"Welcome to the only pig in sui come and fill your fucking bags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088316_9714a96625.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

