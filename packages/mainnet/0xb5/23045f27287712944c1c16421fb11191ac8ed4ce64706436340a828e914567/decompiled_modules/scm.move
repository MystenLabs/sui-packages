module 0xb523045f27287712944c1c16421fb11191ac8ed4ce64706436340a828e914567::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"Scam vcl luon", b"muadiditmechungmay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apple_logo_png_5a36c9d60de9a7_317118621513540054057_cdc0505893.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

