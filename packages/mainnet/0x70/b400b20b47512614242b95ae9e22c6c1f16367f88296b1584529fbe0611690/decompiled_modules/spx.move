module 0x70b400b20b47512614242b95ae9e22c6c1f16367f88296b1584529fbe0611690::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SUISPX69000", b"SUISPX6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPX_3567ea4e6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

