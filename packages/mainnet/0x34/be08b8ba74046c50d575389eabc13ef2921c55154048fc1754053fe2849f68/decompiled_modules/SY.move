module 0x34be08b8ba74046c50d575389eabc13ef2921c55154048fc1754053fe2849f68::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-sUSDsui"), 0x1::string::utf8(b"SY-sUSDsui"), 0x1::string::utf8(b"SY token for Jitter Scallop sUSDsui."), 0x1::string::utf8(b"https://xmalnrwtxuhoijrcua3gf3y22fa3r5fjyvvrqjxyp4udip2uew7a.turbo-gateway.com/uwC2xtO9DuQmIqA2Yu8a0UG49KnFaxgm-H8oND9UJb4"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

