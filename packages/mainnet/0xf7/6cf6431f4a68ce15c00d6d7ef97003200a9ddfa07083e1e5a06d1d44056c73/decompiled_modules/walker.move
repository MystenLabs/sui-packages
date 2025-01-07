module 0xf76cf6431f4a68ce15c00d6d7ef97003200a9ddfa07083e1e5a06d1d44056c73::walker {
    struct WALKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALKER>(arg0, 6, b"WALKER", b"You Never Walk Alone", b"Bitcoin! You never walk alone. I am walker, You are walker, We are walkers -chilled wakers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732294608695.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

