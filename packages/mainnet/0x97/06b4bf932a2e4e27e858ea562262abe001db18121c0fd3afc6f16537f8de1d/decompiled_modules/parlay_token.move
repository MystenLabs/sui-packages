module 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_token {
    struct PARLAY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARLAY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PARLAY_TOKEN>(arg0, 0, 0x1::string::utf8(b"PARLAY"), 0x1::string::utf8(b"Parlay Win Token"), 0x1::string::utf8(b"Proof of a winning parlay prediction. Each token represents one verified win on Parlay Markets."), 0x1::string::utf8(b"https://parlay-markets.vercel.app/parlay-token.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARLAY_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PARLAY_TOKEN>>(0x2::coin_registry::finalize<PARLAY_TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_batch(arg0: &mut 0x2::coin::TreasuryCap<PARLAY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PARLAY_TOKEN>>(0x2::coin::mint<PARLAY_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun mint_to_winner(arg0: &mut 0x2::coin::TreasuryCap<PARLAY_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PARLAY_TOKEN>>(0x2::coin::mint<PARLAY_TOKEN>(arg0, 1, arg2), arg1);
    }

    // decompiled from Move bytecode v7
}

