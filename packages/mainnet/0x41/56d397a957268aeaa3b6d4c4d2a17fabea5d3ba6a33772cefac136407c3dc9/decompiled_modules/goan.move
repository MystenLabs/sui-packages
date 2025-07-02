module 0x4156d397a957268aeaa3b6d4c4d2a17fabea5d3ba6a33772cefac136407c3dc9::goan {
    struct GOAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAN>(arg0, 6, b"GOAN", b"Juan Gooner", b"GOAN is the rat himself Juan being a gooner.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhbrhgvpanq6udkfio47l2mb2jvyb63zqfohabvm5wjxa5nkyzhi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

