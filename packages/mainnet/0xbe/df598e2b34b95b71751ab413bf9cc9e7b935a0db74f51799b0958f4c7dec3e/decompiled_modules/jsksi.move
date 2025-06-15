module 0xbedf598e2b34b95b71751ab413bf9cc9e7b935a0db74f51799b0958f4c7dec3e::jsksi {
    struct JSKSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSKSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSKSI>(arg0, 6, b"JSKSI", b"idjjdj", b"jeksksksins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiet3e62isdeg6rmr4zhds5hxc4p6f464huviyikfs37iwrqecv33i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSKSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JSKSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

