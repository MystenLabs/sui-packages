module 0x86e3f742de17f0370b1798acca28ab54ad6ee18a1c50890da4d2669fedde65c4::betsu {
    struct BETSU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: 0x2::coin::Coin<BETSU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BETSU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETSU>(arg0, 6, b"BETSU", b"BETS", b"Best online Bet sports on Sui   https://betsu.xyz/  https://x.com/betsui_official  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXPzGTNxr87R9icEM4ZN1aYUELh1NvGdZtUnwrqFFRebU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: 0x2::coin::Coin<BETSU>) : u64 {
        0x2::coin::burn<BETSU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BETSU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BETSU> {
        0x2::coin::mint<BETSU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

