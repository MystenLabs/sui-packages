module 0x30f7e774b9ef2c94bf6863267295a9b5dc1c10c63bbde6abe9cc9bddc6dd0762::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"BUBO On SUI", x"546865206d6f73742061646f7261626c65204f726361206f6e20245355492c206c61756e6368696e67207665727920736f6f6e206f6e204d6f766550756d70200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bubo_d0a35b1b43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

