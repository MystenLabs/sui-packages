module 0x1f840592d19f435345e0040ca0969c0c74c6f5ce17490b356ec2b12628ea0e1a::demo {
    struct DEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO>(arg0, 6, b"DEMO", b"demo", b"free demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748435345125.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

