module 0x3e92459b19fe25b2735506828aecd63b7bb9266aae30ea6103c1cc829c7fbaaa::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: 0x2::coin::Coin<DINO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DINO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"$DINO", b"Dino Sui", b"Desentralized memes Of Sui!   https://www.dinoss.xyz/   https://x.com/dino_sui    https://t.me/+KOgz6SULIII4YzQ1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRbBbTQoQveAG7oEJtF8oy38at7H2wQwfoqP51wEB43K6")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: 0x2::coin::Coin<DINO>) : u64 {
        0x2::coin::burn<DINO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DINO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DINO> {
        0x2::coin::mint<DINO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

