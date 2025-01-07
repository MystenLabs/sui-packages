module 0x5ba1c5b811ec797ad8e513ee9b2f70a3a325f1114729793e008b7ba3be79dc1e::vinci {
    struct VINCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINCI>(arg0, 9, b"VINCI", b"vinci", x"f09f8ea8202456494e4349202d20546865204152542026204d656d65204167656e7420f09f968cefb88f20205c6ee29ca8205475726e696e67202453554920707269636520696e746f20446156696e63692d696e737069726564204149206d61737465727069656365732e204372656174656420627920244f534952492e20205c6ef09f96bcefb88f204e6f207574696c6974792c206a757374206172742e202356494e4349", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1873467389192376321/g2xw9c7M_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINCI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINCI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VINCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

