module 0xd634359eff7d4900895356404b63a20dae458f0b5edb40175e9dc06865b2a0e5::net {
    struct NET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NET>(arg0, 6, b"NET", b"Nong Eva", b"Nong Eva Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732681763963.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

