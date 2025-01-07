module 0x83d7d4c1dce851fcc785bb85da813e8cf5730c8d380be17b522c70bbd90ab146::pepedeng {
    struct PEPEDENG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEDENG>, arg1: 0x2::coin::Coin<PEPEDENG>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEDENG>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEDENG>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PEPEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEDENG>(arg0, 6, b"PepeDeng", b"PENG", b"With MooDeng reaching great heights on SOL, it is time that SUI brings its own player to the match: With SUI now bullish again... along with it's beta, Pepe, it's time you meet PepeDeng! https://pepedeng.com/  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmbZBuB3cpuPmvTyWj9bStiKWtNBsicUhYUF83TmCzf1tc")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEDENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEDENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPEDENG>, arg1: 0x2::coin::Coin<PEPEDENG>) : u64 {
        0x2::coin::burn<PEPEDENG>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PEPEDENG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PEPEDENG> {
        0x2::coin::mint<PEPEDENG>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

