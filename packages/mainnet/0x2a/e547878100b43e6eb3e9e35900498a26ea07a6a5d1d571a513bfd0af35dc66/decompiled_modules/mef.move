module 0x2ae547878100b43e6eb3e9e35900498a26ea07a6a5d1d571a513bfd0af35dc66::mef {
    struct MEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEF>(arg0, 6, b"MEF", b"MemeFwends On SUI", b"ILL ALWAYS BE HERE FOR YOU. LOYAL AND TRUE AND AS YOUR BEST FWEND. ILL MAKE SURE I NEVER LET YOU DOWN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QK_Er_Un_EQ_400x400_4364a0fe41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

