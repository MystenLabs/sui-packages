module 0xb9c15d391e2dde907e18c041c2e9494c55bc035387b3877762238a342c609572::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<HIPPO>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<HIPPO>(arg0, b"Hippo", b"Sunged", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"https://www.youtube.com/", b"https://x.com/", b"https://discord.com/", b"https://t.me/", 0x1::string::utf8(b"00fb75f72aed0e583215180a870bf87073ae58cc6853ee96662b5f7d8016aa39df3bc327251ee6b5b6c7eaeff6da5c073c1a5edb34b48ee38dd1cd7a80ec5c7905f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745845943"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

