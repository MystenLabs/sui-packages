module 0xfdc0f83141e2104ddddfe3fb6d845f53a9c9c992b57c74ab9f9a715a07cb5300::alfred {
    struct ALFRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALFRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALFRED>(arg0, 6, b"ALFRED", b"Alfred On Sui", b"ALFRED is making waves, but flipping $ALFRED is a monumental challenge!  The memecoin game is unpredictable, and momentum is everythinglets see where this cycle takes us.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062339_c60dede8be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALFRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALFRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

