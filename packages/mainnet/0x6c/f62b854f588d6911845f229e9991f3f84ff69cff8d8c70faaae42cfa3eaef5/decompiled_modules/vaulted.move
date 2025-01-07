module 0x6cf62b854f588d6911845f229e9991f3f84ff69cff8d8c70faaae42cfa3eaef5::vaulted {
    struct VAULTED has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAULTED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULTED>(arg0, 6, b"VAULTED", b"VAULTED AI", b"VAULTED AI, integrated with SUI Network technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736052799880.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULTED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAULTED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

