module 0x91da6019bec9ff1622f3ed415333e8a2c6df0d90e5a3e6d85c49e5873b919d3e::mct {
    struct MCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCT>(arg0, 9, b"MCT", b"MY CITY", b"my city token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f55b6d5b-586f-40f5-b785-100f38cf3742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

