module 0x14b7ec21093903e3fe1827335b4051c4a6adf1382ca1902836ddcc8c4aeeda57::seg {
    struct SEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEG>(arg0, 6, b"SEG", b"Segmai", b"SegmAI is a decentralized platform where humans on SUI And agents work together to create highest quality labelled datasets for training AI models.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2h3slsdtpkzmh4q65fvwfofy65qsjtfpneug3eeokhjxolecs7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

