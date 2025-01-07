module 0x40b0813a7e6c447e971edee48da124e328b3ffe7c75a05907b6cd7b947b17b13::rbl {
    struct RBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBL>(arg0, 9, b"RBL", b"Rebels", b"In a world controlled by centralized finance, REBEL emerged as a symbol of defiance, breaking free from oppressive systems. Now a meme coin, REBEL embodies decentralized freedom, chipping away the old way and empowering everyone to control their wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/223945df-43f0-4a38-a29f-40a401b54db2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

