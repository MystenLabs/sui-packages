module 0x1f4241a5a8413a27ff31ceb27f191f60ced2bd8604e39e9f07e0d40112cd6cf8::suisea {
    struct SUISEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEA>(arg0, 6, b"SUISEA", b"Suisea Racing Pokemon", b"Suisea is building a Pokemon-style seahorse racing game on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibukk3z2cavgunrsfdncck2l7syicvykavokkqzssjrb3ywdb2l6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

