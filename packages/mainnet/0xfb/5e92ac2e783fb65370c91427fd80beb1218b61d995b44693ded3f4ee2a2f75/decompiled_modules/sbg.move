module 0xfb5e92ac2e783fb65370c91427fd80beb1218b61d995b44693ded3f4ee2a2f75::sbg {
    struct SBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBG>(arg0, 6, b"SBG", b"Silverback Gorilla", b"There's no time for you human", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibr2ecookhadi455kw4heur2qcp6qrpv3f5hnbi2ltyrmz7qiyane")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

