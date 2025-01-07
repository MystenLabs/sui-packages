module 0x31a3153ab4ce9619eb2ca9846dc2862ae877f8d36c8071564b8b6264d7a56885::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELUGA", b"BelugaOnSui", b"The majestic $BELUGA is making waves in the Sui ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_Je_D1_TOY_400x400_fac29be9e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

