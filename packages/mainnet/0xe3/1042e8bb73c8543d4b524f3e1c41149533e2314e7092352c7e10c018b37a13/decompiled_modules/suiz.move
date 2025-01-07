module 0xe31042e8bb73c8543d4b524f3e1c41149533e2314e7092352c7e10c018b37a13::suiz {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZ>(arg0, 6, b"SuiZ", b"Sui Z", b"A comminity experiment to see what sui degens are made of. Join the tg to find out more..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061402_eb1c79bec7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

