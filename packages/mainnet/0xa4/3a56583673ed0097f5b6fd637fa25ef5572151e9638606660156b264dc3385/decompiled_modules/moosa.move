module 0xa43a56583673ed0097f5b6fd637fa25ef5572151e9638606660156b264dc3385::moosa {
    struct MOOSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSA>(arg0, 6, b"MOOSA", b"Moodeng Moosa", b"Moodeng Moosa On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOOSA_38f06e56a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

