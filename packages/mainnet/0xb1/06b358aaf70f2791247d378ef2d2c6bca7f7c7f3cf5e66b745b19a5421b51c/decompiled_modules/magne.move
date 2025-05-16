module 0xb106b358aaf70f2791247d378ef2d2c6bca7f7c7f3cf5e66b745b19a5421b51c::magne {
    struct MAGNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNE>(arg0, 6, b"Magne", b"Magnesui Shock", b"The electric shocking Pokemon. Now onto the battlefield to be greatest Pokemon in $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaqefvngrtvbxfstqtjldwqpq3ciyiwweqthm6ucu7cjcn36jk47i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

