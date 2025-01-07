module 0x363f22850eb46aacd3dd768848119671daaabd659c6b1dae487d69946d2f08b1::ch1hiro {
    struct Bank has key {
        id: 0x2::object::UID,
        hiro: 0x2::balance::Balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>,
        fct: 0x2::balance::Balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>) {
        0x2::balance::join<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::into_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(arg1));
    }

    public entry fun deposit_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>) {
        0x2::balance::join<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::into_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            hiro : 0x2::balance::zero<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(),
            fct  : 0x2::balance::zero<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_fct_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::into_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(0x2::balance::split<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::value<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(&arg1) * 10 / 70), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_hiro_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::into_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::value<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(&arg1) * 70 / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawal_hiro(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(0x2::balance::split<0xc895b10b793e25f7546b19f440c17aab7e530bfbc8cf1be7454799e930b98a5a::mycoin::MYCOIN>(&mut arg0.hiro, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

