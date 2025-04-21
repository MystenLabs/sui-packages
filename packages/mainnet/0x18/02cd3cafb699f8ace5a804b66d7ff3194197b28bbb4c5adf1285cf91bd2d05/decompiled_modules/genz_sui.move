module 0x1802cd3cafb699f8ace5a804b66d7ff3194197b28bbb4c5adf1285cf91bd2d05::genz_sui {
    struct GENZ_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ_SUI>(arg0, 9, b"genzSUI", b"genz SUI", b"gzSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENZ_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

