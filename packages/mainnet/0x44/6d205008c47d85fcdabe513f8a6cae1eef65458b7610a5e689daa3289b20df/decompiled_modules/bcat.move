module 0x446d205008c47d85fcdabe513f8a6cae1eef65458b7610a5e689daa3289b20df::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::BondingCurveStartCap<BCAT>>(0xe223870f7e12e0adf8bc43c27ddc0293d8103d2255d7abf188e5fcc1f7781418::bonding_curve::create_bonding_curve<BCAT>(arg0, b"BCAT", b"Boredcat", b"Boredcat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/fe339ec8-943e-447b-8bff-f33cb84555bc")), b"https://www.baidu.com/", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"007a57ae1107e08186cd22b2c1c62cd6afef554da7a48829d3c413e93827690b9220c8eabc3288f71fcac087437e5906ba4aeb05ac959833f4f4e60ecfb80c83032b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

