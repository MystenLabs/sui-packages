module 0xfc434acb48b7a2562902e0eedbce2dacea5b2e8d088f352f056f878d2939d820::wandar {
    struct WANDAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANDAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WANDAR>(arg0, 6, b"WANDAR", b"Wandar by SuiAI", b"Sui king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f481cb89_f276_4152_af56_ce63bbf6828a_182230fa2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WANDAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANDAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

