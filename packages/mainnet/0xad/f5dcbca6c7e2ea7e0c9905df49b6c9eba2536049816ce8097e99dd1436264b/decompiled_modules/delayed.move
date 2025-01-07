module 0xadf5dcbca6c7e2ea7e0c9905df49b6c9eba2536049816ce8097e99dd1436264b::delayed {
    struct DELAYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELAYED>(arg0, 6, b"DELAYED", b"More Hype More Fun", b"Delayed is bullish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_231000_d90ae09ba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELAYED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELAYED>>(v1);
    }

    // decompiled from Move bytecode v6
}

