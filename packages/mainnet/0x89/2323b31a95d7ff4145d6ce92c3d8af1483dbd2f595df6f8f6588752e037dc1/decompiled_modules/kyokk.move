module 0x892323b31a95d7ff4145d6ce92c3d8af1483dbd2f595df6f8f6588752e037dc1::kyokk {
    struct KYOKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYOKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOKK>(arg0, 9, b"KYOKK", b"Kyokaki", b"Nihao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c958e78a-0c43-413a-8cd7-ae4bf32ed7e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYOKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

