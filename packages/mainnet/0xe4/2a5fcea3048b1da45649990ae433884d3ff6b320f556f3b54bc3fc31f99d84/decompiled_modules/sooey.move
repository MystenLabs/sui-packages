module 0xe42a5fcea3048b1da45649990ae433884d3ff6b320f556f3b54bc3fc31f99d84::sooey {
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

