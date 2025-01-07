module 0xc3d856ac8140797eb20d5a85e7de4e5cfc8c6557db3dfcc1f2b17ad2ac38addd::hht {
    struct HHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHT>(arg0, 9, b"HHT", b"heart", b"Better than reason", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b419ead-8861-4c78-8f07-02ad7c3b7b03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

