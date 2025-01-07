module 0x1d3a395b3127cbe3838c010f4f566bf6260b576cac9508b1e05b1062e57325dc::fucks {
    struct FUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKS>(arg0, 6, b"FUCKS", b"CryptoFuks", b"Cryptofuks is a generative 7777 piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_Xz_Pyw_W0_AA_08ir_ff05cf4942.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

