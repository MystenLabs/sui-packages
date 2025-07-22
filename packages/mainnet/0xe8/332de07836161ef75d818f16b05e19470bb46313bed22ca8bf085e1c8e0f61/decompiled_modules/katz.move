module 0xe8332de07836161ef75d818f16b05e19470bb46313bed22ca8bf085e1c8e0f61::katz {
    struct KATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATZ>(arg0, 6, b"KATZ", b"Mister KATZ", b"KATZ isnt just any feline he is the living, purring parody of something way too serious. While others argue about charts and coins, KATZ naps on keyboards and accidentally buys snacks with someone's credit card.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibfohukiz5ypmbip6izfclbgmgey6bou63jtv44fpdbtil2stu4gq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KATZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

