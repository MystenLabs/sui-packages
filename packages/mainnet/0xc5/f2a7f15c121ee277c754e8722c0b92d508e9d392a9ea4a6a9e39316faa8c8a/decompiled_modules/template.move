module 0xc5f2a7f15c121ee277c754e8722c0b92d508e9d392a9ea4a6a9e39316faa8c8a::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x257c42b89365dcef8db9e370fb2fe686f8272eb563cc79d77870d3b7b3c3c2f3::bonding_curve::BondingCurveStartCap<TEMPLATE>>(0x257c42b89365dcef8db9e370fb2fe686f8272eb563cc79d77870d3b7b3c3c2f3::bonding_curve::create_bonding_curve<TEMPLATE>(arg0, b"TOKEN_SYMBOL", b"TOKEN_NAME", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TOKEN_ICON_URL")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"SIG"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

