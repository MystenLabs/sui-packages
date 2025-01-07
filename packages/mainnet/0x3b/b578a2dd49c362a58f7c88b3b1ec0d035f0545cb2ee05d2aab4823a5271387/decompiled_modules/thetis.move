module 0x3bb578a2dd49c362a58f7c88b3b1ec0d035f0545cb2ee05d2aab4823a5271387::thetis {
    struct THETIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THETIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THETIS>(arg0, 6, b"THETIS", b"TheTis", b"The Thetis project will be the world's first ever commercial Block matrix technology, A Block matrix is a new, innovative idea in the blockchain industry, essentially a block matrix is an ecosystem of several different blockchains that are all interconnected and communicating with each other's individual blockchains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726628681542_67440b8d93fec33448403d1bcd84ce7f_ca663a9fe5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THETIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THETIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

