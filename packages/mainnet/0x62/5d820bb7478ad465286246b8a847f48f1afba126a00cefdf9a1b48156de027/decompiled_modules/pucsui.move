module 0x625d820bb7478ad465286246b8a847f48f1afba126a00cefdf9a1b48156de027::pucsui {
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

