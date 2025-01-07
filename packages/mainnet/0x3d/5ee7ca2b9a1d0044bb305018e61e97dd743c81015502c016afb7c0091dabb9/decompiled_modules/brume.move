module 0x3d5ee7ca2b9a1d0044bb305018e61e97dd743c81015502c016afb7c0091dabb9::brume {
    struct BRUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUME>(arg0, 6, b"BRUME", b"BRUME SUI", x"4272756d652057616c6c65740a5468652070726976617465205355492077616c6c65742077697468206275696c742d696e20546f72", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd0ebfe04adb5ef449ec5874e450810501dc53ed5_7e04a40ea8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

