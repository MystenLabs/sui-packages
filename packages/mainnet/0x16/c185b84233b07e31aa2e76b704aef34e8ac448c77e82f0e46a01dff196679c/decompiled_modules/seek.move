module 0x16c185b84233b07e31aa2e76b704aef34e8ac448c77e82f0e46a01dff196679c::seek {
    struct SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEK>(arg0, 6, b"Seek", b"deepseek", b"deepseek New AI brings new heights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/efa17eab45d5f24b381513f9d3d3ea0_3f2cf3eca2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

