module 0x266d9eb5b3faea9f4d04015bc7e7279ed930c4f6fecfd025475e58fa72d4669d::mcvt {
    struct MCVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCVT>(arg0, 6, b"MCVT", b"Mill City Ventures", x"68747470733a2f2f64652e74726164696e67766965772e636f6d2f73796d626f6c732f4e41534441512d4d4356542f0a68747470733a2f2f7777772e636f696e6465736b2e636f6d2f627573696e6573732f323032352f30372f32382f66696e616e63652d6669726d2d6d696c6c2d636974792d76656e74757265732d746f2d6275792d7573643434316d2d696e2d7375692d746f6b656e732d7069766f74696e672d746f2d626c6f636b636861696e2d74726561737572792d7374726174656779", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Download_67_7d3778d547.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCVT>>(v1);
    }

    // decompiled from Move bytecode v6
}

