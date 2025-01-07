module 0xfb381557ee41c9422b1d9cd28b84d08933e84213d768413080da24b812e23c34::nang {
    struct NANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANG>(arg0, 9, b"NANG", b"nangcuc", b"NANGqua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd7e6215-1af8-4138-b741-b3a3e2ca7d92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

