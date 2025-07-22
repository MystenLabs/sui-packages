module 0xaa4349205613c8a231dbfe41bdb9a0582479c0b654ac4b7aec444a1adb948567::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG>(arg0, 6, b"STG", b"Sui step guy", b"Stg good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieafyytaehputik6xz22kd2otq2gfq5ywbmycay2kweomdjvu736u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

