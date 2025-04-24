module 0x2e93cbab36a3f2998a606e2a6609662e842db300430190a290e33e8fd0198c38::void {
    struct VOID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOID>(arg0, 6, b"VOID", b"VOIDIE", b"Welcome to the most utterly meaningless token on the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih2ysruzviuaj4ib2n6afjpjkq3clsdpptyzjos47xi5qk2alrhdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

