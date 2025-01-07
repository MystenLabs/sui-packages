module 0xb3068136359fc86c4663457155e20fb59c00bb3958351a5364191843846639ee::skp {
    struct SKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKP>(arg0, 6, b"SKP", b"SKOP", b"Everything's on standby, don't say a word to anyone. In 5 hours, there'll be an official announcement on Twitter, but giving you a heads up early. Stay ready, well be the first to catch the moment. Keep it quiet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cp_D_Ii_Dm2_400x400_6324b73afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKP>>(v1);
    }

    // decompiled from Move bytecode v6
}

