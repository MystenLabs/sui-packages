module 0x1ca953a7b8f6cf1831dbb2d13254a68e4d9f6d25165367add42d61fa97ba8992::shawujing {
    struct SHAWUJING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWUJING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWUJING>(arg0, 6, b"SHAWUJING", b"Sha Wujing", b"Residing in Flowing Sands River, Sha Wujing is the water spirit companion of Sun Wukong.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_203338_08dc0fd7d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWUJING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWUJING>>(v1);
    }

    // decompiled from Move bytecode v6
}

