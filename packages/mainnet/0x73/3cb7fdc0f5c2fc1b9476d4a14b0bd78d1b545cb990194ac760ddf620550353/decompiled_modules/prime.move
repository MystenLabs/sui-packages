module 0x733cb7fdc0f5c2fc1b9476d4a14b0bd78d1b545cb990194ac760ddf620550353::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 6, b"PRIME", b"PRIME MACHIN", b"Prime Machin #2550 manufactured by the Triangle Company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PM_cce7a96448.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

