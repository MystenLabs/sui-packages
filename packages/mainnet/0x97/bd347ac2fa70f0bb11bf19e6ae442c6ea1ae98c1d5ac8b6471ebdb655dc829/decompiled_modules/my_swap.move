module 0x97bd347ac2fa70f0bb11bf19e6ae442c6ea1ae98c1d5ac8b6471ebdb655dc829::my_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        my_coin_balance: 0x2::balance::Balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>,
        faucet_coin_balance: 0x2::balance::Balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&mut arg0.faucet_coin_balance, 0x2::coin::into_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(arg1));
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(&mut arg0.my_coin_balance, 0x2::coin::into_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Pool{
            id                  : 0x2::object::new(arg0),
            my_coin_balance     : 0x2::balance::zero<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(),
            faucet_coin_balance : 0x2::balance::zero<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun swap_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(&arg1) * 10;
        assert!(v1 <= 0x2::balance::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&arg0.faucet_coin_balance), 0);
        deposit_my_coin(arg0, arg1, arg2);
        withdraw_faucet_coin(arg0, v1, v0, arg2);
    }

    public entry fun swap_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&arg1) / 10;
        assert!(v1 <= 0x2::balance::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(&arg0.my_coin_balance), 0);
        deposit_faucet_coin(arg0, arg1, arg2);
        withdraw_my_coin(arg0, v1, v0, arg2);
    }

    fun withdraw_faucet_coin(arg0: &mut Pool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>>(0x2::coin::from_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(0x2::balance::split<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&mut arg0.faucet_coin_balance, arg1), arg3), arg2);
    }

    fun withdraw_my_coin(arg0: &mut Pool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>>(0x2::coin::from_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(0x2::balance::split<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin::MING_XX_COIN>(&mut arg0.my_coin_balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

