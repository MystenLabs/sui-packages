module 0x14709a47dea5855e66f7f9bc8295ce17dc80c6f435acb7d8b22a40384a93cfea::sdlsjdk {
    struct SDLSJDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDLSJDK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SDLSJDK>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SDLSJDK>(arg0, b"SDLSJDK", b"SKJDk", b"asdsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cfdf21ba21216c707b3dd1bc217e374f34515ce6b5560169fc23ef6cb0cd1a34922e255a369272e8e706320007d26336337e417038664a4935dcbb165b7a1a0af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111993"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

