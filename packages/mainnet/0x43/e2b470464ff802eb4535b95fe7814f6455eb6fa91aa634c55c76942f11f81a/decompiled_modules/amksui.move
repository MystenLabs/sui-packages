module 0x43e2b470464ff802eb4535b95fe7814f6455eb6fa91aa634c55c76942f11f81a::amksui {
    struct AMKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AMKSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AMKSUI>(arg0, b"AMKSUI", b"Delicious Sui", b"First Token mit Alles ohne Scharf!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2k8HcUmBwcds8rRpfNkYMznsT91USMa2jx4Zexwnaub")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d10614d586898a4a3a37976dd8dd67631756b29da5c9343848ceeff68538abfcaf508ced616003710bbb8423a40d0dc9ba0f9264be7bea7808169ca0e4883606d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747772307"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

