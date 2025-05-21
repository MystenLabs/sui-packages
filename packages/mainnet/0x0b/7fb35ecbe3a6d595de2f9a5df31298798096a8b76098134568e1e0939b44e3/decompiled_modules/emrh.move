module 0xb7fb35ecbe3a6d595de2f9a5df31298798096a8b76098134568e1e0939b44e3::emrh {
    struct EMRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMRH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EMRH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EMRH>(arg0, b"EMRH", b"Elon Musk Hitler", b"Elon Musk raised by Hitler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRm85eqVAN6822hd76GdC4JFqZBq3cie5HCx3MXMFSUVT")), b"WEBSITE", b"https://x.com/niumbasr/status/1925251921410920576", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b6b6b1b3a9d1f4e2507a0a2ac178d0ced935135f76d2e5acf6667c50d2003cfdc3f00e91ef3f94ee343a990d6ee3e784614e6bf6253d71cc9127ca9f7e5aee0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747850928"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

