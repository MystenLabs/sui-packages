module 0x45eadfc06f6666feb76e1aae62e4ea7552e2fa057b326fca595fa791b6092733::banger {
    struct BANGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANGER>(arg0, 6, b"BANGER", b"SUISAGE", b"Meet SUISAGE the tastiest banger fresh out the Sui kitchen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tg_b9e4c25c0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

