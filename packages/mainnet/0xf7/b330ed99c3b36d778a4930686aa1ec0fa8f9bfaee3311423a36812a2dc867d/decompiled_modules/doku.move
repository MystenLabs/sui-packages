module 0xf7b330ed99c3b36d778a4930686aa1ec0fa8f9bfaee3311423a36812a2dc867d::doku {
    struct DOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKU>(arg0, 6, b"DOKU", b"Suidoku", b"Suidoku is a concept that combines the classic game of Sudoku with the Sui blockchain ecosystem. It could involve a puzzle game where users solve Sudoku grids to earn rewards or participate in a decentralized experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951510903.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

