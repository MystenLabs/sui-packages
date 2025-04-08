module 0xa741092e55346816942611a1cef246cd989be1a23118782c8ce928bd8b9c8655::dskdjkdjs {
    struct DSKDJKDJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSKDJKDJS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DSKDJKDJS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DSKDJKDJS>(arg0, b"DSKDJKDJS", b"DSLKDSJK", b"asdoasdkd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001496054c38d4af8f559aa3a2e84a0943a1f65105adcadf64bfd8f60c1e3ae43d368d2d521a752de54334ea2d74004b6412c8e2b4d4bd1393ca18c9b9e5bd2a0cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744111828"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

