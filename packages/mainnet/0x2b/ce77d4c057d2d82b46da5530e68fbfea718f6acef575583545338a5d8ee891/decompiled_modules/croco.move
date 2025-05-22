module 0x2bce77d4c057d2d82b46da5530e68fbfea718f6acef575583545338a5d8ee891::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"CROCONAW", x"43726f636f6e6177206973206120576174657220506f6bc3a96d6f6e20746861742065766f6c7665732066726f6d20546f746f64696c652e2049742069732076756c6e657261626c6520746f20477261737320616e6420456c6563747269632061747461636b732e2043726f636f6e61772773207374726f6e676573742061747461636b73206172652057617465722047756e2026205761746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcb5d3ayyj3c75mz3rwo4j6jumh4iied3amx672lqk6h3browx4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

