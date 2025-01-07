module 0x86bbe22c972fc807653ca897aa1ef75c6763f2c34c85b9dc43e926c681ed14ea::wenking {
    struct WENKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENKING>(arg0, 6, b"WENKING", b"WEN KING", b"The $WENKING token is an innovative cryptocurrency operating on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bff79bd65e63067782714cdde1df28d4_f8cf95d739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

