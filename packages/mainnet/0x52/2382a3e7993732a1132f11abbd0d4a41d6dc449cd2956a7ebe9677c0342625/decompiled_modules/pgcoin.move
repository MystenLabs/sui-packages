module 0x522382a3e7993732a1132f11abbd0d4a41d6dc449cd2956a7ebe9677c0342625::pgcoin {
    struct PGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGCOIN>(arg0, 6, b"PGCOIN", b"Prolific Game Coin", b"Prolific Game Studio blends thrilling gameplay with cutting-edge blockchain rewardsbringing you the best of both worlds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250108_104458_595_6333849958.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

