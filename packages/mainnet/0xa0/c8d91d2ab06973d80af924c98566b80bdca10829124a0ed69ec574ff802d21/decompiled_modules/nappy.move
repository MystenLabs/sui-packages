module 0xa0c8d91d2ab06973d80af924c98566b80bdca10829124a0ed69ec574ff802d21::nappy {
    struct NAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAPPY>(arg0, 6, b"NAPPY", b"NAPPY zZz", b"Meet Nappy, the sleepiest member of the group. He was so deep in slumber that he missed the invitation to join the Boys' Club, a regret he's carried ever since.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nappy_a9c0ce78c8_c4081c902e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

