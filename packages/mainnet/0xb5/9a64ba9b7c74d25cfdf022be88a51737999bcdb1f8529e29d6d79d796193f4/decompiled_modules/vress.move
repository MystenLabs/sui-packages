module 0xb59a64ba9b7c74d25cfdf022be88a51737999bcdb1f8529e29d6d79d796193f4::vress {
    struct VRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRESS>(arg0, 6, b"VRESS", b"Vress", x"56726573732069732074686520736d616c6c65737420736861726b206f6e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7728_de25cb195a_788444908e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

