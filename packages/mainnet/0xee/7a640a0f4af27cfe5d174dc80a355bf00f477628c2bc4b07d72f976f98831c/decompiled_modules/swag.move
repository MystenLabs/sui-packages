module 0xee7a640a0f4af27cfe5d174dc80a355bf00f477628c2bc4b07d72f976f98831c::swag {
    struct SWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAG>(arg0, 6, b"SWAG", b"Swag", b"Swag is a community-driven memecoin that combines style, humor, and the power of community to set new trends in the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046921_a1386ebe24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

