module 0xfb8f9a76e6f4a1aafd58d26c89106c0c3abdc082bb07d7fae1bcc28ae2a2743e::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.val, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::balance::value<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&arg0.val);
        if (v2 < v0) {
            abort 0
        };
        if (v2 < v0 * 10) {
            abort 1
        };
        let v3 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>>(0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>>(arg2, v1);
        } else {
            0x2::balance::join<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg0.val, 0x2::coin::into_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(arg2));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>>(0x2::coin::from_balance<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(0x2::balance::split<0x6051a8551294f499805069646968f923104f3f953f1652f86c5c5da3090d58b::oliverxl_faucet::OLIVERXL_FAUCET>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

