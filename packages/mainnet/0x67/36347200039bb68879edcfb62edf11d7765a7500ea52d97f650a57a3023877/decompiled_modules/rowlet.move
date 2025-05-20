module 0x6736347200039bb68879edcfb62edf11d7765a7500ea52d97f650a57a3023877::rowlet {
    struct ROWLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLET>(arg0, 6, b"ROWLET", b"ROWLET SUI", b"Soon bonded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnwkmfiiol42xpk2fpnr6xl3k7jjdjpforlwjj57qizuacrdruve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

