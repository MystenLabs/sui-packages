module 0x61ec5932437054038196fc75e53ce1d5f9e14a0f034170c4790ef8bc07dbd50a::suian {
    struct SUIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAN>(arg0, 6, b"SUIAN", b"SUIAN AI", b"FIRST GPT CHAT BOT by ANTHROPIC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_comical_and_exagge_1_df1372bedd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

