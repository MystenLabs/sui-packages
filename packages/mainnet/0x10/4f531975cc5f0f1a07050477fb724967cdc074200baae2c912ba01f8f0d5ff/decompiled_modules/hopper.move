module 0x104f531975cc5f0f1a07050477fb724967cdc074200baae2c912ba01f8f0d5ff::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"Hopper", b"Hopper the rabbit", x"5468652066617374657374206372656174757265206f6e200a405375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoper_68199ebfbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

