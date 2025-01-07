module 0x3cc5180166c6f82621be56f01e5042e39cba5b0b74de54c8ba910edaea91fcdc::wator {
    struct WATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATOR>(arg0, 6, b"WATOR", b"Wator", b"Be the Wator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732194003523.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

