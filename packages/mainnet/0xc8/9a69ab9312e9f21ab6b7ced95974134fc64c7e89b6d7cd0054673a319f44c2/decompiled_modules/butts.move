module 0xc89a69ab9312e9f21ab6b7ced95974134fc64c7e89b6d7cd0054673a319f44c2::butts {
    struct BUTTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTS>(arg0, 6, b"BUTTS", b"SUI BUTTS", b"The first  BUTTS on SUI blockchain!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t0009_beed45cfcc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

