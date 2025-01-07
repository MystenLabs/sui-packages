module 0xb390d0b2da850925ae5af448e8b057d79be14eb0141aa9a3855597a5c5d5f40e::xLuck {
    struct XLUCK has drop {
        dummy_field: bool,
    }

    struct MintAbility<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    fun init(arg0: XLUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MintAbility<XLUCK>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::balance::create_supply<XLUCK>(arg0),
        };
        let v2 = &mut v1;
        mint<XLUCK>(v2, 4000000000000000000, arg1);
        0x2::transfer::public_transfer<MintAbility<XLUCK>>(v1, v0);
    }

    public entry fun mint<T0>(arg0: &mut MintAbility<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe396f5271ce6a2f9ac54dbefea06850c7f94fdf915be1c60c9700ae69c657a26::nonTransferCoin::NonTransferCoin<T0>>(0xe396f5271ce6a2f9ac54dbefea06850c7f94fdf915be1c60c9700ae69c657a26::nonTransferCoin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), 0x2::tx_context::sender(arg2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

