module 0x290810c415f3d3a5ec84f55d5044533cf516f01e334a2211df0f5ecd80191758::difat {
    struct DIFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIFAT>(arg0, 9, b"DIFAT", b"Aliyu", b"Xgxdgg txgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34aa8553-c3e8-44d7-8f58-6a6107900183.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIFAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

