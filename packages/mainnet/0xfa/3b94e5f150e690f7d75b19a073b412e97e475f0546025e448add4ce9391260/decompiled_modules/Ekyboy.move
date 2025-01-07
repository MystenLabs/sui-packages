module 0xfa3b94e5f150e690f7d75b19a073b412e97e475f0546025e448add4ce9391260::Ekyboy {
    struct EKYBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EKYBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EKYBOY>(arg0, 6, b"EKYBOY", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EKYBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EKYBOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

