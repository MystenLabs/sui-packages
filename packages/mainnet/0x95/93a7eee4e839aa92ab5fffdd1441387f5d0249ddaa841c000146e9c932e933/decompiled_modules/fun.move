module 0x9593a7eee4e839aa92ab5fffdd1441387f5d0249ddaa841c000146e9c932e933::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"auto.fun", b"Launch of our Native $FUN token which will be the internal revenue product of our platform: auto.fun! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYFFAS8im3AFgx3GTmGMf3E7nt1BYcjT5CVH8cbiRWquG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

