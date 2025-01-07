module 0x72c9505de8c761ab22b5133d6af96b4e322a6366bcde6d2fbfaad6d232e10fa2::momonga {
    struct MOMONGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMONGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMONGA>(arg0, 6, b"MOMONGA", b"MOMONGA ON SUI", b"meme anime op", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_db0126b5fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMONGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMONGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

