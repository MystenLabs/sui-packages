module 0x8c65a393c6eb18d8671bae73d64d45f0ea73e01a63f37553bfb27a43f10bc19b::muttley {
    struct MUTTLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTTLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTTLEY>(arg0, 6, b"Muttley", b"MuttleyDog", b"MuttleyDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731751392904.11")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUTTLEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTTLEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

