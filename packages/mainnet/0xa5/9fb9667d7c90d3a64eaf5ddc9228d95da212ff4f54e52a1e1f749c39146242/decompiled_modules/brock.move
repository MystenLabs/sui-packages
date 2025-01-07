module 0xa59fb9667d7c90d3a64eaf5ddc9228d95da212ff4f54e52a1e1f749c39146242::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCK>(arg0, 9, b"BROCK", b"BlackRock", b"First memcoin frome BLACKROCK. BUY TODAY - SELL TOMORROW. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2963ebf6-3bf4-4d19-b95d-e6b2b8a34f41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

