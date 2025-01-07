module 0x2b253752da129a6a251c57fd379ae84e2a7cdf484a2a6eae0f232960379ae050::trumpstar {
    struct TRUMPSTAR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: 0x2::coin::Coin<TRUMPSTAR>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPSTAR>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TRUMPSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSTAR>(arg0, 6, b"TRUMPS", b"Trumpstar", b"$TRUMPS was developed to make meme culture great again. No utility, Only Meme SUI  https://www.trumpstars.org/   https://x.com/trumpstar_sui  https://t.me/trumpstar_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmW6HgCSNYqMnHR1m6nd1YNFt1kDFsqCdxqQyZ9dAdmyXw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSTAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSTAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: 0x2::coin::Coin<TRUMPSTAR>) : u64 {
        0x2::coin::burn<TRUMPSTAR>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRUMPSTAR> {
        0x2::coin::mint<TRUMPSTAR>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

