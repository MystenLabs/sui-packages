module 0xad88e960b1e8afec0a1abde79aed2767d49d4d8d2aef97ea93cc37be318b7e8d::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 6, b"Qwe", b"q3", b"q", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaxkvoauaqjwjnmocq7dvye4bh65tecckdyeb6akuqwfrzzrzqhsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QWE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

