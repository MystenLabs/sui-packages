module 0xf300d024edb85b05b8845937b05f6624058406908439e8ddd4e5796ca75efd6e::sully {
    struct SULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULLY>(arg0, 6, b"SULLY", b"Sully the shrimp", x"4d65657420746865206b696e67206f6620746865207365610a0a53756c6c792074686520736872696d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logov2png_024fb2147c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

