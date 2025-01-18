module 0x59f31a624786331408d95e8dded173cef8037f9d8080153b88a9f9fe74750ed4::quin {
    struct QUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUIN>(arg0, 9, b"QUIN", b"Trang", b"Vuiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05ff9acb-cbb6-41d2-a9a1-e764f7e70397.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

