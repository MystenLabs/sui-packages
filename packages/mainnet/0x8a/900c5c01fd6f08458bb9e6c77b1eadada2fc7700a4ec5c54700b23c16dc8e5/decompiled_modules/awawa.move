module 0x8a900c5c01fd6f08458bb9e6c77b1eadada2fc7700a4ec5c54700b23c16dc8e5::awawa {
    struct AWAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAWA>(arg0, 9, b"AWAWA", b"Nukawa", b"it's very funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bde8ccf-ab34-43c4-850b-4fe7532179dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

