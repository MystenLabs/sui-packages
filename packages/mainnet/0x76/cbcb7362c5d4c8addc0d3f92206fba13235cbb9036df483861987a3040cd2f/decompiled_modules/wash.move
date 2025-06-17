module 0x76cbcb7362c5d4c8addc0d3f92206fba13235cbb9036df483861987a3040cd2f::wash {
    struct WASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASH>(arg0, 6, b"WASH", b"SUIWASH", x"24574153482069732074686520636c65616e657374206d656d65636f696e206f6e205355492e0a57652072696e736520746865206a656574732c207370696e2074686520727567732c20616e64206472792074686520636861727420677265656e2e0a4e6f20737461696e732e204a757374206761696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie5jl7c5gbguuwoelrq3phz5fpkkk7biy42n7kax7gjrxbffh4xei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

