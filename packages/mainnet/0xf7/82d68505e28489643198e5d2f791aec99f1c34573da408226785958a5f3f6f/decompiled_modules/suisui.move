module 0xf782d68505e28489643198e5d2f791aec99f1c34573da408226785958a5f3f6f::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"SUISUI", b"Sui on Sui", x"535549206f6e2053554920666f6c6c6f7773207468652053554920436861727420616e642077696c6c206265636f6d652074686520626967676573742053554920636f696e206f6e205355490a0a5355492053554920535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf3zi6j4eckahl3t2brqtyj2atfjhb4jpcuyvymllrqotkvlq34e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

