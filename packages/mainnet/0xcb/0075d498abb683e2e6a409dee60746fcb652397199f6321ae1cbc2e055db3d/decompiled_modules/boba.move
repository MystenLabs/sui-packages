module 0xcb0075d498abb683e2e6a409dee60746fcb652397199f6321ae1cbc2e055db3d::boba {
    struct BOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBA>(arg0, 6, b"BOBA", b"Boba Cat", b"Boba Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/booba_64f785bfb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

