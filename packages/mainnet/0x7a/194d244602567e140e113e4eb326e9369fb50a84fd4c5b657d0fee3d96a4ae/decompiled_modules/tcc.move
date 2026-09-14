module 0x7a194d244602567e140e113e4eb326e9369fb50a84fd4c5b657d0fee3d96a4ae::tcc {
    struct TCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TCC>(arg0, 9, 0x1::string::utf8(b"TCC"), 0x1::string::utf8(b"TRADING CARD COIN"), 0x1::string::utf8(b"Trading Card Coin on Sui"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeibb5i5ryot6rm2scov2ku7xlb6dcghnwych6ra42ign2z5jviupby"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TCC>>(0x2::coin_registry::finalize<TCC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

