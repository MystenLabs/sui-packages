module 0xf882fa3f1bff9c5a48f1527283288f5ee4cc7b6ba54d33f5ad696fac4419da23::suineo {
    struct SUINEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEO>(arg0, 6, b"SUINEO", b"SUI NEO", x"537569204e656f20697320612066756e206d656d6520746f6b656e20696e7370697265642062790a74686520706c6179206f6e20776f726473206265747765656e202253756e656f2220616e640a225375692c22206c61756e63686564206f6e207468652053756920626c6f636b636861696e2e204974730a616c6c2061626f7574206272696e67696e672068756d6f7220616e64206372656174697669747920746f0a7468652063727970746f207370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profil_380423d11c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

