module 0xb673820b7039372e176557c64cad1bebf872462a1a0d5ad292b37d75cc8ce32b::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVATAR>(arg0, 6, b"AVATAR", b"AVATARSUI", b"AVATARSUI on his whay save Crypto !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198375_9fbbf5875f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

