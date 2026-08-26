module 0x227af49bfedb4f2eca29088086896dec6642c94ca52476f6e4c6ff17a555f80a::tl {
    struct TL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TL>(arg0, 6, b"TL", b"Tideline", b"A systematic mean-reversion strategy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

