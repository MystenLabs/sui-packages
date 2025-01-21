module 0x271263df381851551f2d790244744f5355e785050f99ef95b342670e3bbb1131::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Performance AI", b"An all-in-one platform combining powerful Al solutions to enhance, secure, and personalize user interactions with digital tools and services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737424764904.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

