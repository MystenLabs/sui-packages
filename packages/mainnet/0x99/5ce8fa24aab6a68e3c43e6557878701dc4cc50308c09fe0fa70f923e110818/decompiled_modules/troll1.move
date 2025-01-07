module 0x995ce8fa24aab6a68e3c43e6557878701dc4cc50308c09fe0fa70f923e110818::troll1 {
    struct TROLL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL1>(arg0, 6, b"TROLL1", b"troll1", b"troll1 troll1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731556586863.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

