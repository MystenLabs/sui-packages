module 0xd1dbddae9e0545f19954a924d7deb0e423504ed72525d14868e89866ded2cf37::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN>(arg0, 6, b"MAIN", b"Mainstream", b"For creators to define their own terms, turning digital rights into mainstream tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhzoqhphmryt6gpz2hgbfp2jr44cfmqwdv3ftkgjni2bc4ypetni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

