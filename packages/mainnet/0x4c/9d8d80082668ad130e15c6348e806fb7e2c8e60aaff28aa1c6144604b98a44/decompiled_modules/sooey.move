module 0x4c9d8d80082668ad130e15c6348e806fb7e2c8e60aaff28aa1c6144604b98a44::sooey {
    struct SOOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOEY>(arg0, 6, b"SOOEY", b"Sooey The Pig", b"The Piggy Bank of the Future. First Animal Token on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3j_Tv_S61_400x400_880b31ca7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

