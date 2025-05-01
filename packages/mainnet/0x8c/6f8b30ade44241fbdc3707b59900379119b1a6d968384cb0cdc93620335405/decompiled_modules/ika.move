module 0x8c6f8b30ade44241fbdc3707b59900379119b1a6d968384cb0cdc93620335405::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA>(arg0, 6, b"IKA", b"Ika CTO", b"Ika is the first sub-second Multi-Party Computation (MPC) network, delivering unmatched scalability with the ability to scale to 10,000 signatures per second (tps) and hundreds of signer nodes. Built with zero-trust, non-collusive architecture, Ika sets a new benchmark for speed and security in an interconnected Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086638_b78b248cfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

