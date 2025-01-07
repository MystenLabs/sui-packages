module 0x8700ac48907ef69e57a08c07516b931bc06bb02cd0085198cc265dfaaa301dcc::doy {
    struct DOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOY>(arg0, 6, b"DOY", b"DonkeyAI Coin", x"57656c636f6d6520746f2074686520776f726c64206f66206578636974696e672074726176656c207769746820446f6e6b6579414920436f696e20616e642074686520636865657266756c20636f6d70616e696f6e73206f662074686520646f6e6b657920616e64206869732077697365206d61737465722c20486f646a61204e617372656464696e2e0a68747470733a2f2f7777772e696e7374616772616d2e636f6d2f646f6e6b65796169636f696e3f696773683d597a6c6a59546b314f4467335a673d3d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726572693064_bddea30608c26547ad4d209b23ed11d2_8dba650b50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

