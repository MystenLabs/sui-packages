module 0x6735517a4e46ddbba7f93aac40d78a268b609b2a23b1c24a4cee00664a432741::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLOKI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLOKI>(arg0, b"Sloki", b"SloKing", x"536c6f4b696e6720e280942074686520647269707069657374206b696e67206f6e205375692e205374616b6520796f757220626167732c207661756c7420796f7572204e4654732c20616e64206561726e206c696b6520726f79616c74792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQToxtBM8eZU8peb3TiD5Dj7ngFarfHK5vhDNtxRUgDs6")), b"WEBSITE", b"https://x.com/slokingonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00458478c85cbbdc96afbe7467da8753602e9b78e4b0b2cd2f51906d219a22234911d14c1837597db9375ba9a1b3b9d8557a8d5d924dcbfa08facab5c86e4d0f06d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748251937"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

