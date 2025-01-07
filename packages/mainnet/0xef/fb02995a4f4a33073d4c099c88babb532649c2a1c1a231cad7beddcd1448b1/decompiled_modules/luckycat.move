module 0xeffb02995a4f4a33073d4c099c88babb532649c2a1c1a231cad7beddcd1448b1::luckycat {
    struct LUCKYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKYCAT>(arg0, 6, b"LUCKYCAT", b"LUCKY SUI CAT", b"THE MITIC CHINESE LUCKY CAT ON SUI. BUY IT FOR A LUCKY YEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st1_67831e7583.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

