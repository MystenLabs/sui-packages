module 0x1d2ad138946bfc51922e2939bea6c3313693e7a54892ef14b8b63ec4ed881552::batk {
    struct BATK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATK>(arg0, 9, b"BATK", b"Bad Token", b"Bad Token 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BATK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATK>>(v1);
    }

    // decompiled from Move bytecode v6
}

