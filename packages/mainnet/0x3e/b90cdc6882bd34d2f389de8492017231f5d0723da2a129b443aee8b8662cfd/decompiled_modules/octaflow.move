module 0x3eb90cdc6882bd34d2f389de8492017231f5d0723da2a129b443aee8b8662cfd::octaflow {
    struct OCTAFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OCTAFLOW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OCTAFLOW>(arg0, b"OCTAFLOW", b"OctaFlow", b"OctaFlow, is the octopus that has 8 different flows!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQY68JYQAyuDvp33ME8nuU8B11dPgMuMtFQKNScA3y6oL")), b"WEBSITE", b"https://x.com/OctaFlowSui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0003dc9fbc574f866d1ac57ec0be4b7e9883f26c9366bcd7742be0da17becf8c91abdca5278684cfa02fb345902aed619ca6090028ab8e2c4b1fbe6544267f660ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757500"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

