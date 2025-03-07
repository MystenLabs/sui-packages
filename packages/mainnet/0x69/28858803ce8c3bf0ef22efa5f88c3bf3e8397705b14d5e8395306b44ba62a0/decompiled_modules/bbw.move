module 0x6928858803ce8c3bf0ef22efa5f88c3bf3e8397705b14d5e8395306b44ba62a0::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"BIG BANG WEB3", b"EXPLODE THIS SHIT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741325019139.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

