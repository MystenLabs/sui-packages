module 0x24c661765b8d19a03a236b2f9f89cb4f0097ce5024100d20b47c8fc5f650c03d::banda {
    struct BANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDA>(arg0, 6, b"BANDA", b"Blizz Panda", b"Panda Blizz,  a fun meme token on SUI. Banda Bears NFT Collection is ready and will be released after bonding.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PEZ_9uom9u_R8_V4_Gn_C877_Mn_Xwa_Ve4_KHL_8_Zh_Wxyi_FL_Yy_N78_ef9564fd54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

