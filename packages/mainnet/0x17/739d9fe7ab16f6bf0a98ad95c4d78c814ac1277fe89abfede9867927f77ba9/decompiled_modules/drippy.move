module 0x17739d9fe7ab16f6bf0a98ad95c4d78c814ac1277fe89abfede9867927f77ba9::drippy {
    struct DRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPPY>(arg0, 6, b"DRIPPY", b"Drippy on SUI", b"#Drippy just launched on the #Sui ecosystem, grab some $Drippy while early", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ya_s_Gbbc_AA_5a_K_6f1ca4ae07_a1e38707b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

