module 0x4feb52f89b84f8863994c51df72c3b34412484a8758e7c7cae420bfbd53cde3f::percy {
    struct PERCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERCY>(arg0, 6, b"PERCY", b"Percy Verence", b"RIP KEKIUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736022563525.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PERCY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERCY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

