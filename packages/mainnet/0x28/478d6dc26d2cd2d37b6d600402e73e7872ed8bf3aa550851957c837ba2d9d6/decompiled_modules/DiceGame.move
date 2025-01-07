module 0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::DiceGame {
    struct GameRecord has copy, drop {
        user_input: u64,
        real_number: u64,
        win: bool,
        github_id: vector<u8>,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        total_stake: 0x2::balance::Balance<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>,
    }

    public entry fun init_pool(arg0: 0x2::coin::Coin<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id          : 0x2::object::new(arg1),
            total_stake : 0x2::coin::into_balance<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public entry fun play(arg0: u64, arg1: vector<u8>, arg2: &mut RewardPool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3) % 6 + 1;
        let v1 = v0 == arg0;
        let v2 = GameRecord{
            user_input  : arg0,
            real_number : v0,
            win         : v1,
            github_id   : arg1,
        };
        0x2::event::emit<GameRecord>(v2);
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>>(0x2::coin::from_balance<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>(0x2::balance::split<0x28478d6dc26d2cd2d37b6d600402e73e7872ed8bf3aa550851957c837ba2d9d6::FCOIN::FCOIN>(&mut arg2.total_stake, 1), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

