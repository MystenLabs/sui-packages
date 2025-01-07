module 0x2ec421b0e389611c4cbd173f6f7b577c99e13375386ba3862806571cda8ab6bd::amoodeng {
    struct AMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMOODENG>(arg0, 6, b"Amoodeng", b"Adeniyi moo deng", b"Memecoin of Moo Deng on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moo_4747831f7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

