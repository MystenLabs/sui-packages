module 0xc20244053cad4622a025e55abf29d8864d971268d7c2bf5bc444b09271de6eb8::umbre {
    struct UMBRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMBRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMBRE>(arg0, 6, b"UMBRE", b"Umbreon", x"496e2074686520506f6bc3a96d6f6e20756e69766572736520554d4252454f4e206973206120506f6bc3a96d6f6e2074686174206973207375706572206c6f7665642062792074686520636f6d6d756e6974792e20616e64206f6e2053554920697420686173206265636f6d6520746865206d61696e206d656d65206f6e20746865206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihp2xazqir7ql43cv34jtfjmsx7cduhiau3uh7zm4mxfglpoy27p4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMBRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UMBRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

