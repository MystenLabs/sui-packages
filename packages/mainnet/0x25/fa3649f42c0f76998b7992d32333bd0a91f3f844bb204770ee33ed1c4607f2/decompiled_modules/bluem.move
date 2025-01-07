module 0x25fa3649f42c0f76998b7992d32333bd0a91f3f844bb204770ee33ed1c4607f2::bluem {
    struct BLUEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEM>(arg0, 6, b"BLUEM", b"BLUEM SUI", x"544845204649525354204e414d4520474956454e20544f20424c55454d205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5af74d0e7770f83770186b71f427bd2a_5eed88bb69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

