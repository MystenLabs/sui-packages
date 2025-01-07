module 0xa96a2c21dfe08f6e84e2c459ae8c4111d601cc5583253df6a7c2c0b07a1a8e18::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"ZOMBIE", b"ZOMBIE ON SUI", x"4255592c20484f4c442c20454e4a4f5920504c4159494e472047414d450a5a4f4d42494520544f20544845204d4f4f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_3_b8d64cc3d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

