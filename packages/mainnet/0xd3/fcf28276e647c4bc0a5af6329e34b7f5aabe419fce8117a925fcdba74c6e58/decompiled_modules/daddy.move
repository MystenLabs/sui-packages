module 0xd3fcf28276e647c4bc0a5af6329e34b7f5aabe419fce8117a925fcdba74c6e58::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"Daddy Dinner!", x"44616464792044696e6e6572210a0a47657420746865206f70706f7274756e69747920746f206d6565742074686520546f7020472c205472697374616e20546174652026207468652072657374206f662074686520637265772e204e6574776f726b2c2070697463682069646561732c206275696c6420636f6e6e656374696f6e7320617420612062656175746966756c20666561737420696e2044756261692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiac2p5elmqxbqvghfkl4dtimns6zsp3uljsazwuutn6xaox35i6qe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DADDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

