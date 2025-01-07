module 0xcd954b49c9dec942a1a752f5823a7f838bd479ac6edefe250e72fe34542850ec::ttrumpai {
    struct TTRUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTRUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTRUMPAI>(arg0, 6, b"TTRUMPAI", b"TECH TRUMP AI", b"Let's make this nation great again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRUMP_AI_LOGO_e19eb8791a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTRUMPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTRUMPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

