module 0x7365d1ada6049f40309e0f62564a1be8a8b890a34241f4226363eeb7c5a790ae::suizenegger {
    struct SUIZENEGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZENEGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZENEGGER>(arg0, 6, b"Suizenegger", b"Arnold Suizenegger", b"I'll be back!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_116040f973.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZENEGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZENEGGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

