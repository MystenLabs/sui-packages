module 0x4c794a3262c247ae55eb56618f49f3bc79e5da0958e55d49b07aeb3595a3afb6::bluely {
    struct BLUELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUELY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUELY>(arg0, 6, b"Bluely", b"Bluelly", b"$BLUELLY is the cutest Jelly in $SUI lurking cutely under the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibfwu7tax7albjgjglu6iikubwa7a4qd7bmw63oanxrqoeazpipru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUELY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUELY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

