module 0x5e394799972865c58e2d8831b981c3fbf3bcff49ed428b2227899b51c485669f::undine {
    struct UNDINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDINE>(arg0, 6, b"Undine", b"undine", x"756e64696e650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727980011772_edf6ef6463.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNDINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

