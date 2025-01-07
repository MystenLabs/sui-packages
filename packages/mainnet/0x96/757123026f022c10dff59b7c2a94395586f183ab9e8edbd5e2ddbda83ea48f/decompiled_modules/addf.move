module 0x96757123026f022c10dff59b7c2a94395586f183ab9e8edbd5e2ddbda83ea48f::addf {
    struct ADDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDF>(arg0, 9, b"ADDF", b"Cat200", x"f09fa491f09fa491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2582c43-07f7-4367-8088-0ab853a50d0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

