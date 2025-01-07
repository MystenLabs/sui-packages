module 0x8d0b7e9ba90b282ad56c3a0e598c2870b3bd01ef70e415ecd45a03a2ae2cb5eb::ocn {
    struct OCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCN>(arg0, 9, b"OCN", b"Ocean", b"Oceann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1beee4b2-a7df-407b-93b7-25d9d0917d66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

