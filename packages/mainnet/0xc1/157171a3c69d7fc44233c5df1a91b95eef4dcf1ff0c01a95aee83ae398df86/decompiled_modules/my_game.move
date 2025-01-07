module 0xc1157171a3c69d7fc44233c5df1a91b95eef4dcf1ff0c01a95aee83ae398df86::my_game {
    struct Ming_XX_Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun DepositCoin(arg0: &mut Ming_XX_Game, arg1: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(arg1));
    }

    public entry fun WithdrawCoin(arg0: &AdminCap, arg1: &mut Ming_XX_Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>>(0x2::coin::from_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(0x2::balance::split<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ming_XX_Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Ming_XX_Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Ming_XX_Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = 0x2::coin::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&arg3);
        assert!(0x2::balance::value<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&arg0.val) >= v1 * 10, 0);
        if (arg2 == 0x2::random::generate_bool(&mut v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>>(0x2::coin::from_balance<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(0x2::balance::split<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>(&mut arg0.val, v1), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_faucet_coin::MING_XX_FAUCET_COIN>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            DepositCoin(arg0, arg3, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

