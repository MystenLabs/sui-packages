module 0xcf8134a8e3591c277e9d1c927f8d0fc3e28883a822bd9a485dded54a15741a08::bbdog {
    struct BBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBDOG>(arg0, 2, b"BBDOG", b"Baby dog", b"Baby dog!", 0x1::option::some<0x2::url::Url>(0xcf8134a8e3591c277e9d1c927f8d0fc3e28883a822bd9a485dded54a15741a08::icon::get_icon_url_by_url()), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BBDOG>>(0x2::coin::mint<BBDOG>(&mut v2, 80000000000000000 * 0xcf8134a8e3591c277e9d1c927f8d0fc3e28883a822bd9a485dded54a15741a08::tools::pow(10, 2), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

