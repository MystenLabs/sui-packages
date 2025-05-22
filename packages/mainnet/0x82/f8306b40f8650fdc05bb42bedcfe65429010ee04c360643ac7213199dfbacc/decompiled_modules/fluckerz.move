module 0x82f8306b40f8650fdc05bb42bedcfe65429010ee04c360643ac7213199dfbacc::fluckerz {
    struct FLUCKERZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUCKERZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUCKERZ>(arg0, 6, b"FLUCKERZ", b"FLUCK", x"24464c55434b45525a2e207468652070656f706c652773206d656d6520636f696e2e0a54686520466c6f636b65727a207265766f6c7574696f6e61727920566f74652d546f2d4561726e20706c6174666f726d20707574732074686520504f57455220696e20796f75722068616e64732e0a0a41742074686520636f7265206f6620464c55434b45525a206c69657320466c6f636b746f7069612c2061207265766f6c7574696f6e6172792044414f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibysn4z43trqkwmc67xjltpryuikqodfzo3xa3sz53o3a3ujmsdzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUCKERZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUCKERZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

