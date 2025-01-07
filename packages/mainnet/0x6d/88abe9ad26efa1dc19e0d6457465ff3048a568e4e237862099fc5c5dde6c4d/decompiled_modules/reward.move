module 0x6d88abe9ad26efa1dc19e0d6457465ff3048a568e4e237862099fc5c5dde6c4d::reward {
    struct AdminRole has key {
        id: 0x2::object::UID,
    }

    struct WriterRole has key {
        id: 0x2::object::UID,
        list: 0x2::vec_set::VecSet<address>,
    }

    struct RewardLedger has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_rewards: u64,
        balances: 0x2::table::Table<address, u64>,
    }

    struct REWARD has drop {
        dummy_field: bool,
    }

    entry fun add_reward(arg0: &WriterRole, arg1: &mut RewardLedger, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.list, &v0), 1);
        if (!0x2::table::contains<address, u64>(&arg1.balances, arg2)) {
            0x2::table::add<address, u64>(&mut arg1.balances, arg2, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg1.balances, arg2);
        *v1 = *v1 + arg3;
        arg1.total_rewards = arg1.total_rewards + arg3;
    }

    entry fun add_writer(arg0: &AdminRole, arg1: &mut WriterRole, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.list, arg2);
    }

    entry fun claim_reward(arg0: &mut RewardLedger, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), 2);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
        assert!(arg1 <= *v1, 3);
        *v1 = *v1 - arg1;
        arg0.total_rewards = arg0.total_rewards - arg1;
        if (*v1 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.balances, v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, arg1, arg2), v0);
    }

    entry fun del_writer(arg0: &AdminRole, arg1: &mut WriterRole, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg1.list, &arg2), 1);
        0x2::vec_set::remove<address>(&mut arg1.list, &arg2);
    }

    entry fun deposit(arg0: &mut RewardLedger, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    public fun get_balance(arg0: &RewardLedger, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
    }

    public fun has_balance(arg0: &RewardLedger, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.balances, arg1)
    }

    fun init(arg0: REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminRole{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminRole>(v0, 0x2::tx_context::sender(arg1));
        let v1 = WriterRole{
            id   : 0x2::object::new(arg1),
            list : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::share_object<WriterRole>(v1);
        let v2 = RewardLedger{
            id            : 0x2::object::new(arg1),
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_rewards : 0,
            balances      : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<RewardLedger>(v2);
    }

    public fun total_rewards(arg0: &RewardLedger) : u64 {
        arg0.total_rewards
    }

    entry fun transfer_admin_role(arg0: AdminRole, arg1: address) {
        0x2::transfer::transfer<AdminRole>(arg0, arg1);
    }

    public fun treasury_balance(arg0: &RewardLedger) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    entry fun withdraw_treasury(arg0: &AdminRole, arg1: &mut RewardLedger, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.treasury);
        assert!(v0 > arg1.total_rewards, 2);
        assert!(arg3 <= v0 - arg1.total_rewards, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg3, arg4), arg2);
    }

    entry fun writer_list(arg0: &WriterRole) : 0x2::vec_set::VecSet<address> {
        arg0.list
    }

    // decompiled from Move bytecode v6
}

