module 0x2f11f9bfb359f6d4a338ce3d835d5d9c8565b2a42da977c2f827b0d14a4244ee::sha_bi_sui {
    struct SHA_BI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA_BI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA_BI_SUI>(arg0, 9, b"sha biSUI", b"sha bi Staked SUI", b"Stupid cunt in chinese ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/f5c18c1d-5165-410d-8e24-0d9a3c88b124/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA_BI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHA_BI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

