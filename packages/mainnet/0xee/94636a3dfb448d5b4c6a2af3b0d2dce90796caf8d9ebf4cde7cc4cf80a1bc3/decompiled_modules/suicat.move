module 0xee94636a3dfb448d5b4c6a2af3b0d2dce90796caf8d9ebf4cde7cc4cf80a1bc3::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUICAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUICAT>(arg0, b"SUICAT", b"REAL SUI CAT", x"23534d5552464341542c206865206973207265616c2e20f09f8d842024534d5552462024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRBW9dLk9NoXc8mZnHXMEUQxPiegxi7q5jeEgW7vTaUAp")), b"https://t.co/I2uiOytQy5", b"https://x.com/smurfcat_sui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ce068ee0c129eba774172ec303836146e2016263c5807ed848fb69e5b082d1f443bc136df3a15c1af8aea0f06226ace0876f8ed3e0df63fc3de4563cf6ae4601d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770342"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

