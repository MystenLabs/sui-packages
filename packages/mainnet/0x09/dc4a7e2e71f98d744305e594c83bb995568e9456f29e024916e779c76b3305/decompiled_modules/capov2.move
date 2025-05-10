module 0x9dc4a7e2e71f98d744305e594c83bb995568e9456f29e024916e779c76b3305::capov2 {
    struct CAPOV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOV2>(arg0, 6, b"CAPOV2", b"Capo V2  The AI Versiyon", x"4341504f205632206973206e6f74206a757374206120746f6b656e200a6974277320616c736f20612054656c656772616d20414920766f696365206368616e676572206170702c20616c6c6f77696e6720796f7520746f2075706c6f616420616e642075736520637573746f6d20766f6963652066696c6573207769746820616476616e6365642041492066756e6374696f6e616c6974792e0a4c657420746865206d61666961207269736520616761696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcl2st3yooglr5gkka7hrdjg6dq6domt2rjyl7vwvjhsu2cm6rwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPOV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

