module 0xb75337c899a55bd6a4072db78aaedf235550b6222259608a31f04ce18694207f::mfc {
    struct MFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFC>(arg0, 6, b"MFC", b"MFC .CLUB", x"546865204172656e6120776865726520746f6b656e7320626174746c6520666f7220676c6f7279200a4f6e6c7920746865207374726f6e6765737420737572766976652e0a47656e6573697320426174746c653a2041756720320a4275696c74206f6e200a47524656546865204172656e6120776865726520746f6b656e7320626174746c6520666f7220676c6f7279200a4f6e6c7920746865207374726f6e6765737420737572766976652e0a47656e6573697320426174746c653a2041756720320a4275696c74206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3ik5qfl2pykiqgsphqzqiwzlwsi6r4isv4oflvrnb6bh3p43kya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MFC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

