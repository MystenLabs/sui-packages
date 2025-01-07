module 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::scallop {
    struct ScallopSpoolAccountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow_spool_account<T0>(arg0: &0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault) : &0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::borrow_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    fun put_spool_account<T0>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault, arg1: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, arg1);
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = take_spool_account<T0>(arg0);
        let v1 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<T0, T1>(arg2, arg1, &mut v0, arg3, arg4);
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::put_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v1), arg4);
        put_spool_account<T0>(arg0, v0);
        0x2::coin::value<T1>(&v1)
    }

    public(friend) fun setup<T0>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::put_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg1, arg2, arg3));
    }

    public(friend) fun stake<T0>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = take_spool_account<T0>(arg0);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<T0>(arg1, &mut v0, 0x2::coin::from_balance<T0>(0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::take_balance<T0>(arg0, arg2), arg4), arg3, arg4);
        put_spool_account<T0>(arg0, v0);
    }

    fun take_spool_account<T0>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault) : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0> {
        let v0 = ScallopSpoolAccountKey<T0>{dummy_field: false};
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::take_object<ScallopSpoolAccountKey<T0>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>>(arg0, v0)
    }

    public(friend) fun unstake<T0>(arg0: &mut 0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::Vault, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = take_spool_account<T0>(arg0);
        0x6714649cfc41ccf45ca14a2469d08e2d188ae9743050dcdd1d5b82c637b31743::vault::put_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<T0>(arg1, &mut v0, arg2, arg3, arg4)), arg4);
        put_spool_account<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

