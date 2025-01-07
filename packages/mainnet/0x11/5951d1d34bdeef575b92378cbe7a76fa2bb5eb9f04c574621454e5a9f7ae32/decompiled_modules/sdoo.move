module 0x115951d1d34bdeef575b92378cbe7a76fa2bb5eb9f04c574621454e5a9f7ae32::sdoo {
    struct SDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOO>(arg0, 6, b"SDOO", b"SUIBY DOO", b"SUUUiiiiBYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_27_00_43_37_224849fac8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

