module 0x394e0ad475d9763c55fdb129e4d27a67b546fef5d31a58b68e2ce5042421de8d::tish {
    struct TISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TISH>(arg0, 6, b"TISH", b"ONLYSHIT by SuiAI", b"TISHHHH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/108015006_gettyimages_590062982_45136221d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TISH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

