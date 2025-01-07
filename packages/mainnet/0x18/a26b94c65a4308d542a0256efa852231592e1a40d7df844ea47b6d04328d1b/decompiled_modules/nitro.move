module 0x18a26b94c65a4308d542a0256efa852231592e1a40d7df844ea47b6d04328d1b::nitro {
    struct NITRO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NITRO>, arg1: 0x2::coin::Coin<NITRO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NITRO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NITRO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: NITRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NITRO>(arg0, 6, b"NITRO ON SUI", b"NITRO", b"NITRO on SUI is the son of the half-billion Turbo coin on SUI. He follows dad's path to flip him and become a billion coin. https://x.com/blueducksui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWswEvvnKBrZzfpkfzfY7Q2TH34UypNDV6SEZV3NzrGLo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NITRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<NITRO>, arg1: 0x2::coin::Coin<NITRO>) : u64 {
        0x2::coin::burn<NITRO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<NITRO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<NITRO> {
        0x2::coin::mint<NITRO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

