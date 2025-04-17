module 0x9dc60b321d99badc2199eff1dbcb569151e3b16776b462420f0a5e6a6b005871::catkashi {
    struct CATKASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATKASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATKASHI>(arg0, 9, b"CATKASHI", b"Catkashi Hatake", b"The cat was bullied by all his fellow feline classmates in school. H", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/caee01d0e95a4a89e7d86e5b1725eefcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATKASHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATKASHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

