module 0xf5a605b5acc7fca39538f88f08a35e43585ccac8f40f8e9b9e3658b8954ba51::wrdp {
    struct WRDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRDP>(arg0, 9, b"WRDP", b"Wardep", b"Wardep is better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27df70c0-c328-492d-aa8c-548f56be6a56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

