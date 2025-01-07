module 0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::presale {
    struct UserState has key {
        id: 0x2::object::UID,
        isClaimed: 0x2::vec_map::VecMap<address, bool>,
        contributed: 0x2::vec_map::VecMap<address, u64>,
        claimableToken: 0x2::vec_map::VecMap<address, u64>,
    }

    struct PresalePool has key {
        id: 0x2::object::UID,
        total_supply: u64,
        allocated: u64,
        min_contribution: u64,
        max_contribution: u64,
        start_time: u64,
        end_time: u64,
        price_per_token: u64,
        final_presale: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>,
        stakedCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim(arg0: &mut UserState, arg1: &mut Treasury, arg2: &mut PresalePool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) > arg2.end_time, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!*0x2::vec_map::get_mut<address, bool>(&mut arg0.isClaimed, &v0), 8);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.claimableToken, &v0), 5);
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.claimableToken, &v0);
        let v2 = *v1 * arg2.price_per_token;
        *v1 = 0;
        *0x2::vec_map::get_mut<address, bool>(&mut arg0.isClaimed, &v0) = true;
        arg2.allocated = arg2.allocated + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>>(0x2::coin::take<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>(&mut arg1.rewardsTreasury, v2, arg4), v0);
    }

    public entry fun contribute(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut UserState, arg2: &mut Treasury, arg3: &mut PresalePool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 > arg3.min_contribution, 2);
        assert!(v0 < arg3.max_contribution, 3);
        assert!(0x2::clock::timestamp_ms(arg4) > arg3.start_time, 0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.contributed, &v1)) {
            0x2::vec_map::insert<address, bool>(&mut arg1.isClaimed, v1, false);
            0x2::vec_map::insert<address, u64>(&mut arg1.claimableToken, v1, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.contributed, v1, 0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.stakedCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.claimableToken, &v1);
        assert!(arg3.allocated <= arg3.total_supply, 7);
        *v2 = *v2 + v0 * arg3.price_per_token;
        let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.contributed, &v1);
        *v3 = *v3 + v0;
    }

    public fun getPresaleState(arg0: &PresalePool) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.total_supply, arg0.allocated, arg0.min_contribution, arg0.max_contribution, arg0.start_time, arg0.end_time, arg0.price_per_token)
    }

    public fun getTreasury(arg0: &Treasury) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.stakedCoinsTreasury), 0x2::balance::value<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>(&arg0.rewardsTreasury))
    }

    public fun getUserStatus(arg0: &mut UserState, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, bool) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_map::contains<address, u64>(&arg0.contributed, &v0)) {
            (0, 0, false)
        } else {
            (*0x2::vec_map::get_mut<address, u64>(&mut arg0.contributed, &v0), *0x2::vec_map::get_mut<address, u64>(&mut arg0.claimableToken, &v0), *0x2::vec_map::get_mut<address, bool>(&mut arg0.isClaimed, &v0))
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresalePool{
            id               : 0x2::object::new(arg0),
            total_supply     : 100000,
            allocated        : 0,
            min_contribution : 0,
            max_contribution : 1,
            start_time       : 0,
            end_time         : 1,
            price_per_token  : 1,
            final_presale    : false,
        };
        0x2::transfer::share_object<PresalePool>(v0);
        let v1 = UserState{
            id             : 0x2::object::new(arg0),
            isClaimed      : 0x2::vec_map::empty<address, bool>(),
            contributed    : 0x2::vec_map::empty<address, u64>(),
            claimableToken : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<UserState>(v1);
        let v2 = Treasury{
            id                  : 0x2::object::new(arg0),
            rewardsTreasury     : 0x2::balance::zero<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>(),
            stakedCoinsTreasury : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun setFinalPresale(arg0: &AdminCap, arg1: &mut PresalePool, arg2: bool) {
        arg1.final_presale = arg2;
    }

    public entry fun setPresaleInfo(arg0: &AdminCap, arg1: &mut PresalePool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg1.total_supply = arg2;
        arg1.min_contribution = arg3;
        arg1.max_contribution = arg4;
        arg1.start_time = arg5;
        arg1.end_time = arg6;
        arg1.price_per_token = arg7;
    }

    public entry fun setRewardAmount(arg0: &AdminCap, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>) {
        0x2::balance::join<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>(&mut arg1.rewardsTreasury, 0x2::coin::into_balance<0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token::TOKEN>(arg2));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.stakedCoinsTreasury);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.stakedCoinsTreasury, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

