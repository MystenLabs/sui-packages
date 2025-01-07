module 0xeb24dd557c2db266d9c672b80ee0841d0b5a83c7865f8b62f98090b6d49b2f51::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"BOOK OF SETH ON SUI", b"Creator of Klaus, Roger, Brian, Stewie, Peter & all other characters from Family Guy, The Cleveland Show & American Dad.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOOK_OF_2_9d539d9c6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

