module 0xa537c7056d38953bdc7743d4d5839c135574cb014d79feb2586f888140705499::bduck {
    struct BDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDUCK>(arg0, 6, b"BDUCK", b"Blue Duck", b"You didnt appreciate him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_blueduck_6e20d7767e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

