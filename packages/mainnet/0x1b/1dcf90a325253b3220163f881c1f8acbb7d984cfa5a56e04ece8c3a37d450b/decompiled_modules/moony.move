module 0x1b1dcf90a325253b3220163f881c1f8acbb7d984cfa5a56e04ece8c3a37d450b::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"Moonshot", x"4d6f6f6e73686f7420737072656164696e672074686520677265656e20676f7370656c206f66206d656d6573207768696c6520756e6561727468696e6720746865206a75696369657374206f70706f7274756e697469657320696e20746865206d61726b6574207769746820414920736f6f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736174069097.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

