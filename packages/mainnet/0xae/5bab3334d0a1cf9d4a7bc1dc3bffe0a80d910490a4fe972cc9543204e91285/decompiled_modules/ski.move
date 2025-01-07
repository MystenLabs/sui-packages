module 0xae5bab3334d0a1cf9d4a7bc1dc3bffe0a80d910490a4fe972cc9543204e91285::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"Ski", b"ski", b"Ski is the most memeable dog on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_06_16_56_58_4c5114fcb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

