module 0x1248048594e2e448af63f5a2d3003c885e49b6509e7957155e55fc43522bb31a::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: 0x2::coin::Coin<TRUMP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP SUI", b"TRUMP", b"$TRUMP on $SUI MAKE SUI GREAT AGAIN!  https://x.com/realDonaldTrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmW6HgCSNYqMnHR1m6nd1YNFt1kDFsqCdxqQyZ9dAdmyXw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: 0x2::coin::Coin<TRUMP>) : u64 {
        0x2::coin::burn<TRUMP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRUMP> {
        0x2::coin::mint<TRUMP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

