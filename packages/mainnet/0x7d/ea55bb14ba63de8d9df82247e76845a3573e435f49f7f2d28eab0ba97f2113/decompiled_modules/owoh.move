module 0x7dea55bb14ba63de8d9df82247e76845a3573e435f49f7f2d28eab0ba97f2113::owoh {
    struct OWOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWOH>(arg0, 6, b"Owoh", b"tets", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731036191487.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWOH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWOH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

