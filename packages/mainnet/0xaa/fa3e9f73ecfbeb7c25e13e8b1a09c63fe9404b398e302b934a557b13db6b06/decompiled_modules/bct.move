module 0xaafa3e9f73ecfbeb7c25e13e8b1a09c63fe9404b398e302b934a557b13db6b06::bct {
    struct BCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCT>(arg0, 9, b"BCT", b"big city", b"BIG AND BIG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8401f1b8-2f1a-4644-8dec-9cfb596f70a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

