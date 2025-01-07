module 0xcf01e1ae3364318ed637bc97af2d1f09b7377cc4a3eb5e50c6a3fdbcd64d9d09::pucsui {
    struct PUCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCSUI>(arg0, 6, b"PUCSUI", b"PUSSYCAT on FIRE  (PUSUICAT)", b"I thought I saw a PUSSYCAT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_5b760886a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

