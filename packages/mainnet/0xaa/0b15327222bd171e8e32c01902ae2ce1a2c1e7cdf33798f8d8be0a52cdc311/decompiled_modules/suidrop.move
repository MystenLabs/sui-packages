module 0xaa0b15327222bd171e8e32c01902ae2ce1a2c1e7cdf33798f8d8be0a52cdc311::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SUIDROP", b"Suidrop", b"Dropping on the Sui Network, $SUIDROP is a connection drop. Strong, secure, and unbreakable, this drop keeps everything flowing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070561_e2586751f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

