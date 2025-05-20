module 0xdceff915d2a057b89d7ebf0020198eea95e5601f8fb5740f457e65bc5422b93f::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAP>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAP>(arg0, b"CAP", b"CAP CTO", x"4c6f73742065766572797468696e67207573696e67206c657665726167652c206e6f7720492073706f7420616e64206368696c6c20f09f9aabf09fa7a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcT9dkDX14vtgyeNk2NAC5yWpjeU8ruLNxJjbf1UhN1Zm")), b"https://www.caponsui.com/", b"https://x.com/caponsui", b"DISCORD", b"https://t.me/caponsui", 0x1::string::utf8(b"00032af08af2d7ce706e1fb022226005bed2011c942b6c32548cc77a809cdc5320df05704769892b3bfd21e59ba929009d05bd7b2c6da5b3b70336993995374e06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758646"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

