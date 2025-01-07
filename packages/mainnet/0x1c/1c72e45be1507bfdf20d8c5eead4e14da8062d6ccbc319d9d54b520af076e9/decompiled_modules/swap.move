module 0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>,
        faucet_balance: 0x2::balance::Balance<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>,
    }

    public entry fun deposit(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>, arg2: &mut 0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>, arg3: u64, arg4: u64) {
        0x2::balance::join<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(0x2::coin::balance_mut<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(arg1), arg3));
        0x2::balance::join<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(0x2::coin::balance_mut<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(arg2), arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            coin_balance   : 0x2::balance::zero<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(),
            faucet_balance : 0x2::balance::zero<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(&arg0.faucet_balance) >= arg2, 1000);
        0x2::balance::join<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(0x2::coin::balance_mut<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>>(0x2::coin::take<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(&mut arg0.faucet_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(&arg0.coin_balance) >= arg2, 1000);
        0x2::balance::join<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(0x2::coin::balance_mut<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_faucet_coin::SD_FAUCET_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>>(0x2::coin::take<0x1c1c72e45be1507bfdf20d8c5eead4e14da8062d6ccbc319d9d54b520af076e9::sd_coin::SD_COIN>(&mut arg0.coin_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

