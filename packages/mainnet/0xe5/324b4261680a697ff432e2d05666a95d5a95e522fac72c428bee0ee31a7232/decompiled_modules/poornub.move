module 0xe5324b4261680a697ff432e2d05666a95d5a95e522fac72c428bee0ee31a7232::poornub {
    struct POORNUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POORNUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORNUB>(arg0, 6, b"POORNUB", b"Poor nub", b"Poornub only for 18+ . kids not allowed  .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nub_3332e2cd1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORNUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POORNUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

