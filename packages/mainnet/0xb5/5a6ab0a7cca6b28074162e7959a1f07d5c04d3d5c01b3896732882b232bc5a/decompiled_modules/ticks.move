module 0xb55a6ab0a7cca6b28074162e7959a1f07d5c04d3d5c01b3896732882b232bc5a::ticks {
    struct TICKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKS>(arg0, 6, b"Ticks", b"123123", b" data.name  data.name data.name ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730895775711.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

