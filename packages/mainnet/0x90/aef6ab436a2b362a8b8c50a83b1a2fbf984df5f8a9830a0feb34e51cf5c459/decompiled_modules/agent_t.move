module 0x90aef6ab436a2b362a8b8c50a83b1a2fbf984df5f8a9830a0feb34e51cf5c459::agent_t {
    struct AGENT_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT_T>(arg0, 9, b"T", b"Agent T", x"4167656e742054206973206120626f6c642c2041492d706f776572656420666f726365207769746820627261696e732c206265617574792c20616e6420707265636973696f6e2e204275696c7420746f206d6173746572205355492065636f73797374656d2c206974e280997320736d6172742c20736c65656b2c20616e6420616c776179732065766f6c76696e67e280946272696e67696e67206865617420746f20796f757220776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmP8ceaJGyKsMuthJPKDH56myNMqnPJiMwXEyPfS5t1F3U")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGENT_T>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT_T>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

