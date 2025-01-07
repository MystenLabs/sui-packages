module 0xe883f5887c5c9ab953c169ce25712c876dc8f9487e9b04b9a8f5dbe5fba07504::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun Deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(0x2::coin::balance_mut<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg1), arg2));
    }

    public entry fun Play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg3) >= arg4, 1000);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(arg3, 0x2::coin::take<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg0.balance, arg4, arg5));
        } else {
            Deposit(arg0, arg3, arg4);
        };
    }

    public entry fun Withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>>(0x2::coin::take<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x9071812b707beb845e3e6a2e0f84b5de10ac7503c2bab4f0554178b6b0243397::dcm_faucet_coin::DCM_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

