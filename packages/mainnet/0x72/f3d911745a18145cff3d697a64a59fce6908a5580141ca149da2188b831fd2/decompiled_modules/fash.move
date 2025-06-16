module 0x72f3d911745a18145cff3d697a64a59fce6908a5580141ca149da2188b831fd2::fash {
    struct FASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASH>(arg0, 6, b"FASH", b"Female Ash", b"Female Ash Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidexjx6oxrt6g6kx67ppc2ddyduqhb7ewjwj77etefptyam7ilgzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

