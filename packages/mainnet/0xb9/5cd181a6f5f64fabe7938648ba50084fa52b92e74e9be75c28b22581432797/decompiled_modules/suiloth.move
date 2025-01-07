module 0xb95cd181a6f5f64fabe7938648ba50084fa52b92e74e9be75c28b22581432797::suiloth {
    struct SUILOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOTH>(arg0, 6, b"SUILOTH", b"Suiloth", b"Suiloth The Sloth: moving slow, but aiming high.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiloth_ec954669b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

