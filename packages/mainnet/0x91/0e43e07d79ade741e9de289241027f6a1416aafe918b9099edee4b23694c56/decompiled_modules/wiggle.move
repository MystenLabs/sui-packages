module 0x910e43e07d79ade741e9de289241027f6a1416aafe918b9099edee4b23694c56::wiggle {
    struct WIGGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLE>(arg0, 6, b"WIGGLE", b"Wiggle", b"Wiggle Wiggle Wiggle YEAH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731059347217.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIGGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

