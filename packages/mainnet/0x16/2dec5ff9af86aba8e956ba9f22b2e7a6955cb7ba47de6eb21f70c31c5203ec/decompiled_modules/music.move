module 0x162dec5ff9af86aba8e956ba9f22b2e7a6955cb7ba47de6eb21f70c31c5203ec::music {
    struct MUSIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSIC>(arg0, 6, b"MUSIC", b"DANCING CAT", b"DANCING CAT ON TEH FLOOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e6403e3803e56770e82f4fd6f5b1687_fe4ab6280d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

