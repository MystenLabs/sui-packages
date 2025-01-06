module 0x242327fe89c1dc86d358336d3ce3d2b92990a352562db7acea2b930cf0b1373::beth {
    struct BETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETH>(arg0, 9, b"BETH", b"BEETHOVEN AI", x"244245544820f09f8ebc207c205472616e73666f726d696e6720245355492063686172747320696e746f2042656574686f76656e2d696e7370697265642073796d70686f6e696573205c6e5c6e576865726520626c6f636b636861696e206d6565747320636c6173736963616c2067656e697573207c204372656174656420627920244f53495249207c204e6f207574696c6974792c206a757374206d75736963616c206d61737465727069656365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876346435769077760/VMSkrSvB_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

