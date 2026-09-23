module 0x8a0f4c858660bbc45eaa1942a43fe89c91eec0c71b851756f4131a710dd7ecba::cuica {
    struct CUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CUICA>(arg0, 6, 0x1::string::utf8(b"CUICA"), 0x1::string::utf8(b"Suica"), 0x1::string::utf8(x"e29aa120537569636120e28094204275696c74206f6e205375690af09f928e20536d616c6c20746f6b656e2c2062696720766973696f6e0af09f9a80204c6574e2809973207269646520746f20746865206d6f6f6e20f09f8c99"), 0x1::string::utf8(b"https://popularsui.xyz/media/0459cae7147965c68b243fcf45e1e180aecab184ffdae041451888a917f717cf.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUICA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CUICA>>(0x2::coin_registry::finalize<CUICA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

