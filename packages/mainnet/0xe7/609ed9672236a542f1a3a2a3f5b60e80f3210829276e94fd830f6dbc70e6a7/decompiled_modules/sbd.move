module 0xe7609ed9672236a542f1a3a2a3f5b60e80f3210829276e94fd830f6dbc70e6a7::sbd {
    struct SBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBD>(arg0, 6, b"SBD", b"SuiBirds", x"446578205072652d50616964203130302520736f6f6e210a326b20496e697469616c204c6971756964697479206279206d6f766570756d70206c69717569646974790a576562206973206275696c64696e67206e6f77210a4120626c756520626972647320746861742024534244205375692062697264732020746f2073657420706177206f6e20746865202353756920626c6f636b636861696e206e6f77210a68747470733a2f2f782e636f6d2f737569626972647331", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4004_c5af5aac86.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

