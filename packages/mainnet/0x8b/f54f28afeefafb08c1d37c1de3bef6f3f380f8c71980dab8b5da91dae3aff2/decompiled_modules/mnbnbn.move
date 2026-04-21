module 0x8bf54f28afeefafb08c1d37c1de3bef6f3f380f8c71980dab8b5da91dae3aff2::mnbnbn {
    struct MNBNBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNBNBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNBNBN>(arg0, 6, b"Mnbnbn", b"hjhhjjj", b",jljlk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaeqkisrvrmfjdkcu7ndlu6nffftpivc3mv2yhre4opp5tb3rmjtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNBNBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNBNBN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

