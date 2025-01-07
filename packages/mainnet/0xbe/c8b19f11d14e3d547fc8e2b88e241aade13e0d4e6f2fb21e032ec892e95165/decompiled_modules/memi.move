module 0xbec8b19f11d14e3d547fc8e2b88e241aade13e0d4e6f2fb21e032ec892e95165::memi {
    struct MEMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMI>(arg0, 6, b"MEMI", b"Sui Memi", x"0a4d656d6920746f6b656e206f6e205355490a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mautache_7162450e60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

