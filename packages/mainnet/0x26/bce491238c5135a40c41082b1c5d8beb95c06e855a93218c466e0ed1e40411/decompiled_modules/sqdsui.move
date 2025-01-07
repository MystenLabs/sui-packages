module 0x26bce491238c5135a40c41082b1c5d8beb95c06e855a93218c466e0ed1e40411::sqdsui {
    struct SQDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQDSUI>(arg0, 6, b"SQDSUI", b"Squid Sui", x"47657420526561647920666f7220746865205371756964537569205473756e616d6921200a0a4d6f766550756d702e636f6d2069732061626f757420746f20626520666c6f6f646564207769746820612077617665206f66206e6577207573657273207468616e6b7320746f2053717569645375692c2074686520686f7474657374206d656d6520636f696e20696e207468652063727970746f2073706163652e2054686973206973206f7572206368616e636520746f20726964652074686973207761766520746f20746865206d6f6f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/squidsui_logo_668fdb340c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

