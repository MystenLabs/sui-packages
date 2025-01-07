module 0x14838c43c3137c817ab162d3549430af6f5a6ee0cf63e6768e0953400122e626::qqt {
    struct QQT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQT>(arg0, 6, b"QQT", b"Quantum", b"Quantum Terminator ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004412_445f45fdbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQT>>(v1);
    }

    // decompiled from Move bytecode v6
}

