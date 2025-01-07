module 0x5d171a8eccc84df477471f16066bc07db3edb522c22e649482cc09090c238149::mechchop {
    struct MECHCHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECHCHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECHCHOP>(arg0, 6, b"MECHCHOP", b"Mechazilla Chopsticks", x"4d656368617a696c6c612063686f70737469636b7320617265206120756e697175652070617274206f66205370616365582773205374617273686970206c61756e63682073797374656d2e0a0a20546865792061726520657373656e7469616c6c79206769616e742c20726f626f7469632061726d7320617474616368656420746f20746865206c61756e636820746f7765722074686174206172652064657369676e656420746f2063617074757265207468652072657475726e696e6720626f6f73746572206f662074686520537461727368697020726f636b6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/960x0_3719413bf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECHCHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MECHCHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

