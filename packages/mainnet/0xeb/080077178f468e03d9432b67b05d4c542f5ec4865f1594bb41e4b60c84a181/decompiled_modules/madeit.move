module 0xeb080077178f468e03d9432b67b05d4c542f5ec4865f1594bb41e4b60c84a181::madeit {
    struct MADEIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADEIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADEIT>(arg0, 6, b"Madeit", b"I made it", x"546f6f6b206d65203132206d6f6e746873206f66206d656e74616c20746f72747572652c20626574726179616c2c20616e6420736c6565706c657373206e696768747320627574206e6f772049e280996d20686572652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735968390301.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADEIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADEIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

