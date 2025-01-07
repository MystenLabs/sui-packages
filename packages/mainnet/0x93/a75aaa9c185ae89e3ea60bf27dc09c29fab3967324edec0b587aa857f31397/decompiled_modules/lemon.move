module 0x93a75aaa9c185ae89e3ea60bf27dc09c29fab3967324edec0b587aa857f31397::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 6, b"LEMON", b"LemonRocks", b"Guiding investors through the startup world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/747559b3_51af_4947_b83f_490042bf66ea_500d550e04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

