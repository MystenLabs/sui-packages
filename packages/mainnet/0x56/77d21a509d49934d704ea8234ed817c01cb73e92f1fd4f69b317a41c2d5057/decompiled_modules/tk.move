module 0x5677d21a509d49934d704ea8234ed817c01cb73e92f1fd4f69b317a41c2d5057::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"Turkey", b"A turkey that masters contract trading...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00169_3930638257_0295a10f49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TK>>(v1);
    }

    // decompiled from Move bytecode v6
}

