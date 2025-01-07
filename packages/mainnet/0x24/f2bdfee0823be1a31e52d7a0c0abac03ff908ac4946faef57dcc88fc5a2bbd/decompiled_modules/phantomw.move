module 0x24f2bdfee0823be1a31e52d7a0c0abac03ff908ac4946faef57dcc88fc5a2bbd::phantomw {
    struct PHANTOMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTOMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTOMW>(arg0, 6, b"PhantomW", b"Phantom", b"Phantom Wallet is coming to sui and we will be great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241206_013455_3fa7a368ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTOMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTOMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

