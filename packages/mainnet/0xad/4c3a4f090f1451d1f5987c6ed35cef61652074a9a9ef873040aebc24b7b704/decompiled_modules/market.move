module 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::market {
    struct Market has store, key {
        id: 0x2::object::UID,
    }

    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        rewards: vector<Reward<T0>>,
        deposits: vector<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>,
    }

    struct Reward<phantom T0> has store {
        reward_amount: u64,
        rewards: 0x2::balance::Balance<T0>,
    }

    struct Deposit has store {
        total_amount: u64,
        remaining_amount: u64,
        claimed: bool,
    }

    struct FlashLoanReceipt<phantom T0> {
        borrowed_amount: u64,
    }

    public(friend) fun add_reserve<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, v0).balance, arg1);
        } else {
            let v1 = Reserve<T0>{
                id       : 0x2::object::new(arg2),
                balance  : arg1,
                rewards  : 0x1::vector::empty<Reward<T0>>(),
                deposits : 0x1::vector::empty<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, v0, v1);
        };
    }

    public(friend) fun add_reward<T0>(arg0: &mut Market, arg1: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::config::Config, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        if ((0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::config::current_season(arg1) as u64) < (0x1::vector::length<Reward<T0>>(&v0.rewards) as u64)) {
            err_rewards_already_added();
        };
        let v1 = Reward<T0>{
            reward_amount : 0x2::balance::value<T0>(&arg2),
            rewards       : arg2,
        };
        0x1::vector::push_back<Reward<T0>>(&mut v0.rewards, v1);
        0x1::vector::push_back<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&mut v0.deposits, 0x2::vec_map::empty<0x2::object::ID, Deposit>());
        if (0x1::vector::length<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&v0.deposits) != 0x1::vector::length<Reward<T0>>(&v0.rewards)) {
            err_rewards_and_deposits_length_mismatch();
        };
        if (0x1::vector::length<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&v0.deposits) != (0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::config::current_season(arg1) as u64) + 1) {
            err_deposits_length_and_season_mismatch();
        };
    }

    public fun claim<T0>(arg0: &mut Market, arg1: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::NewAction, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2 >= 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_season(arg1)) {
            err_season_not_allow_to_claim();
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&mut v0.deposits, (arg2 as u64));
        let v2 = total_deposited_amount(v1);
        if (v2 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v3 = 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_ticket_id(arg1);
        if (0x2::vec_map::contains<0x2::object::ID, Deposit>(v1, &v3)) {
            let v5 = 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_ticket_id(arg1);
            let v6 = 0x2::vec_map::get_mut<0x2::object::ID, Deposit>(v1, &v5);
            if (v6.claimed) {
                return 0x2::coin::zero<T0>(arg3)
            };
            let v7 = (((0x1::vector::borrow<Reward<T0>>(&v0.rewards, (arg2 as u64)).reward_amount as u256) * (v6.total_amount as u256) / (v2 as u256)) as u64);
            let v8 = &mut 0x1::vector::borrow_mut<Reward<T0>>(&mut v0.rewards, (arg2 as u64)).rewards;
            if (v7 > 0x2::balance::value<T0>(v8)) {
                err_reward_balance_not_enough();
            };
            v6.claimed = true;
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v8, v7), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    public fun deposit<T0>(arg0: &mut Market, arg1: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::NewAction, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_ticket_id(arg1);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(arg2));
        let v3 = 0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&mut v2.deposits, (0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_season(arg1) as u64));
        if (0x2::vec_map::contains<0x2::object::ID, Deposit>(v3, &v1)) {
            let v4 = 0x2::vec_map::get_mut<0x2::object::ID, Deposit>(v3, &v1);
            v4.total_amount = v4.total_amount + v0;
            v4.remaining_amount = v4.remaining_amount + v0;
        } else {
            let v5 = Deposit{
                total_amount     : v0,
                remaining_amount : v0,
                claimed          : false,
            };
            0x2::vec_map::insert<0x2::object::ID, Deposit>(v3, v1, v5);
        };
    }

    fun err_amount_greater_than_remaining_amount() {
        abort 3
    }

    fun err_amount_greater_than_reserve_balance() {
        abort 6
    }

    fun err_deposits_length_and_season_mismatch() {
        abort 2
    }

    fun err_repay_value_not_enough() {
        abort 7
    }

    fun err_reward_balance_not_enough() {
        abort 9
    }

    fun err_rewards_already_added() {
        abort 0
    }

    fun err_rewards_and_deposits_length_mismatch() {
        abort 1
    }

    fun err_season_not_allow_to_claim() {
        abort 5
    }

    fun err_season_not_started() {
        abort 4
    }

    public fun flash_loan<T0>(arg0: &mut Market, arg1: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::NewAction, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        if (arg2 > 0x2::balance::value<T0>(&v0.balance)) {
            err_amount_greater_than_reserve_balance();
        };
        let v1 = FlashLoanReceipt<T0>{borrowed_amount: arg2 * (10000 + 10) / 10000};
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg2), arg3), v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Market>(v0);
    }

    public fun repay_amount<T0>(arg0: &FlashLoanReceipt<T0>) : u64 {
        arg0.borrowed_amount
    }

    public fun repay_flash_loan<T0>(arg0: &mut Market, arg1: FlashLoanReceipt<T0>, arg2: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::NewAction, arg3: 0x2::coin::Coin<T0>) {
        let FlashLoanReceipt { borrowed_amount: v0 } = arg1;
        if (0x2::coin::value<T0>(&arg3) != v0) {
            err_repay_value_not_enough();
        };
        0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()).balance, 0x2::coin::into_balance<T0>(arg3));
    }

    fun total_deposited_amount(arg0: &0x2::vec_map::VecMap<0x2::object::ID, Deposit>) : u64 {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, Deposit>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            v1 = v1 + 0x2::vec_map::get<0x2::object::ID, Deposit>(arg0, 0x1::vector::borrow<0x2::object::ID>(&v0, v2)).total_amount;
            v2 = v2 + 1;
        };
        v1
    }

    public fun withdraw<T0>(arg0: &mut Market, arg1: &0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::NewAction, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_season(arg1);
        if (v0 < arg3) {
            err_season_not_started();
        };
        let v1 = 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::game_ticket::new_action_ticket_id(arg1);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Reserve<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, Deposit>>(&mut v2.deposits, (arg3 as u64));
        if (0x2::vec_map::contains<0x2::object::ID, Deposit>(v3, &v1)) {
            let v5 = 0x2::vec_map::get_mut<0x2::object::ID, Deposit>(v3, &v1);
            if (arg2 > v5.remaining_amount) {
                err_amount_greater_than_remaining_amount();
            };
            if (v0 == arg3) {
                v5.total_amount = v5.total_amount - arg2;
            };
            v5.remaining_amount = v5.remaining_amount - arg2;
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, arg2), arg4)
        } else {
            0x2::coin::zero<T0>(arg4)
        }
    }

    // decompiled from Move bytecode v6
}

