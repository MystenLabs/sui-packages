module 0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw_presale {
    struct UserState has key {
        id: 0x2::object::UID,
        is_claimed: 0x2::vec_map::VecMap<address, bool>,
        purchased_amount: 0x2::vec_map::VecMap<address, u64>,
    }

    struct PresalePool has key {
        id: 0x2::object::UID,
        total_supply: u64,
        allocated: u64,
        start_time: u64,
        end_time: u64,
        token_per_sui: u64,
        is_claimable: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>,
        purchased: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim(arg0: &mut UserState, arg1: &mut Treasury, arg2: &mut PresalePool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.is_claimable, 6);
        assert!(0x2::clock::timestamp_ms(arg3) > arg2.end_time, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!*0x2::vec_map::get_mut<address, bool>(&mut arg0.is_claimed, &v0), 5);
        let v1 = 0x2::vec_map::get_mut<address, bool>(&mut arg0.is_claimed, &v0);
        assert!(!*v1, 4);
        *v1 = true;
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.purchased_amount, &v0);
        *v2 = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>>(0x2::coin::take<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(&mut arg1.token, *v2 * arg2.token_per_sui, arg4), v0);
    }

    public entry fun get_presale_state(arg0: &PresalePool) : (u64, u64, u64, u64, u64, bool) {
        (arg0.total_supply, arg0.allocated, arg0.start_time, arg0.end_time, arg0.token_per_sui, arg0.is_claimable)
    }

    public entry fun get_treasury(arg0: &Treasury) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.purchased), 0x2::balance::value<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(&arg0.token))
    }

    public entry fun get_user(arg0: &mut UserState, arg1: &mut 0x2::tx_context::TxContext) : (u64, bool) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_map::contains<address, u64>(&arg0.purchased_amount, &v0)) {
            (0, false)
        } else {
            (*0x2::vec_map::get_mut<address, u64>(&mut arg0.purchased_amount, &v0), *0x2::vec_map::get_mut<address, bool>(&mut arg0.is_claimed, &v0))
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PresalePool{
            id            : 0x2::object::new(arg0),
            total_supply  : 600000000000000000,
            allocated     : 0,
            start_time    : 1732798800000,
            end_time      : 1732798800000,
            token_per_sui : 7500,
            is_claimable  : false,
        };
        0x2::transfer::share_object<PresalePool>(v0);
        let v1 = UserState{
            id               : 0x2::object::new(arg0),
            is_claimed       : 0x2::vec_map::empty<address, bool>(),
            purchased_amount : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<UserState>(v1);
        let v2 = Treasury{
            id        : 0x2::object::new(arg0),
            token     : 0x2::balance::zero<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(),
            purchased : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun purchase(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut UserState, arg2: &mut Treasury, arg3: &mut PresalePool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg3.start_time, 0);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3.end_time, 1);
        if (!0x2::vec_map::contains<address, u64>(&arg1.purchased_amount, &v1)) {
            0x2::vec_map::insert<address, bool>(&mut arg1.is_claimed, v1, false);
            0x2::vec_map::insert<address, u64>(&mut arg1.purchased_amount, v1, 0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.purchased, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        arg3.allocated = arg3.allocated + v0 * arg3.token_per_sui;
        assert!(arg3.allocated <= arg3.total_supply, 2);
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.purchased_amount, &v1);
        *v2 = *v2 + v0;
    }

    public entry fun setClaimable(arg0: &AdminCap, arg1: &mut PresalePool) {
        arg1.is_claimable = !arg1.is_claimable;
    }

    public entry fun setPresaleInfo(arg0: &AdminCap, arg1: &mut PresalePool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg1.total_supply = arg2;
        arg1.start_time = arg3;
        arg1.end_time = arg4;
        arg1.token_per_sui = arg5;
    }

    public entry fun setRewardAmount(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::coin::Coin<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>) {
        0x2::balance::join<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(&mut arg1.token, 0x2::balance::split<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(0x2::coin::balance_mut<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(arg3), arg2));
    }

    public entry fun withdrawSui(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::sui::transfer(0x2::coin::take<0x2::sui::SUI>(&mut arg1.purchased, 0x2::balance::value<0x2::sui::SUI>(&arg1.purchased), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdrawToken(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>>(0x2::coin::take<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(&mut arg1.token, 0x2::balance::value<0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw::PAW>(&arg1.token), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

