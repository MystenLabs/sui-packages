module 0xd7e5ff6519a78a0d8821d2d10240cda0ff1d40751fb6def14e90da22238c17e4::dcat {
    struct DCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCAT>(arg0, 6, b"DCAT", b"Dancing cat on sui", x"44616e63696e672063617420244443415420697320676f696e6720746f20626520737465616c7468206c61756e63686564206f6e20737569210a54656c656772616d203a2068747470733a2f2f742e6d652f444341545355490a58203a2068747470733a2f2f782e636f6d2f44616e63696e676361747375690a57656273697465203a2068747470733a2f2f64616e63696e676361747375692e6d792e63616e76612e736974652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul11_20241214171403_9cb3cfb89e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

