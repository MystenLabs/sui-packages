module 0xa665c6416f27a047ff6224b770e916b98c7385ac68fc4f6d79ae6ebd5243e92f::my_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        huahuahua1223_faucet_coin: 0x2::balance::Balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>,
        huahuahua1223_coin: 0x2::balance::Balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>,
    }

    public entry fun deposit_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&mut arg0.huahuahua1223_faucet_coin, v1);
        } else {
            0x2::balance::join<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&mut arg0.huahuahua1223_faucet_coin, 0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun deposit_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&arg1);
        assert!(v0 >= arg2, 1000);
        let v1 = 0x2::coin::into_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(arg1);
        if (v0 == arg2) {
            0x2::balance::join<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&mut arg0.huahuahua1223_coin, v1);
        } else {
            0x2::balance::join<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&mut arg0.huahuahua1223_coin, 0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                        : 0x2::object::new(arg0),
            huahuahua1223_faucet_coin : 0x2::balance::zero<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(),
            huahuahua1223_coin        : 0x2::balance::zero<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_coin_to_my_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 1000 / 2000;
        assert!(0x2::balance::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&arg0.huahuahua1223_coin) >= v0, 1001);
        deposit_faucet_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&mut arg0.huahuahua1223_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_my_coin_to_faucet_coin(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2000 / 1000;
        assert!(0x2::balance::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&arg0.huahuahua1223_faucet_coin) >= v0, 1001);
        deposit_my_coin(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&mut arg0.huahuahua1223_faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&arg1.huahuahua1223_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_coin::HUAHUAHUA1223_COIN>(&mut arg1.huahuahua1223_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_coin(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&arg1.huahuahua1223_faucet_coin) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>>(0x2::coin::from_balance<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(0x2::balance::split<0x4e393fad36baba534f8cbfa9852665c49a69be64cf5b82576f267007e187d036::huahuahua1223_faucet_coin::HUAHUAHUA1223_FAUCET_COIN>(&mut arg1.huahuahua1223_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

