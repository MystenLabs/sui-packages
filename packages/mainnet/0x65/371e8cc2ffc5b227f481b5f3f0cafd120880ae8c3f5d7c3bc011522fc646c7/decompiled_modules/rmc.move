module 0x65371e8cc2ffc5b227f481b5f3f0cafd120880ae8c3f5d7c3bc011522fc646c7::rmc {
    struct RMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMC>(arg0, 6, b"RMC", b"RocketManCoin", x"526f636b65744d616e20436f696e2028524d43292069732061206d656d6520636f696e20696e73706972656420627920676c6f62616c206576656e74732c2061696d696e6720746f206d616b65206120646966666572656e636520696e2074686520626c6f636b636861696e20776f726c642e2057697468206120626f6c6420766973696f6e20616e64207374726f6e6720636f6d6d756e69747920737570706f72742c2069742070726f6d69736573206c696d69746c6573732067726f77746820627920636f6d62696e696e672066756e20616e6420696e766573746d656e742e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736186396922.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

