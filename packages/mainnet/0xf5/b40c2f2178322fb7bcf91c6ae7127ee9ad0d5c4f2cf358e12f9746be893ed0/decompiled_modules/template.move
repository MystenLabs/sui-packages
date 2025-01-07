module 0xf5b40c2f2178322fb7bcf91c6ae7127ee9ad0d5c4f2cf358e12f9746be893ed0::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::BondingCurveStartCap<TEMPLATE>>(0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::create_bonding_curve<TEMPLATE>(arg0, b"TOKENTWO", b"tokentwo", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/a7a8111f-9fb1-4df8-922b-a95bbf566806")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f5d65080e79718712a0f881840e41d0d1c88189e5b4fdab8a43689c13132767bdae67878e2167afd0c3f5af662d9c1f989b1f31d325a509f1380fc74190834062b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

