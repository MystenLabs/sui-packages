module 0xe67eddfaa2e0271ea92b96e24b5baf2d472a12720dac694cc372bca8d7003d2b::xLuck {
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
        mint<XLUCK>(v2, 10000000000000000, arg1);
        0x2::transfer::public_transfer<MintAbility<XLUCK>>(v1, v0);
    }

    public entry fun mint<T0>(arg0: &mut MintAbility<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), 0x2::tx_context::sender(arg2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

