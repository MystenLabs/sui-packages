module 0x1ab1b13c70943d9d564e00961bfae974d56e5fd2c07bf4bfdd58de7ae190b453::higher {
    struct HIGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHER>(arg0, 6, b"HIGHER", b"Higher", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_D4_B04_B5_0477_4_C07_9103_350_B3_EB_3_BA_83_a878d02f04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

