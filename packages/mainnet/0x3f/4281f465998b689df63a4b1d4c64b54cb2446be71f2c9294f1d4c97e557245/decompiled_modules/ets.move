module 0x3f4281f465998b689df63a4b1d4c64b54cb2446be71f2c9294f1d4c97e557245::ets {
    struct ETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETS>(arg0, 6, b"ETS", b"Eric Tremp", b"HEWWO MY NAME IS EWIC AND I WEVOLUTIONIZED NOFING!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6231_ce4556f7e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

