module 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::scallop {
    struct ScallopSpoolAccountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow_spool_account<T0>(arg0: &0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault) : &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::borrow_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    fun put_spool_account<T0>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault, arg1: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, arg1);
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = take_spool_account<T0>(arg0);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<T0, T1>(arg2, arg1, &mut v0, arg3, arg4);
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::put_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1), arg4);
        put_spool_account<T0>(arg0, v0);
        0x2::coin::value<T1>(&v1)
    }

    public(friend) fun setup<T0>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg1, arg2, arg3));
    }

    public(friend) fun stake<T0>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = take_spool_account<T0>(arg0);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<T0>(arg1, &mut v0, 0x2::coin::from_balance<T0>(0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::take_balance<T0>(arg0, arg2), arg4), arg3, arg4);
        put_spool_account<T0>(arg0, v0);
    }

    fun take_spool_account<T0>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::take_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    public(friend) fun unstake<T0>(arg0: &mut 0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = take_spool_account<T0>(arg0);
        0x7bbeb35546e17fcd59457ccbd5bf4bd5d32017df14b5df00776dc4caa7bbdb7e::vault::put_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<T0>(arg1, &mut v0, arg2, arg3, arg4)), arg4);
        put_spool_account<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

