module 0xc40f04f387d442b23781419f3a0fe742305669e23136220a0b82c0b14e73afc8::hyt {
    struct HYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYT>(arg0, 9, b"HYT", b"ILKILK", b"mooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b26e78f-62ef-4b43-b82f-b7604c202302.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

