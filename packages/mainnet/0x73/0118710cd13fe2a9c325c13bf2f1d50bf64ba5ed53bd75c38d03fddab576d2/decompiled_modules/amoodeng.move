module 0x730118710cd13fe2a9c325c13bf2f1d50bf64ba5ed53bd75c38d03fddab576d2::amoodeng {
    struct AMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMOODENG>(arg0, 6, b"Amoodeng", b"Adeniyi moo deng", b"Cute Adeniyi moo deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoa_0b2b025269.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

