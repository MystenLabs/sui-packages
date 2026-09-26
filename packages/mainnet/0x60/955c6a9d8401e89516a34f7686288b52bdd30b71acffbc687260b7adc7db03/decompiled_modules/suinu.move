module 0x60955c6a9d8401e89516a34f7686288b52bdd30b71acffbc687260b7adc7db03::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUINU>(arg0, 6, 0x1::string::utf8(b"SUINU"), 0x1::string::utf8(b"sui inu"), 0x1::string::utf8(b"sui inu new memecoin on sui network"), 0x1::string::utf8(b"https://popularsui.xyz/media/6f5a7573d04fa4e90672ad54b0a15b3a1414f5b3f2b0136af078a69a466cef77.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUINU>>(0x2::coin_registry::finalize<SUINU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

