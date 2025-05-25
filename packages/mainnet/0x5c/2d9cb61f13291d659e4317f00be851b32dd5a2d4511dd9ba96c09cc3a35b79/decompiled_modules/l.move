module 0x5c2d9cb61f13291d659e4317f00be851b32dd5a2d4511dd9ba96c09cc3a35b79::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<L>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<L>(arg0, b"L", b"Lawliet", x"2a2a224c61776c6965742028244c29206f6e20537569e28094696e737069726564206279204465617468204e6f7465e28099732067656e697573204c2e204120737465616c7468792c20636f6d6d756e6974792d64726976656e20746f6b656e2077697468206275726e732c204e4654732c20616e642044414f20766f74696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfJuF6ZHKZtFRrj8WLnapRwnKdZHew2AdGPF1Ug3VpSy1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ee162a0d86dfb7007c5d631561f678e5675abee965d2b3dc37c950bd0415553c6562bf49ce6c32074c18fcb6f3444190100032d7f539d7e391751ad27abccd05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748191942"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

