module 0x3b04c9a8775a496253b06d09c8bb822c8dc687512c0f469fb6cb55bf8ce0309a::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"Fly", b"Suifly", x"466c7965737420436174206f6e205375690a537569666c79206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e2070726f6a656374206275696c74206f6e2074686520537569204e6574776f726b2c20726570726573656e742066726565646f6d2c20637265617469766974792c20616e64206c696d69746c65737320706f73736962696c69746965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6dccb23b_b929_404f_b142_47624ba2df3f_3f58244a8b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

