module 0xbe9b82b514824136fec7170e7bb783cbe2b4d3cfb4d1dca873d2e005047e36b::minion {
    struct MINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINION>(arg0, 9, b"MINION", b" Minions INU", b"MINION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/23926.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MINION>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINION>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINION>>(v1);
    }

    // decompiled from Move bytecode v6
}

