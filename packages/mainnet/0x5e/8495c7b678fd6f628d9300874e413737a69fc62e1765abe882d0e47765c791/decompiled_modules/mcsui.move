module 0x5e8495c7b678fd6f628d9300874e413737a69fc62e1765abe882d0e47765c791::mcsui {
    struct MCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCSUI>(arg0, 6, b"MCSUI", b"Mc Sui", b"I will help   you retire and   achieve   financial freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_15_02_16_42_bbf39bd0ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

