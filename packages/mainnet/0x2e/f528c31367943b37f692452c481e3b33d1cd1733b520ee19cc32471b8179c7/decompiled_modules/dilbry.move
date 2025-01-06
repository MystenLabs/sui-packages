module 0x2ef528c31367943b37f692452c481e3b33d1cd1733b520ee19cc32471b8179c7::dilbry {
    struct DILBRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILBRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DILBRY>(arg0, 6, b"DILBRY", b"Dilbry by SuiAI", b"Meet Dilbry. A bit stoopid when it comes time to fly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1733553390799_raw_84e47bbb59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DILBRY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILBRY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

