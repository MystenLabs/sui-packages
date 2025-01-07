module 0x169b70fefdcc69c792e3f9b0cf52771e2c0cdb331863c6f017f547aaf23848b6::swap {
    struct VestingInfo has store, key {
        id: 0x2::object::UID,
        total: u64,
        released: u64,
        start_time: u64,
        cliff_time: u64,
        end_time: u64,
        beneficiary: address,
    }

    struct CasuinoStorage has key {
        id: 0x2::object::UID,
        csc_balance: 0x2::balance::Balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CasuinoCap has key {
        id: 0x2::object::UID,
    }

    public entry fun convert_to_csc(arg0: &mut CasuinoStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) > 0x2::coin::value<0x2::sui::SUI>(&arg1), 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) * 1000 / 68;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.csc_balance) > v0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg0.csc_balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun convert_to_sui(arg0: &mut CasuinoStorage, arg1: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1) > 0, 6);
        assert!(0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg0.csc_balance) > 0x2::coin::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1), 7);
        let v0 = 0x2::coin::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1) * 68 / 1000;
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg0.csc_balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg1));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) > v0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit_csc(arg0: &CasuinoCap, arg1: &mut CasuinoStorage, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>) {
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.csc_balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg2));
    }

    public entry fun deposit_sui(arg0: &CasuinoCap, arg1: &mut CasuinoStorage, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CasuinoCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CasuinoCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CasuinoStorage{
            id          : 0x2::object::new(arg0),
            csc_balance : 0x2::balance::zero<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(),
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CasuinoStorage>(v1);
    }

    public entry fun init_vesting_store(arg0: &CasuinoCap, arg1: &mut CasuinoStorage, arg2: 0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.csc_balance, 0x2::coin::into_balance<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
    }

    public entry fun withdraw_csc(arg0: &CasuinoCap, arg1: &mut CasuinoStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&arg1.csc_balance) > arg2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>>(0x2::coin::take<0x8cfcd7e02e562c4302cfc1f9ad9e425358fe23b42f948dd430e855227494642a::csc::CSC>(&mut arg1.csc_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_sui(arg0: &CasuinoCap, arg1: &mut CasuinoStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) > arg2, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

