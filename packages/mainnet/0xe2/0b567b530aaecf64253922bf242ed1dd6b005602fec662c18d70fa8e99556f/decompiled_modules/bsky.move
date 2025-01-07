module 0xe20b567b530aaecf64253922bf242ed1dd6b005602fec662c18d70fa8e99556f::bsky {
    struct BSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSKY>(arg0, 9, b"BSKY", b"BlueSkay", b"Blu Sky is perfect seen ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e4d5b3c-b21a-42f9-856f-9e2356313679.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

