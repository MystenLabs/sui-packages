module 0x81c94e5e822c3292654773247684a16a98f93ee4acac8b0bea129f712d3e582c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TEST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TEST>(arg0, b"TEST", b"TESTs", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmexygpth6wwmVRxTk6iLmu1YjrqZBHeAymFQb24jHHmty")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0070007f030409026b7568d07ebe75dafb3a65be2ed7522d47ae146b7004e6f49344a5c9d67c715b9421481893eb55b8d91e981bce0dbbcd3938688ca32f6efc00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756782"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

