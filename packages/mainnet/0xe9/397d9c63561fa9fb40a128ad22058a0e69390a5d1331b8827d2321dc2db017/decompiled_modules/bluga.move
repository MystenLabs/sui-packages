module 0xe9397d9c63561fa9fb40a128ad22058a0e69390a5d1331b8827d2321dc2db017::bluga {
    struct BLUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUGA>(arg0, 6, b"BLUGA", b"Blugaonsui", b"Smile and whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038999_054ca1d310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

