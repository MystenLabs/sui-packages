module 0xdb9fbd16b07d1fc41ff1b011420fd5601befd560c00de373067cf27cba64e2f3::movesquid {
    struct MOVESQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVESQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVESQUID>(arg0, 6, b"MOVESQUID", b"MOVE SQUID GAME", b"SQUID GAME ON MOVEPUMP $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3937_b4e9029b84.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVESQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVESQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

