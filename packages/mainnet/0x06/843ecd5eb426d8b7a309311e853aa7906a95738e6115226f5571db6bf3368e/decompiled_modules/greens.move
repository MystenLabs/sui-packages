module 0x6843ecd5eb426d8b7a309311e853aa7906a95738e6115226f5571db6bf3368e::greens {
    struct GREENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENS>(arg0, 6, b"GREENS", b"The Greens", x"f09f9fa2f09f9fa241726520796f7520726561647920666f722054686520477265656e73f09f9fa2f09f9fa20a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736537249594.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

