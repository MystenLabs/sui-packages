module 0xfe43db44c74fdf6d60eec29bdbbf44632329ce5557f2df1fc6a1d2dfd494321c::gdf {
    struct GDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDF>(arg0, 9, b"GDF", b"GFD", b"GD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3081cf65-8f85-4550-a6c6-d595f19be5dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

