module 0x36f8680f5e1f770708f7a9e03167aa95e775a85684fea933be08bc49e771648b::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"Suirrel", b"Suirrel The Blue Squirrel", b"The Blue Squirrel On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeighh5gqabrbcep7g5eeaxjsrxvep3mgxqkva5fg5r3c4g7qnwufuq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRREL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

