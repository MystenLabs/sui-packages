module 0xb97f0a8843164802ce3333b4e2ba1c8410bebde6aa711aee148e65a0dd7ecc3a::my_game {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>,
        creator: 0x1::ascii::String,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin(arg0: &mut Game, arg1: 0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            val     : 0x2::balance::zero<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(),
            creator : 0x1::ascii::string(b"pwh-pwh"),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        if (0x2::balance::value<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&arg0.val) < v0) {
            abort 100
        };
        let v2 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>>(arg2, v1);
        } else {
            0x2::balance::join<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(arg2));
        };
    }

    public entry fun remove_coin(arg0: &Admin, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xb0794d0bd006a3f5dfdb60bfc100baa1a0684af59d1ea5aed93325b2b3a611fb::faucet_coin::FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

