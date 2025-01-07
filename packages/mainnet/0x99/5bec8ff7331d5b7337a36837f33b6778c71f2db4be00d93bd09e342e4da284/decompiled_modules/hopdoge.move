module 0x995bec8ff7331d5b7337a36837f33b6778c71f2db4be00d93bd09e342e4da284::hopdoge {
    struct HOPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOGE>(arg0, 6, b"HOPDOGE", b"HOPDoge", b"first Doge on HOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/WBpKpbT/20241020200920.jpg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HOPDOGE>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HOPDOGE>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

