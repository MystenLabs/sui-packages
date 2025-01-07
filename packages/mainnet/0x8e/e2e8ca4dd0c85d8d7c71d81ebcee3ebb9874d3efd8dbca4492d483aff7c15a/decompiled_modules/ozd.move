module 0x8ee2e8ca4dd0c85d8d7c71d81ebcee3ebb9874d3efd8dbca4492d483aff7c15a::ozd {
    struct OZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZD>(arg0, 9, b"OZD", b"OZIDI", b"Not happy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d14d05c-03ee-4f29-bce2-63c950c8c4ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

