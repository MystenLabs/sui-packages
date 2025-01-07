module 0xa8143601fd845254dd5e97cdce05ad06b07f3ceebc2d4d56fa2168d6e057bf51::suiland {
    struct SUILAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAND>(arg0, 6, b"Suiland", b"Suiland 1.0", b"Suiland metaverse build on chain Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sefsefe_acf9fabab8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

