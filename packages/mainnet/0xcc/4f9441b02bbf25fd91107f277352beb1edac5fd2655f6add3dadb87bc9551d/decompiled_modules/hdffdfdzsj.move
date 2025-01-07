module 0xcc4f9441b02bbf25fd91107f277352beb1edac5fd2655f6add3dadb87bc9551d::hdffdfdzsj {
    struct HDFFDFDZSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDFFDFDZSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDFFDFDZSJ>(arg0, 9, b"HDFFDFDZSJ", b"gfgfgfgfgf", b"fgfgfgfsrtybnbnjhgj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc30dec4-8b55-4202-82f4-7c470a273ef9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDFFDFDZSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDFFDFDZSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

