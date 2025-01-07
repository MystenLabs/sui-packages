module 0x8e119bf22a30520dfbe0537faab31f1f03961ac4c2fbf568ff8f50ec3895d958::suica0 {
    struct SUICA0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA0>(arg0, 6, b"SUICA0", b"SUICA", x"5355492b4341203d205355494341200a5355494341206973207469746c65206d656d6520696e204a6170616e210a42757420706f737369626c6520746f206d616b65206974205355492b434120746f6f0a0a53554943412077696c6c206265207469746c65206d656d6520696e2053554920434f494e0a4c6574277320676f20746f6765746865722c20436f6d6d756e6974792077696c6c206d616b652053554943412047726561740a0a5745423a2068747470733a2f2f7375692d63612e636f6d2f0a545749545445523a2068747470733a2f2f782e636f6d2f53554943415f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUICA_c97821f9d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICA0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICA0>>(v1);
    }

    // decompiled from Move bytecode v6
}

