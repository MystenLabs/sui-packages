module 0x26ca17f3221bf18effc23e9bfe7f3d708725abcc6dd918ebfddb64c1ef2fb5e7::tsw {
    struct TSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSW>(arg0, 6, b"TSW", b"TrumpSuiWins", x"6e74726f647563696e67205472756d7053756957696e73202854535729210a4f6e204d6f766550756d700a546865206d656d6520636f696e207468617473206d616b696e672063727970746f20677265617420616761696e21200a47657420726561647920666f7220746865207265766f6c7574696f6e2074686174732061626f757420746f2074616b65207468652063727970746f20776f726c642062792073746f726d2e205472756d7053756957696e7320697320686572652c20616e642069747320796f7572206368616e636520746f2062652070617274206f66207468652077696e6e696e67207465616d21200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3079_59a600a917.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

