module 0x9735fff02502a1465be14de9cf3528643a36a15d424d1ba04f2ebb970bb227d0::neil {
    struct NEIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIL>(arg0, 6, b"NEIL", b"Neil The Suiel", b"The Most Famous Seal From Tik Tok Is Now On Sui, 50 percent of the team wallet will be used to donate to Neil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_20_26_58_e7045bc592_55f0d34a22.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

