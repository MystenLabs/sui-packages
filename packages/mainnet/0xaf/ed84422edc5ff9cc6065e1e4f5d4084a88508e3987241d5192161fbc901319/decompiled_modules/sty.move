module 0xafed84422edc5ff9cc6065e1e4f5d4084a88508e3987241d5192161fbc901319::sty {
    struct STY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STY>(arg0, 9, b"STY", b"Bukansetya", b"gatau ah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a957c77f-775a-425b-8c99-c0d728db4f84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STY>>(v1);
    }

    // decompiled from Move bytecode v6
}

