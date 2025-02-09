module 0x20d73a687bb98ed5ab796442f68e7f12d32b6b633e6ca3eb29d7c363c0307649::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<MARS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"THE MARS", b"THE MARS ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.hiphop.fun/icon/ea625cee-9be5-4dd5-8e0a-b9771869c71c")), b"https://science.nasa.gov/mars/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a9a40520179f924a47473d480242c3ff253788be4d12d42f7fe5ee51d8f0e8480877d00a6faeeebf2648714eeb038af1ebeefc11e90d403cd754dc419dcaf008f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739104179"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

