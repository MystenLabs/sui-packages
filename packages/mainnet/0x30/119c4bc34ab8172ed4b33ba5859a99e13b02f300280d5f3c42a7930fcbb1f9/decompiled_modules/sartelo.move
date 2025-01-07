module 0x30119c4bc34ab8172ed4b33ba5859a99e13b02f300280d5f3c42a7930fcbb1f9::sartelo {
    struct SARTELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARTELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARTELO>(arg0, 6, b"SArtelo", b"Artelo", b"Artelo on SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GK_Hvpxd_WUA_Ee8_YJ_27925c74fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARTELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARTELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

