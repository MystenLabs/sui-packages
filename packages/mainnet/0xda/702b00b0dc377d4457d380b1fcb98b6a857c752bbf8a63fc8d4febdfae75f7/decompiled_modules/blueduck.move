module 0xda702b00b0dc377d4457d380b1fcb98b6a857c752bbf8a63fc8d4febdfae75f7::blueduck {
    struct BLUEDUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: 0x2::coin::Coin<BLUEDUCK>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEDUCK>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BLUEDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDUCK>(arg0, 6, b"Blue Duck", b"BDUCK", b"You were interested in dogs, cats, and frogs but you never gave love to the little ugly duckling. https://x.com/blueducksui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://gra.fun/fd59e837-69e8-4ec4-90ec-52770d487eaf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: 0x2::coin::Coin<BLUEDUCK>) : u64 {
        0x2::coin::burn<BLUEDUCK>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BLUEDUCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BLUEDUCK> {
        0x2::coin::mint<BLUEDUCK>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

