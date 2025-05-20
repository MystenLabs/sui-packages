module 0x2f51a0a5b620998ddbf5f452894993f3a0b41ca6453fbdece5194a670f1bcf19::centus {
    struct CENTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENTUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CENTUS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CENTUS>(arg0, b"Centus", b"Centus Protocol", x"546865206c656164696e672044455820616e64206c697175696469747920696e667261206f6e20235375692e20202343657475732c207768657265206f6e2d636861696e2074726164696e672068617070656e732e20f09f8c8a20f09f90b3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYFYBMmzqMRMJRxGWncrZYdiMw9tH3V3JjQxsHKWXNQjU")), b"cetus.zone", b"https://x.com/CetusProtocol", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00361c653315000b6fedc55520f9c35d1a5111abd6242899e15fc745036b5bf5036d46d3ba205b3a144be9b7af55bdadc6c98faa89b560eed26c3accf098119703d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759788"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

