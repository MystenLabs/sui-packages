module 0x79da33a9b39f3333a3c56a8e93f434097776082acf40d8d308d05eb71640c139::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 9, b"TR", b"TREASURE", x"4f68686820796f7520666f756e64206120747265617375726520f09faa9920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29de90b5-87fd-4ebd-a55e-22b5c1d7866d-1000218371.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
    }

    // decompiled from Move bytecode v6
}

