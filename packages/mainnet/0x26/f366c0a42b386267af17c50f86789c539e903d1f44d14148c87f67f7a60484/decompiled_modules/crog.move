module 0x26f366c0a42b386267af17c50f86789c539e903d1f44d14148c87f67f7a60484::crog {
    struct CROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROG>(arg0, 6, b"CROG", b"The crog", x"4a75737420612063726f6720696e206465207377656d70200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_025756_530_0dd5b53e80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

