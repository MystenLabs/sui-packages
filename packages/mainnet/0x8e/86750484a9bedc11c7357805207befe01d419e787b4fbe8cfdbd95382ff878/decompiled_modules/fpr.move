module 0x8e86750484a9bedc11c7357805207befe01d419e787b4fbe8cfdbd95382ff878::fpr {
    struct FPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPR>(arg0, 6, b"FPR", b"Frogpider Sui", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/16e43d7f_cc36_4e4f_88af_aeff6ead7787_3181c9db01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

