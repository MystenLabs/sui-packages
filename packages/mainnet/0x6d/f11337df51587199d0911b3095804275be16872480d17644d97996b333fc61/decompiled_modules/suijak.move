module 0x6df11337df51587199d0911b3095804275be16872480d17644d97996b333fc61::suijak {
    struct SUIJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJAK>(arg0, 6, b"SUIJAK", b"suijak coin", b"its over, solana has fallen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_13_63b44c88e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

