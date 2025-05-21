module 0x6f226fce270529743351bf25fa866712fae88fabba2ccba3ec9116cc0e0d309e::suishark {
    struct SUISHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHARK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUISHARK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUISHARK>(arg0, b"SUISHARK", b"SharKui on SUI", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"004123024fde4e34409dd388b03eef2a5d04a9e40a8c75c48d05ce8fe4211382dd5d8d607862c3d6e90a2145da302e5ed6688d841b8387ae38dec02fe1b247f802d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747845414"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

