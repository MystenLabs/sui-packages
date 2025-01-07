module 0x2097b97542ebcc9303d8dce35173d875642d76ca9d208402d1eb544532b814e0::trumppi {
    struct TRUMPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPPI>(arg0, 9, b"TRUMPPI", b"Trump pipi", b"Trump pipi Elonmusk ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f7d4d6d-7258-432a-8e1f-b71908a50035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

