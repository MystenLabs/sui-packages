module 0x594f2242496aa44237cdf4901aff44777d15ff3ace133a6cb12a5c1cb5f2eec7::sdrm {
    struct SDRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRM>(arg0, 6, b"SDRM", b"SUIDREAM", x"0a28447265616d74616c652f447265616d204e696768746d617265290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZV_Kif_Q_Xs_AA_7g_F0_13bf3cc0bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

