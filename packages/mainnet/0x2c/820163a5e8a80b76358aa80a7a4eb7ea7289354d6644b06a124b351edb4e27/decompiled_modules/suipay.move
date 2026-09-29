module 0x2c820163a5e8a80b76358aa80a7a4eb7ea7289354d6644b06a124b351edb4e27::suipay {
    struct SUIPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIPAY>(arg0, 6, 0x1::string::utf8(b"SUIPAY"), 0x1::string::utf8(b"SuiPay"), 0x1::string::utf8(b"Suipay free to transfer funds or get funds"), 0x1::string::utf8(b"https://popularsui.xyz/media/cdd440b571743cd1d49b0b70be656d62c756bcc82cd306dcd8f4c5bc0be5fadd.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIPAY>>(0x2::coin_registry::finalize<SUIPAY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

