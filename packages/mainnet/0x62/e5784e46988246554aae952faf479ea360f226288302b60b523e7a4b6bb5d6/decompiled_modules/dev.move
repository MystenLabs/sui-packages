module 0x62e5784e46988246554aae952faf479ea360f226288302b60b523e7a4b6bb5d6::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"dev", b"i know the dev", b"iykyk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732779882683.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

