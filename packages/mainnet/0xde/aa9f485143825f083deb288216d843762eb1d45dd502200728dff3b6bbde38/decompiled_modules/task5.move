module 0xdeaa9f485143825f083deb288216d843762eb1d45dd502200728dff3b6bbde38::task5 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>,
        faucet_coin: 0x2::balance::Balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>>(0x2::coin::from_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(0x2::balance::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>>(0x2::coin::from_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(0x2::balance::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(),
            faucet_coin : 0x2::balance::zero<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>, arg3: u64, arg4: &mut 0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&mut arg1.coin, 0x2::coin::into_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(0x2::coin::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(0x2::coin::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(arg4, arg5, arg6)));
        };
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2;
        assert!(0x2::balance::value<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&arg0.faucet_coin) >= v0, 9223372264488042495);
        0x2::balance::join<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&mut arg0.coin, 0x2::coin::into_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(0x2::coin::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>>(0x2::coin::from_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(0x2::balance::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&mut arg0.faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 2;
        assert!(0x2::balance::value<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&arg0.coin) >= v0, 9223372311732682751);
        0x2::balance::join<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(0x2::coin::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::faucet_beson77::FAUCET_BESON77>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>>(0x2::coin::from_balance<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(0x2::balance::split<0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77::BESON77>(&mut arg0.coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

