module 0xf1b6b704d6fd679736d3704a7278d4ad5c0dfff348f85a547c9c7f37b4d9d6f5::oliverxl_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        oliverxl_coin: 0x2::balance::Balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>,
        oliverxl_faucet: 0x2::balance::Balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_oliverxl_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&mut arg0.oliverxl_coin, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(arg1));
    }

    public entry fun add_oliverxl_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.oliverxl_faucet, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id              : 0x2::object::new(arg0),
            oliverxl_coin   : 0x2::balance::zero<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(),
            oliverxl_faucet : 0x2::balance::zero<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_oliverxl_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>>(0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&mut arg1.oliverxl_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun remove_oliverxl_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>>(0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg1.oliverxl_faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_to_oliverxl_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_to_oliverxl_coin_(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_to_oliverxl_coin_(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN> {
        let v0 = 0x2::coin::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&arg1) * 1 / 8;
        assert!(v0 < 0x2::balance::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&arg0.oliverxl_coin), 0);
        0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.oliverxl_faucet, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(arg1));
        0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&mut arg0.oliverxl_coin, v0), arg2)
    }

    public entry fun swap_to_oliverxl_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_to_oliverxl_faucet_(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun swap_to_oliverxl_faucet_(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET> {
        let v0 = 0x2::coin::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&arg1) * 8;
        assert!(v0 < 0x2::balance::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&arg0.oliverxl_faucet), 1);
        0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(&mut arg0.oliverxl_coin, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_coin::OLIVERXL_COIN>(arg1));
        0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.oliverxl_faucet, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

