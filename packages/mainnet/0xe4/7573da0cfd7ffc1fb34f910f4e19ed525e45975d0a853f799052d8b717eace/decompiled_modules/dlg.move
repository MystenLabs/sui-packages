module 0xe47573da0cfd7ffc1fb34f910f4e19ed525e45975d0a853f799052d8b717eace::dlg {
    struct DLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLG>(arg0, 9, b"DLG", b"DARK LOGO", b"DARK LOGO - DARK TOKEN - DARK TRADE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0871a68-2f4d-444b-90df-5d54339ebd31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

