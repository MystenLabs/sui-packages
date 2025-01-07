module 0xf009c1a0ac9b3b085a1e6d60ecb62f89f21bfbab272999b4bd8ae7444431e7ec::suiczu {
    struct SUICZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICZU>(arg0, 6, b"SUICZU", b"SuiCzu", b"SuiCzu the breed found only on the Sui network, its so rare it only appears every 10th generation of Shih tzu families, don't let this be unnoticed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_6bb882bf8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

