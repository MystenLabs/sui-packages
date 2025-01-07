module 0x293acda5b7f4e072dd76f2fd3a157bd506fc396cff968ff482849eb6d60c4722::immortaltrump {
    struct IMMORTALTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IMMORTALTRUMP>, arg1: 0x2::coin::Coin<IMMORTALTRUMP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IMMORTALTRUMP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IMMORTALTRUMP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: IMMORTALTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMMORTALTRUMP>(arg0, 6, b"IMMORTAL TRUMP ", b"TRUMP", b"YOU CANNOT KILL A DREAM https://www.immortaltrump.pro/  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmY3YpVcabYrXRo3gCTDBYRknEGECX8TnZXxGfwnhmfCDy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMMORTALTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMMORTALTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<IMMORTALTRUMP>, arg1: 0x2::coin::Coin<IMMORTALTRUMP>) : u64 {
        0x2::coin::burn<IMMORTALTRUMP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<IMMORTALTRUMP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<IMMORTALTRUMP> {
        0x2::coin::mint<IMMORTALTRUMP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

