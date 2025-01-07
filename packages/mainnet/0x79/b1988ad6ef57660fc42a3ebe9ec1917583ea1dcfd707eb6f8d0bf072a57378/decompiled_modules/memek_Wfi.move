module 0x79b1988ad6ef57660fc42a3ebe9ec1917583ea1dcfd707eb6f8d0bf072a57378::memek_Wfi {
    struct MEMEK_WFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_WFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_WFI>(arg0, 6, b"MEMEKWFI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_WFI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_WFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_WFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

