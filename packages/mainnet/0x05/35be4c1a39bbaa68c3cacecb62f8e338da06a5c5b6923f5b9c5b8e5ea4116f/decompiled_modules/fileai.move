module 0x535be4c1a39bbaa68c3cacecb62f8e338da06a5c5b6923f5b9c5b8e5ea4116f::fileai {
    struct FILEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FILEAI>(arg0, 6, b"FILEAI", b"JFK File by SuiAI", b"Token created to commemorate the release of the JFK Files after 60 years of hiding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/file_fc306457c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FILEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

