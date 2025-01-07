module 0xf28fd97c6a21d60c76bdb17a028b1a89034bf0bd17fac5f3d5be7972b54c559b::deng {
    struct DENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENG>(arg0, 6, b"DENG", b"POPDENG", b"Bringing in the combination of two solana narrative of $POPCAT and $MOODENG into #SUI ecosystem, Ride with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popdeng_27c0c9454c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

