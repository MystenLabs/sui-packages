module 0x6a4dfdc99df393fb981411e0f92d374afc98f8565b5c1e982948c008a70948d5::esLuck {
    struct ESLUCK has drop {
        dummy_field: bool,
    }

    struct MintAbility<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    fun init(arg0: ESLUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MintAbility<ESLUCK>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::balance::create_supply<ESLUCK>(arg0),
        };
        let v2 = &mut v1;
        mint<ESLUCK>(v2, 4000000000000000000, arg1);
        0x2::transfer::public_transfer<MintAbility<ESLUCK>>(v1, v0);
    }

    public entry fun mint<T0>(arg0: &mut MintAbility<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::NonTransferCoin<T0>>(0x1c7e4548a40742d9545125a815941067bfe9720ef3ded3f1a10999e589cc5fd5::nonTransferCoin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), 0x2::tx_context::sender(arg2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

