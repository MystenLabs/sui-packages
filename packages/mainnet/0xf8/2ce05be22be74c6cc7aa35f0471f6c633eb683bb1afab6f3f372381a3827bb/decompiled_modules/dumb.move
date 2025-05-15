module 0xf82ce05be22be74c6cc7aa35f0471f6c633eb683bb1afab6f3f372381a3827bb::dumb {
    struct DUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMB>(arg0, 6, b"DUMB", b"Dumbcoin", b"Too dumb to fail", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid6hfe5nxejt5t2l2sdm466tp2omkbuigvtykkgo6dhuhf2jn43ky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUMB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

