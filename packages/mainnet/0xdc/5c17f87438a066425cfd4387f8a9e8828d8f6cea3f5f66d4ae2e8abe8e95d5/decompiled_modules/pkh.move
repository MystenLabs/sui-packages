module 0xdc5c17f87438a066425cfd4387f8a9e8828d8f6cea3f5f66d4ae2e8abe8e95d5::pkh {
    struct PKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKH>(arg0, 9, b"PKH", b"HDA", b"EU and I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a42e407b-8b36-482b-9abe-d2bc3e0cddd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

