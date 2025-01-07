module 0x3c756a1b3f62a23d7eea57e9ceb7e75ff31df40d51a484bc1dc0ae0146576a16::suibet {
    struct SUIBET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBET>, arg1: 0x2::coin::Coin<SUIBET>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBET>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBET>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIBET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBET>(arg0, 6, b"SUIBET", b"SUIBET", b"First sui gambling game on Sui  https://x.com/BonkBetingBot https://suibet.vip/ https://t.me/suibetportal  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmYdAkuPf89vnoJgVzDiFjAMU6hJSUBxLSedLoHnacNRgP")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBET>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIBET>, arg1: 0x2::coin::Coin<SUIBET>) : u64 {
        0x2::coin::burn<SUIBET>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIBET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIBET> {
        0x2::coin::mint<SUIBET>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

