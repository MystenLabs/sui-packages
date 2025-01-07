module 0x932bbedb22ab80f54fa8b03550a75ac928e57e2e173129276634c26517dea145::SCOTT {
    struct SCOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOTT>(arg0, 6, b"SCOTT", b"v2", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTrPcbjfdYvmtMBcekgsJmFzGnfSQpjvz4QhkpBvBekXb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

