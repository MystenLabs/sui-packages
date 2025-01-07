module 0x79d272817cd1c6afab65867194efc8dd482fa70de6ea98ffd6f34421d485e15f::shashimi {
    struct SHASHIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHASHIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHASHIMI>(arg0, 6, b"SHASHIMI", b"SHASISUI", x"4920616d2044656c6963696f7365206f6973686969200a6861707079207368617368696d6920686170707920737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shashisui_6280f80fa8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHASHIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHASHIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

