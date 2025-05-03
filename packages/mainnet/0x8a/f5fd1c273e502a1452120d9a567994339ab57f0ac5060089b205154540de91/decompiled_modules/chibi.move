module 0x8af5fd1c273e502a1452120d9a567994339ab57f0ac5060089b205154540de91::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBI>(arg0, 6, b"CHIBI", b"Chibi Cat", b"Chibi Cat is a memecoin launching on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsmfm4a4zrey55twh77eem4hgpphft3hoyhljiwxawopbkm6opaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

