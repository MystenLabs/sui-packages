module 0xc9a5204fe3cff8b04e3885a27f9dab571aaa080c4e34fbb1c9d15eb75509e6d::smama {
    struct SMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAMA>(arg0, 6, b"SMAMA", b"MAMA SUI", b"MAMA OF PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Nh7k_Rm_Wc_A_El_Okw_9b0f3fa0f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

