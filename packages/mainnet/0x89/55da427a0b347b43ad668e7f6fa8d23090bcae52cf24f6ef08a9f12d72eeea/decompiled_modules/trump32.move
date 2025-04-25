module 0x8955da427a0b347b43ad668e7f6fa8d23090bcae52cf24f6ef08a9f12d72eeea::trump32 {
    struct TRUMP32 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP32, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP32>(arg0, 6, b"TRUMP32", b"TRUMP 2032", x"68747470733a2f2f782e636f6d2f63625f646f67652f7374617475732f313931353539363434383532353134383530360a0a5368697420746f6b656e206e6f20736f636d6564206a75737420666f722066756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedyy76mltsahcom74x6iidul7eilkc2euvrmtvl4uwjerazgcllu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP32>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMP32>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

