module 0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        zzf222_coin: 0x2::balance::Balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>,
        zzf222_faucet_coin: 0x2::balance::Balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>,
    }

    public entry fun deposit_zzf222_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(&mut arg0.zzf222_coin, 0x2::coin::into_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(arg1));
    }

    public entry fun deposit_zzf222_faucetcoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg0.zzf222_faucet_coin, 0x2::coin::into_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                 : 0x2::object::new(arg0),
            zzf222_coin        : 0x2::balance::zero<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(),
            zzf222_faucet_coin : 0x2::balance::zero<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_zzf222_coin_to_zzf222_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(&mut arg0.zzf222_coin, 0x2::coin::into_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(0x2::balance::split<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg0.zzf222_faucet_coin, 0x2::coin::value<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(&arg1) * 1000 / 2000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_zzf222_faucet_coin_to_zzf222_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg0.zzf222_faucet_coin, 0x2::coin::into_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>>(0x2::coin::from_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(0x2::balance::split<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(&mut arg0.zzf222_coin, 0x2::coin::value<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&arg1) * 2000 / 1000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_zzf222_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>>(0x2::coin::from_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(0x2::balance::split<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_coin::ZZF222_COIN>(&mut arg1.zzf222_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_zzf222_faucet_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>>(0x2::coin::from_balance<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(0x2::balance::split<0xc15c1483fe48ef1aed79376fc78ab5e83441482f909a76f4553dca580edebe61::zzf222_faucet_coin::ZZF222_FAUCET_COIN>(&mut arg1.zzf222_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

