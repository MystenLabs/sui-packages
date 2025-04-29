module 0xeb9af6fecdef4c57855a903b0193fb7326fa35ce0377ea684db185a688270eec::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SKULL>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SKULL>(arg0, b"SKULL", b"skull", b"skeletal framework of the head of vertebrates, composed of bones or cartilage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ7WQ72jrhep2nfNdezbYPpX3jqeAUnjYYTU2mnZvjNDZ")), b"https://www.britannica.com/science/skull", b"https://x.com/skull", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001eab575fe8cb39e30943fbf773485e8dce0c235a5a705fea7fafc634eba36314f1fca2ed7c6e86367ad6d47423030302edea794325c9a3b178b48293dfddf80ef5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745920901"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

