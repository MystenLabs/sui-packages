module 0xa2276ffa6d547a2f880ecc70a43809357dd9bfa8d94c0072fc453494a69b44d8::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"Neiro", b"Neiro sui", x"0a5468652031737420244e6569726f206465706c6f796564206f6e20537569202c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e7420746f20444f47452e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_U_U_U_U_U_U_U_U_U_U_U_U_U_U_Chrome_8ff2cf09f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

