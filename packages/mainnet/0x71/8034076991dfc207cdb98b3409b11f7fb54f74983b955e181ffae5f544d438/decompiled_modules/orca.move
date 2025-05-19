module 0x718034076991dfc207cdb98b3409b11f7fb54f74983b955e181ffae5f544d438::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"Orca", b"Moon Orca", b"a large toothed whale with distinctive black and white markings and a prominent dorsal fin. It lives in groups that cooperatively hunt fish, seals, and penguins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicefgtdl3yriwk5mkuht6yghaqarlmfmyzpraufzyibndwalxxetm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORCA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

