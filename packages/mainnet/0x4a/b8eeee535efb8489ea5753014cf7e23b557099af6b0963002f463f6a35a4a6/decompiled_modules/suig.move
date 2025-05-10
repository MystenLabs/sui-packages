module 0x4ab8eeee535efb8489ea5753014cf7e23b557099af6b0963002f463f6a35a4a6::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 6, b"SUIG", b"Suigar", b"Enter the Suigary Wonderland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifirs7jwxuquh2t7twzag2nk22kgqp3scmz2f3tir4lfcvxhvbq2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

