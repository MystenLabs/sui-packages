module 0xd80653d568c836a17a5bef6802bc109512fdc653c93ceb4399c9d557d83c872b::ch1hiro {
    struct Bank has key {
        id: 0x2::object::UID,
        hiro: 0x2::balance::Balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>,
        fct: 0x2::balance::Balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>) {
        0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(arg1));
    }

    public entry fun deposit_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>) {
        0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            hiro : 0x2::balance::zero<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(),
            fct  : 0x2::balance::zero<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_fct_hiro(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(0x2::balance::split<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::value<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&arg1) * 10 / 100), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_hiro_fct(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(&mut arg0.hiro, 0x2::coin::into_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::faucetcoin::FAUCETCOIN>(&mut arg0.fct, 0x2::coin::value<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(&arg1) * 100 / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawal_hiro(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>>(0x2::coin::from_balance<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(0x2::balance::split<0xc7c30bd553be900eef338dd9b07b46804f6fb7e946f39433ed1cbc636bc67a19::mycoin::MYCOIN>(&mut arg0.hiro, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

