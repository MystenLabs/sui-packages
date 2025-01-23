module 0x54ab1a2f09682af6626e96fb4c116c32c5cd8ddd177866624d2a0412fc7a195b::sakamoto {
    struct SAKAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKAMOTO>(arg0, 6, b"SAKAMOTO", b"SakamotoSui", b"A retired legendary hitman who has settled into a quiet and mundane life as a family man in SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sakamoto_days_4ada950202.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKAMOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

