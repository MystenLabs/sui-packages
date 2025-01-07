module 0xa7191f97a94276965f63ef7a2098a872ebddae1efd84857ff40354bd3b3d8ada::task5_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        USD: 0x2::balance::Balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>,
        RMB: 0x2::balance::Balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>,
        rate: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_RMB(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(arg1));
    }

    public entry fun deposit_USD(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(arg1));
    }

    public fun get_rate(arg0: &Bank) : u64 {
        arg0.rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            USD  : 0x2::balance::zero<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(),
            RMB  : 0x2::balance::zero<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(),
            rate : 7,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rate = arg2;
    }

    public entry fun swap_rmb2usd(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>>(0x2::coin::from_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(0x2::balance::split<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(&mut arg0.USD, 0x2::coin::value<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(&arg1) / arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_usd2rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>>(0x2::coin::from_balance<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(0x2::balance::split<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_faucet_coin::LAHEPARD_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::value<0xffb0128848d0d88c138f1d70739d4b5d4f55bd587729782704d25dadef29bfae::lahepard_coin::LAHEPARD_COIN>(&arg1) * arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

