module 0xb6999aeba60f671a87ead9f7996c290484d23d8c9f9841239dbfc99d5c10e15b::b_tk_sui {
    struct B_TK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TK_SUI>(arg0, 9, b"btkSUI", b"bToken tkSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

