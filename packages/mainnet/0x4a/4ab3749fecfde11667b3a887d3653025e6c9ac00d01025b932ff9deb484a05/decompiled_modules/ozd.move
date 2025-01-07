module 0x4a4ab3749fecfde11667b3a887d3653025e6c9ac00d01025b932ff9deb484a05::ozd {
    struct OZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZD>(arg0, 9, b"OZD", b"OZIDI", b"Not happy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1872933b-2dc2-4cd5-b86b-12607f8ac90e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

