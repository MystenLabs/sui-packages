module 0x3ffb7d1b8aea97bc65fc82e919b7db71fd5887eb170386a9d50937ca42e92eb::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 6, b"SSL", b"Steven Suigal", b"The secret is not to act, but to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stevensuigal_6d61a3c3fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

