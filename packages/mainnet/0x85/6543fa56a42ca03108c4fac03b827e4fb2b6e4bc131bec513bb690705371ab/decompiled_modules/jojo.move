module 0x856543fa56a42ca03108c4fac03b827e4fb2b6e4bc131bec513bb690705371ab::jojo {
    struct JOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJO>(arg0, 6, b"JOJO", b"Joliebee", b"j4t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiez43lssgngn4aheerwio56a7v2mir224jzqypk7lptdbjqgfzsu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOJO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

