module 0x74b51dc02b3b9696ce2a431594d05de85ac2206ef51dcd6aed5a32950d5c14e3::longs {
    struct LONGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGS>(arg0, 6, b"LONGS", b"Long Sui", b"GO LONG ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_50116e5a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

