module 0xec5bfa40162b58577e8d0c04de663e375b69a4655ff30efa4380692347cfb483::test15401_ha {
    struct TEST15401_HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST15401_HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST15401_HA>(arg0, 6, b"Test15401_ha", b"Test15401_hatest", b"Test15401_hatest_cim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiblefnzylqapid43vgrdaoupivxanbvgark7kylhmzqhyxqcg2p44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST15401_HA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST15401_HA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

