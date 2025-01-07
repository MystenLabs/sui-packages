module 0xaea1c73b5db3c093fa63ca9f58571ac2e4f9c506ca20ac5cb23e18911426afaa::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASH>(arg0, 6, b"HASH", b"Hash On Sui", b"WE ARE BUILDING. BUY. HODL. BECOME A HASHTRONAUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_101402_20abb4defd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

