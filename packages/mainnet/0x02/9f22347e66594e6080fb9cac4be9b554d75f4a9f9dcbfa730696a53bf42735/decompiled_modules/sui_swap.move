module 0x29f22347e66594e6080fb9cac4be9b554d75f4a9f9dcbfa730696a53bf42735::sui_swap {
    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        my_coin: 0x2::balance::Balance<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>,
        my_faucet_coin: 0x2::balance::Balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>,
    }

    public entry fun WithdrawFAUCET_COIN(arg0: &mut Pool, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.my_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun WithdrawMY_COIN(arg0: &mut Pool, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&arg0.my_coin) >= arg2, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>>(0x2::coin::from_balance<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(0x2::balance::split<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&mut arg0.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit_FAUCET_COIN(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.my_faucet_coin, 0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg1), arg2));
    }

    public entry fun deposit_MY_COIN(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(arg1) >= arg2, 1001);
        0x2::balance::join<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::balance::split<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(0x2::coin::balance_mut<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            my_coin        : 0x2::balance::zero<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(),
            my_faucet_coin : 0x2::balance::zero<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"pwh-pwh"),
        };
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_FAUCET_COIN_to_MY_COIN(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg1) >= arg2 * 2000 / 1000, 1001);
        assert!(arg2 <= 0x2::balance::value<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&arg0.my_coin), 1000);
        0x2::balance::join<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.my_faucet_coin, 0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg1), arg2 * 2000 / 1000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>>(0x2::coin::from_balance<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(0x2::balance::split<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&mut arg0.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_MY_COIN_to_FAUCET_COIN(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(arg1) >= arg2 * 1000 / 2000, 1001);
        assert!(arg2 <= 0x2::balance::value<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&arg0.my_faucet_coin), 1000);
        0x2::balance::join<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::balance::split<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(0x2::coin::balance_mut<0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin::MY_COIN>(arg1), arg2 * 1000 / 2000));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.my_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

