module 0x3d46bf5e7507becfe67749a211984fb2d8cdcc47e84765a3ca4b6a3b42b297d5::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"MIZU", b"MIZU SUI", x"4d495a5520697320616e20657373656e7469616c20656c656d656e74206f66206c6966652066726f6d2074686520726963682063756c74757265206f6620746865204a6170616e6573652e0a456e6a6f79206f7572206f6e6c696e652067616d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0578_9000a5a134.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

