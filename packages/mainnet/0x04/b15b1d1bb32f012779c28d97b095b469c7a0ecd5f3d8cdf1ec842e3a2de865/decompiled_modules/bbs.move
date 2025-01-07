module 0x4b15b1d1bb32f012779c28d97b095b469c7a0ecd5f3d8cdf1ec842e3a2de865::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBs", b"BlueBolz", x"426c75426f6c7a20287469636b65723a20426c75426f6c290a497420697320736f20756e666169722e2e2e204e6f626f64792077616e7420746f20746f75636820426c75426f6c7a2e2e20536f206d7563682073696d70696e6720666f72206e6f7468696e672e2e2049742068757274732e2e204445582077696c6c2062652070616964206174204b4f54482c206164732077696c6c20626520706169642c746869732069732061206e6577206d65746120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1713_6bb51b87bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

