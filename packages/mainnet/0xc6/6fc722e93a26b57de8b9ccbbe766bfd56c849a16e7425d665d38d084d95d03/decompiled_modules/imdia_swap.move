module 0xc66fc722e93a26b57de8b9ccbbe766bfd56c849a16e7425d665d38d084d95d03::imdia_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        mycoin: 0x2::balance::Balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>,
        myfaucetcoin: 0x2::balance::Balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(arg1));
    }

    public entry fun deposit_myfaucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::into_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id           : 0x2::object::new(arg0),
            mycoin       : 0x2::balance::zero<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(),
            myfaucetcoin : 0x2::balance::zero<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_mycoin_to_myfaucetcoin(arg0: &mut Bank, arg1: u64, arg2: 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(&mut arg0.mycoin, 0x2::coin::into_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::value<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(&arg2) * 73 / 10), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_myfaucetcoin_to_mycoin(arg0: &mut Bank, arg1: u64, arg2: 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&mut arg0.myfaucetcoin, 0x2::coin::into_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>>(0x2::coin::from_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(0x2::balance::split<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(&mut arg0.mycoin, 0x2::coin::value<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&arg2) * 10 / 73), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_mycoin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>>(0x2::coin::from_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(0x2::balance::split<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::coin::COIN>(&mut arg1.mycoin, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun withdraw_myfaucetcoin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x6b6c7b2c758e0a391cf636013f9ce177f6b81f4834a7d4c472e156d260148a2b::faucet_coin::FAUCET_COIN>(&mut arg1.myfaucetcoin, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

