module 0x6d34378308620cc45c7db37828422f9ab9a0b4e20164d2d20f64623d3ceaee31::shhs {
    struct SHHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHHS>(arg0, 9, b"SHHS", b"Sbshs", b"Shsgg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75a699de-1214-4961-93dd-40c5d0c3582b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

