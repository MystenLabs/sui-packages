module 0xd14c6faa37a3cd25eeb48c3bfeaf4444e57df5e8135ac7143b79718e6bd62d8e::aaacat {
    struct AAACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACAT>(arg0, 6, b"AAACAT", b"aaaCatSui", b"Can't stop won't stop (thinking about Sui) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731026316285.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAACAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

