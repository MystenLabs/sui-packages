module 0x65488edcdb76e9d2ac1e187d226d9dc3afe6bcb90776853d882f9666b8c730e8::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIT DOG", b"The dog in a suit invites everyone into the world of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUIT_f63338c5b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

