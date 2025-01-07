module 0x46a88db55b57ee7e1dc0b57b52d2615a692c0a403b893d609e42c36adeef24c6::milaween {
    struct MILAWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILAWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILAWEEN>(arg0, 6, b"Milaween", b"Milaween on Sui", b"Meet Milaween: The Helloween with Big Meme Energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/web11_e29d9b8e31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILAWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILAWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

