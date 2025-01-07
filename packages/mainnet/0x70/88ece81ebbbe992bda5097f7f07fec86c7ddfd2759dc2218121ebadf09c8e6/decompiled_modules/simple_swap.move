module 0x7088ece81ebbbe992bda5097f7f07fec86c7ddfd2759dc2218121ebadf09c8e6::simple_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>,
        balance_b: 0x2::balance::Balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>,
    }

    public fun addLiquidityAC(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(&mut arg0.balance_a, 0x2::coin::into_balance<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(arg1));
    }

    public fun addLiquidityAFC(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(),
            balance_b : 0x2::balance::zero<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun swap_a_for_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(&mut arg0.balance_a, 0x2::coin::into_balance<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>>(0x2::coin::from_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(0x2::balance::split<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::value<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun swap_b_for_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>>(0x2::coin::from_balance<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(0x2::balance::split<0x8696a791cee006ffdf3378f4a90785f3b8955d0b1ea2bca993ba3136c96f868e::alexwaker_coin::ALEXWAKER_COIN>(&mut arg0.balance_a, 0x2::coin::value<0x2adc11d7339def7528121fb6302719cc37e588e4ea2672851efa8180c29037e5::alexwaker_faucet_coin::ALEXWAKER_FAUCET_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

