module 0x702a36060dfd38c6d4e6b22ca34a4e0415a1ea823c5ddc1e9e757541010bcd49::kett {
    struct KETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETT>(arg0, 6, b"Kett", b"Kett Sui", x"4a6f696e204b657474206f6e20616e20696e6372656469626c6520616476656e7475726520696e746f0a207468652063727970746f20776f726c642e2043616e20796f752068616e646c6520746869730a2064697a7a79696e67204a6f75726e657920746f20746865206d6f6f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiea7ruvsvyaadhklknddzk6nvgos2rz5ov72ykzgyho5bqjopku64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KETT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

