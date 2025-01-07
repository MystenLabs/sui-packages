module 0x4c75d3091da2f67cd8f368d7bfaf6d8d06d1b28d7cf4fb54e6ac2e347f667d1a::wangwang {
    struct WANGWANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANGWANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGWANG>(arg0, 6, b"Wangwang", b"Traveling wangwang", b"This is Wang Wang, a smart Chinese rural dog who has traveled over 60,000 kilometers across 20+ provinces in China with its owner. It once had a companion named Chou Chou, who sadly passed away last year. This token was created to capture this moment and honor Chou Chou's memory. We know all life is fleeting, so I will only buy 10 SUI of Wang Wang and hold it until its final days.No Dev No team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1733030418319_fb13dfa7f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGWANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANGWANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

