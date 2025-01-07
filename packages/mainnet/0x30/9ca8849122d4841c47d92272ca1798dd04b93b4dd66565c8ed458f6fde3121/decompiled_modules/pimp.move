module 0x309ca8849122d4841c47d92272ca1798dd04b93b4dd66565c8ed458f6fde3121::pimp {
    struct PIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMP>(arg0, 6, b"PIMP", b"Pimp on sui", b"a wild meme trend featuring  COME TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rpl_Q_Beze_400x400_ad200ad004.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

