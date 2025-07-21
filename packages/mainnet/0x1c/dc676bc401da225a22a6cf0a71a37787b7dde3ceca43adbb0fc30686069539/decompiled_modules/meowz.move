module 0x1cdc676bc401da225a22a6cf0a71a37787b7dde3ceca43adbb0fc30686069539::meowz {
    struct MEOWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEOWZ>(arg0, 6, b"MEOWZ", b"Meowz Cat", b"Born to Nap. Built to Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/efa9a3b5_b810_42c4_93a7_ba411f3c197e_2a4ab350ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOWZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

