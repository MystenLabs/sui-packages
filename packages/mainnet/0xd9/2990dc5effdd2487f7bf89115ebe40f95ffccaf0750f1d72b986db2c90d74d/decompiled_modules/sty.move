module 0xd92990dc5effdd2487f7bf89115ebe40f95ffccaf0750f1d72b986db2c90d74d::sty {
    struct STY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STY>(arg0, 9, b"STY", b"Bukansetya", b"gatau ah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc588544-75e8-4389-8dfd-144608c0cdca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STY>>(v1);
    }

    // decompiled from Move bytecode v6
}

