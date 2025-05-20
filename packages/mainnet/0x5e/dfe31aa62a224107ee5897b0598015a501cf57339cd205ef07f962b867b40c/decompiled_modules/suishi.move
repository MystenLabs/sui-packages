module 0x5edfe31aa62a224107ee5897b0598015a501cf57339cd205ef07f962b867b40c::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUISHI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUISHI>(arg0, b"SUISHI", b"SUISHI COIN", b"$SUISHI is the freshest memecoin on SUI, fast, fun, and full of flavor. No promises. Just vibes !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQz1iPSb33L5zd6S7dLsekqiGo2pWb4xa19ZKa4TJbvd2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00555af786880b34b63bdb73328042a5b1b2aeac5a7c5792e48b90ba1dc430bd57a99f858c42e453bc1ab7613b7e1ae0143b1e3e1a03a79ff1b88c105be1d22d09d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766657"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

