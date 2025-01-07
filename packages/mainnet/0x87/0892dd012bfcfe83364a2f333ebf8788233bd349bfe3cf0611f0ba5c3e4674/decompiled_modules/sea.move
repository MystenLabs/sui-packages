module 0x870892dd012bfcfe83364a2f333ebf8788233bd349bfe3cf0611f0ba5c3e4674::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 7, b"SEA", b"SeaCoin", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT40myFuRTQZDyx_WAmtf0g51WceP7LcGpC87C-pKpa96a-Kp0CoiU9r4S3TTjo1JpWq24&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

