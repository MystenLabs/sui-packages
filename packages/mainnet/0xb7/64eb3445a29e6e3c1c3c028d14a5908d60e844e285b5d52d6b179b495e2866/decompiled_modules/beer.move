module 0xb764eb3445a29e6e3c1c3c028d14a5908d60e844e285b5d52d6b179b495e2866::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 6, b"BEER", b"Sui Beer", x"24424545522c20616c736f206b6e6f776e2061732053756920426565722c20697320746865206472696e6b206f662063686f696365206f6e2074686520537569204e6574776f726b2e205768657468657220796f752772652074726164696e67206f72206a757374206368696c6c696e672c202442454552206973206865726520746f206b6565702074686520676f6f642074696d657320666c6f77696e672e2047726162206120636f6c64206f6e6520616e642067657420726561647920746f20746f61737420746f206761696e73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/cty_Yhk_FUT_Eilo_CB_6_Kd8_Hnw_af7e8f1bca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

