module 0x62beac6a14b7a1c86e19d2d803764f1444cd6369478ff876831a701791653755::t4 {
    struct T4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T4>(arg0, 6, b"T4", b"Test4", b"Dont buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdjzfgusjfuoptqn57hj34q4g3uas76tywiqnj25udassv5rls6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<T4>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

