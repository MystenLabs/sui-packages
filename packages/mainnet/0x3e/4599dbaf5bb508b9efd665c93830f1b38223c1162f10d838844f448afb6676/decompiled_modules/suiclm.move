module 0x3e4599dbaf5bb508b9efd665c93830f1b38223c1162f10d838844f448afb6676::suiclm {
    struct SUICLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICLM>(arg0, 6, b"SuiCLM", b"SuiCAT Model", b"SuiCAT AI Agent Language Model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ba23d177_9eff_4d30_ac6d_67dab1c4a100_446bf3128f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

