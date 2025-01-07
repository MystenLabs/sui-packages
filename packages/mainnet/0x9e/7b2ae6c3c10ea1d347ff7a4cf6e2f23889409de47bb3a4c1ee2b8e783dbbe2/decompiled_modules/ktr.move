module 0x9e7b2ae6c3c10ea1d347ff7a4cf6e2f23889409de47bb3a4c1ee2b8e783dbbe2::ktr {
    struct KTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTR>(arg0, 6, b"KTR", b"KOTARO", b"Fun token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Wc_RY_2b_YA_Adcc_E_e79f50f1f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

