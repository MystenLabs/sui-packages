module 0xaa7b998baf3bcba4b9fffcf7b156cc5e1231fa6e1381828ecb6ab4b526450561::puss {
    struct PUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSS>(arg0, 6, b"PUSS", b"$PUSS", b"$PUSS is the first memecoin from one of the largest blockchain-based social media platforms, Steemit . Bloggers on Steemit will be able to boost their blogging rewards & enjoy various features by utilizing the token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUSS_TQ_Rx_QN_ls9y5l_Dj_Loeb_a7376b00d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

