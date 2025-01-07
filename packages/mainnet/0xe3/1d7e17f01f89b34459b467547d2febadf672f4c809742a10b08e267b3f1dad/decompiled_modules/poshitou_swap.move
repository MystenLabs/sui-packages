module 0xe31d7e17f01f89b34459b467547d2febadf672f4c809742a10b08e267b3f1dad::poshitou_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        faucet_coin: 0x2::balance::Balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>,
        my_coin: 0x2::balance::Balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun deposit_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(arg1));
    }

    entry fun deposit_my_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::into_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id          : 0x2::object::new(arg0),
            faucet_coin : 0x2::balance::zero<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(),
            my_coin     : 0x2::balance::zero<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun swap_faucet_coin_to_my_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>>(0x2::coin::from_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(0x2::balance::split<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::value<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&arg1) * 10), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun swap_mycoin_to_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::into_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::value<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(&arg1) * 1 / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun withdarw_faucet_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::faucet_coin::FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun withdraw_my_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>>(0x2::coin::from_balance<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(0x2::balance::split<0x388ecc0ef7261e40f7be055c723e4bf275d3eeb33eae3525e4b7096065b19b73::my_coin::MY_COIN>(&mut arg1.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

