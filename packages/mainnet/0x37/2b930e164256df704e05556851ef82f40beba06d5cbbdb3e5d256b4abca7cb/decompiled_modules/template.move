module 0x372b930e164256df704e05556851ef82f40beba06d5cbbdb3e5d256b4abca7cb::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::BondingCurveStartCap<TEMPLATE>>(0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::create_bonding_curve<TEMPLATE>(arg0, b"TOKENNINE", b"tokennine", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TOKEN_ICON_URL")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"SIGNATURE"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

