module 0x9393e8ec45cb5dcadfe27216dd04a383420c97caa552744a08b1612458975c65::tomad {
    struct TOMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMAD>(arg0, 6, b"TOMAD", b"TOMADNESS", b"Step into the world of Tomadness, where absurdity meets blockchain. $TOMAD is the memecoin for those who dare to be different. Some of the tokens will be locked, and some will be delegated to staking! More info coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicw36yzzeaetxsjjfc7acub26jvb4r4ea4l3wd2e6ctfosn3qudge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

