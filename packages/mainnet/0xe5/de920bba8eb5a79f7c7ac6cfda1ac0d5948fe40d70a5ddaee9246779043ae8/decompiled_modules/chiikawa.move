module 0xe5de920bba8eb5a79f7c7ac6cfda1ac0d5948fe40d70a5ddaee9246779043ae8::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 9, b"CHIIKAWA", b"Chiikawa coin", x"54686520637574657374206d6173636f74206f6e2073756920f09f93a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHIIKAWA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

