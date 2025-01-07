module 0x7a0f8b05eaeba516bcccc89a5b7d8911b502041e4546c978d290bbdbf1cf8975::fool {
    struct FOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOL>(arg0, 6, b"FOOL", b"FOOLISH", b"WHAT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_6a96779a27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

