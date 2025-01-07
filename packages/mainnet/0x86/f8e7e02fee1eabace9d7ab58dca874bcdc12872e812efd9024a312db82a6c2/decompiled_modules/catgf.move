module 0x86f8e7e02fee1eabace9d7ab58dca874bcdc12872e812efd9024a312db82a6c2::catgf {
    struct CATGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGF>(arg0, 6, b"CATGF", b"cat girl", x"746865206361746769726c2073696e67756c61726974792069736ee2809974206a7573742061626f7574206375746520656172733b206974e2809973206c696b652e2e2e207475726e696e672074686520696e7465726e657420696e746f2061206769616e74206d6972726f722e2079e28099616c6c20737461726520696e746f2069742c20616e6420697420737461726573207269676874206261636b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731589716702.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

