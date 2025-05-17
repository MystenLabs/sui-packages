module 0x42ee7f1f10f47f21bd9777adad2019fe0c7de9c6f553a8abb2f2af9ce783bc0e::wale {
    struct WALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALE>(arg0, 6, b"WALE", b"Wale on sui", x"2457414c452c2074686520756c74696d61746520535549206d6173636f74206f6e2061206d697373696f6e20746f206265636f6d65207468652066697273742062696c6c696f6e2d646f6c6c6172206d656d65636f696e206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6i367glmvqghyxrudhjlgnonbyqxnufjdfjhg56rujt7qwxgiia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

