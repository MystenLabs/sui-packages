module 0x31f53dd5dc90fc1cb83b28d4f304d380ea08a7c2f3bcdf79cde7edcb35b02af0::val {
    struct VAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAL>(arg0, 6, b"VAL", b"Valhalla", b"Hold to Valhalla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1d76779ae436acfd4bd51d9fff219ace_6020d39391.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

