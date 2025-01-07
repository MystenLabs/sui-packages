module 0x47f92d8eb78726b9638edee7f8ec19d22a62bfc00aaf94a432c6dc874c6d9ae8::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"PORING", b"PORING SUI", b"$PORING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973115778.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

