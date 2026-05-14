module 0xd6a428a1a0a32328a3c6fe4da16777d9ebea46d18a644b905a169efbb27a726a::tast {
    struct TAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAST>(arg0, 6, b"TAST", b"test", b"TEST COI DONT BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidsz3vnuedsgmihoer6t3epnivmpxc2xkcn2pmms5f7pbey625dqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

