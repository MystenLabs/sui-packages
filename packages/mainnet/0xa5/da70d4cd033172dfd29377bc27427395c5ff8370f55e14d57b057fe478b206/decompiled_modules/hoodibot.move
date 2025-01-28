module 0xa5da70d4cd033172dfd29377bc27427395c5ff8370f55e14d57b057fe478b206::hoodibot {
    struct HOODIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOODIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOODIBOT>(arg0, 6, b"HOODIBOT", b"HOODI BOT AI", b"FIRST HOODI BOT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/orange_logo_01_ea9af7577f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOODIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOODIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

