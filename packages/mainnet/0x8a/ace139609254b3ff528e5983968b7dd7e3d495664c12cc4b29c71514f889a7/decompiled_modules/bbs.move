module 0x8aace139609254b3ff528e5983968b7dd7e3d495664c12cc4b29c71514f889a7::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"Blue Butt On Sui", x"4469766520696e746f207468652077696c6420776f726c64206f6620426c75652042757474202c20746865206d656d65636f696e206f6e2053756920666f72206c61756768732c206761696e732c20616e64207075726520646567656e20656e65726779202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_ed29691c73_5a0baa6475.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

