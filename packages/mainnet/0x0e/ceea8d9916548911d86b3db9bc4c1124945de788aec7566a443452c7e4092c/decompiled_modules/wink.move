module 0xeceea8d9916548911d86b3db9bc4c1124945de788aec7566a443452c7e4092c::wink {
    struct WINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WINK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WINK>(arg0, b"WINK", b"WiNk", b"WINK FAN MADE TOKENS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdAQ1BVmEY1VM5MMX7xCMxGYQzXY72tDm2PXKKyNLVkJk")), b"wink.finance", b"https://x.com/winkfinance", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0096dd1d9df7a36d3869e5e4391ec477745a10e350a19959562795b1a27d433bfa30329c3a3b18731fa19de83d75179457556d24fc7b3d21e7d04b7594dc02710dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747790786"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

