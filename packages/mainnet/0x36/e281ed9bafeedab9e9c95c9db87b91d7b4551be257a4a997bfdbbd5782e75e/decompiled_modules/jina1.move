module 0x36e281ed9bafeedab9e9c95c9db87b91d7b4551be257a4a997bfdbbd5782e75e::jina1 {
    struct JINA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINA1>(arg0, 6, b"Jina1", b"jinax", b"hopefulysdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UE_1_A5p8u_400x400_f789d82f84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

