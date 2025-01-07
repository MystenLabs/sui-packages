module 0xc94a4fcade9b7b5a313fef6f8a253ce80380c62c1c8c8e37ddb90a11b5dbd1be::wlf {
    struct WLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 9, b"WLF", b"WOLFIE", b"Loyal as you. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2470190f-1914-43f2-9828-60425ca77916.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

