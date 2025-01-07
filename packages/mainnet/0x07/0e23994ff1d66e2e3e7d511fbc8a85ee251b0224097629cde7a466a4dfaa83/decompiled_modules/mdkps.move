module 0x70e23994ff1d66e2e3e7d511fbc8a85ee251b0224097629cde7a466a4dfaa83::mdkps {
    struct MDKPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDKPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDKPS>(arg0, 6, b"Mdkps", b"MudkipsOnSui", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956852537.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDKPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDKPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

