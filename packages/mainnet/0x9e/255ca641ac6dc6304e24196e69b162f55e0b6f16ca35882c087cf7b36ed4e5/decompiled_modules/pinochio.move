module 0x9e255ca641ac6dc6304e24196e69b162f55e0b6f16ca35882c087cf7b36ed4e5::pinochio {
    struct PINOCHIO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PINOCHIO>, arg1: 0x2::coin::Coin<PINOCHIO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PINOCHIO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PINOCHIO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PINOCHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINOCHIO>(arg0, 6, b"Pinocchio", b"OCCHI", b"Paradigm-Shifting Free-to-Play Strategic Development NFT game.Redefining P2E: A New Era of P2E+ #Sui  https://www.pinocchioo.tech/  https://x.com/pinocchiosui  https://t.me/pinocchiosui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXskGAbLYXy8nsDzDAuU9xLm61kqYjHHzSE1w7jqG7dYK")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINOCHIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINOCHIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PINOCHIO>, arg1: 0x2::coin::Coin<PINOCHIO>) : u64 {
        0x2::coin::burn<PINOCHIO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PINOCHIO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PINOCHIO> {
        0x2::coin::mint<PINOCHIO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

