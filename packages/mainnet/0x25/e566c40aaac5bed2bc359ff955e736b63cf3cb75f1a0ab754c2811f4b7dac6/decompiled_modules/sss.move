module 0x25e566c40aaac5bed2bc359ff955e736b63cf3cb75f1a0ab754c2811f4b7dac6::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sui Super Stars", b"A unique blend of gaming, memes, and community-driven innovation on the SUI blockchain. Whether you're here for the fun or the future, $SSS has something for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic6pt42ndhqrbtorvm356bmkuenjlvihmigzrup7nubl5tcmnoyxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

