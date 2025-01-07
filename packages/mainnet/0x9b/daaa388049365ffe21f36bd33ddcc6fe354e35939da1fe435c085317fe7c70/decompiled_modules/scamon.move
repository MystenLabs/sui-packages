module 0x9bdaaa388049365ffe21f36bd33ddcc6fe354e35939da1fe435c085317fe7c70::scamon {
    struct SCAMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMON>(arg0, 6, b"SCAMON", b"$SCAMON", b"SCAMON - is the dog that loves to scam...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b66bf3ee6acfa77199cae47dbdabf949_727b200c0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

