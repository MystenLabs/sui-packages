module 0x571a748747d0b3583a4ca885806a7d373f08f19deecebf568b3e68b2bb07c457::blazeleon_faucet {
    struct BLAZELEON_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZELEON_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZELEON_FAUCET>(arg0, 9, b"BLAZELEON_FAUCET", b"blazeleon_faucet", b"Make web3 great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/48305889")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAZELEON_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BLAZELEON_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

