module 0xeef65a54a5c07df4c93306275e0fcf8f438050a817e7e987ee77728b5a8d4a79::ins {
    struct INS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INS>(arg0, 6, b"INS", b"!ns", x"5468697320697320216e732028726576657273656420737569292e0a4f757220676f616c20697320746f2072656163682024302e333634382077686963682077617320746865206c6f77657374207072696365206f66207375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_41f6f7e59e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INS>>(v1);
    }

    // decompiled from Move bytecode v6
}

