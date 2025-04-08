module 0x913324add3f0985236161014ae4e0c7fb456b1a04c6d54cf6f84b90fcbf12162::plan {
    struct PLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PLAN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PLAN>(arg0, b"PLAN", b"Planet", b"Planet Earth ss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e764afbbbe99c844a5db5b488a203efca4eb0049fc747bbc924c048498c6a433af6265c3060cc861fe9ac5bfdcd9c5d3502f725d4afb6c3382b5dce7120fc70ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111602"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

