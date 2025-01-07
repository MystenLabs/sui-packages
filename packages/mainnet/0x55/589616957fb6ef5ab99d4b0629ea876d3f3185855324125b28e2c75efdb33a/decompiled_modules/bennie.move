module 0x55589616957fb6ef5ab99d4b0629ea876d3f3185855324125b28e2c75efdb33a::bennie {
    struct BENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNIE>(arg0, 6, b"BENNIE", b"Bennie The Frenchie", x"42656e6e696520697320616c6c2061626f757420756e6c6f636b696e6720796f7572206869676865737420706f74656e7469616c20616e6420696e66696e69746520706177732d6162696c69746965732e205468697320647265616d7920646f6720737061726b7320637265617469766974792c206272696e67732070656f706c6520746f6765746865722c20616e6420656d706f776572732065766572796f6e6520746f20636861736520746865697220676f616c73206e6f206d617474657220686f77206661722d666574636865642e204c657473206d616b652069742068617070656e20776974682042656e6e6965210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5e8_ZRV_4_Q_400x400_eaeb28addb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

