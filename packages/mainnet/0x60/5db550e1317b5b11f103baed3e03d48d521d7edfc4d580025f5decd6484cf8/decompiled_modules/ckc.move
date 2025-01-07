module 0x605db550e1317b5b11f103baed3e03d48d521d7edfc4d580025f5decd6484cf8::ckc {
    struct CKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKC>(arg0, 9, b"CKC", b"COCKROACH ", x"4c696665206973206c696b65206120434f434b524f4143480a5468697320636f696e206973206261736564206f6e206120636f636b726f61636820776869636820616c77617973207375727669766573206576656e2074686f756768206974206973207472616d706c6564206f6e20616e6420636f6e74696e75657320746f207269736520616e642067726f77206a757374206c696b65207468697320636f696e2c20434f434b524f414348207265717569726573206120646563656e7472616c697a656420636f6d6d756e6974792066756c6c206f662066756e2c2070726f6d6f74696f6e20616e64206163746976652070617274696369706174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90ec00bc-7e2f-400b-b983-57c62f6a155b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

