module 0x5b340df606f1c48f60d32e8a26dcfde443d619f3d8e0980f7bbf553cc24e1b83::commission {
    struct COMMISSION has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    struct BalanceKey has copy, drop, store {
        coin: 0x1::ascii::String,
    }

    struct RewardManagerKey has copy, drop, store {
        nft_type: 0x1::ascii::String,
    }

    struct RewardManager has store, key {
        id: 0x2::object::UID,
        status: u64,
        rate: u64,
        supply: u64,
        registry: 0x2::linked_table::LinkedTable<0x2::object::ID, u64>,
        rewards: 0x2::linked_table::LinkedTable<0x1::ascii::String, u64>,
    }

    struct RewardKey has copy, drop, store {
        nft_type: 0x1::ascii::String,
        coin: 0x1::ascii::String,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        paid: 0x2::linked_table::LinkedTable<0x2::object::ID, u64>,
    }

    struct CommissionEvent has copy, drop {
        reason: 0x1::ascii::String,
        coin: 0x1::ascii::String,
        amount: u64,
    }

    struct RewardEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        coin: 0x1::ascii::String,
        added: u64,
        total_added: u64,
    }

    struct WithdrawRewardEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        paid: u64,
        total_paid: u64,
    }

    entry fun pay<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<0x1::ascii::String>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        if (0x1::option::is_some<0x1::ascii::String>(&arg3)) {
            let v1 = *0x1::option::borrow<0x1::ascii::String>(&arg3);
            if (has_reward_manager(arg0, v1)) {
                let v2 = get_reward_manager(arg0, v1);
                let v3 = (((0x2::balance::value<T0>(&v0) as u128) * (v2.rate as u128) / 10000) as u64);
                let v4 = get_reward<T0>(v2, v1, arg4);
                0x2::balance::join<T0>(&mut v4.balance, 0x2::balance::split<T0>(&mut v0, v3));
                let v5 = 0x1::type_name::with_defining_ids<T0>();
                let v6 = *0x1::type_name::as_string(&v5);
                let v7 = &mut v2.rewards;
                let v8 = RewardEvent{
                    nft_type    : v1,
                    coin        : v6,
                    added       : v3,
                    total_added : increment<0x1::ascii::String>(v7, v6, v3),
                };
                0x2::event::emit<RewardEvent>(v8);
            };
        };
        let v9 = 0x1::type_name::with_defining_ids<T0>();
        let v10 = CommissionEvent{
            reason : arg1,
            coin   : *0x1::type_name::as_string(&v9),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CommissionEvent>(v10);
        0x2::balance::join<T0>(get_manager_balance<T0>(arg0), v0);
    }

    entry fun add_reward_manager(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg4);
        verify_version(arg0);
        assert!(!has_reward_manager(arg0, arg1), 3);
        let v0 = RewardManagerKey{nft_type: arg1};
        let v1 = RewardManager{
            id       : 0x2::object::new(arg4),
            status   : 0,
            rate     : arg2,
            supply   : arg3,
            registry : 0x2::linked_table::new<0x2::object::ID, u64>(arg4),
            rewards  : 0x2::linked_table::new<0x1::ascii::String, u64>(arg4),
        };
        0x2::dynamic_object_field::add<RewardManagerKey, RewardManager>(&mut arg0.id, v0, v1);
    }

    entry fun delete_reward_manager(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        verify_version(arg0);
        assert!(has_reward_manager(arg0, arg1), 4);
        let v0 = RewardManagerKey{nft_type: arg1};
        let RewardManager {
            id       : v1,
            status   : v2,
            rate     : _,
            supply   : _,
            registry : v5,
            rewards  : v6,
        } = 0x2::dynamic_object_field::remove<RewardManagerKey, RewardManager>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        assert!(v2 == 0, 6);
        0x2::linked_table::drop<0x2::object::ID, u64>(v5);
        0x2::linked_table::drop<0x1::ascii::String, u64>(v6);
    }

    fun get_manager_balance<T0>(arg0: &mut Manager) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = BalanceKey{coin: *0x1::type_name::as_string(&v0)};
        if (!0x2::dynamic_field::exists_<BalanceKey>(&arg0.id, v1)) {
            0x2::dynamic_field::add<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1)
    }

    fun get_or_zero<T0: copy + drop + store>(arg0: &mut 0x2::linked_table::LinkedTable<T0, u64>, arg1: T0) : u64 {
        if (!0x2::linked_table::contains<T0, u64>(arg0, arg1)) {
            0x2::linked_table::push_back<T0, u64>(arg0, arg1, 0);
        };
        *0x2::linked_table::borrow<T0, u64>(arg0, arg1)
    }

    fun get_reward<T0>(arg0: &mut RewardManager, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : &mut Reward<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = RewardKey{
            nft_type : arg1,
            coin     : *0x1::type_name::as_string(&v0),
        };
        if (!0x2::dynamic_object_field::exists_with_type<RewardKey, Reward<T0>>(&arg0.id, v1)) {
            let v2 = Reward<T0>{
                id      : 0x2::object::new(arg2),
                balance : 0x2::balance::zero<T0>(),
                paid    : 0x2::linked_table::new<0x2::object::ID, u64>(arg2),
            };
            0x2::dynamic_object_field::add<RewardKey, Reward<T0>>(&mut arg0.id, v1, v2);
        };
        0x2::dynamic_object_field::borrow_mut<RewardKey, Reward<T0>>(&mut arg0.id, v1)
    }

    fun get_reward_manager(arg0: &mut Manager, arg1: 0x1::ascii::String) : &mut RewardManager {
        assert!(has_reward_manager(arg0, arg1), 4);
        let v0 = RewardManagerKey{nft_type: arg1};
        0x2::dynamic_object_field::borrow_mut<RewardManagerKey, RewardManager>(&mut arg0.id, v0)
    }

    fun has_reward_manager(arg0: &Manager, arg1: 0x1::ascii::String) : bool {
        let v0 = RewardManagerKey{nft_type: arg1};
        0x2::dynamic_object_field::exists_with_type<RewardManagerKey, RewardManager>(&arg0.id, v0)
    }

    fun increment<T0: copy + drop + store>(arg0: &mut 0x2::linked_table::LinkedTable<T0, u64>, arg1: T0, arg2: u64) : u64 {
        if (0x2::linked_table::contains<T0, u64>(arg0, arg1)) {
            let v1 = 0x2::linked_table::borrow_mut<T0, u64>(arg0, arg1);
            let v2 = *v1 + arg2;
            *v1 = v2;
            v2
        } else {
            0x2::linked_table::push_back<T0, u64>(arg0, arg1, arg2);
            arg2
        }
    }

    fun init(arg0: COMMISSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COMMISSION>(arg0, arg1);
        let v0 = Manager{
            id      : 0x2::object::new(arg1),
            version : 0,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    entry fun load_reward_manager(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg4);
        verify_version(arg0);
        assert!(has_reward_manager(arg0, arg1), 4);
        let v0 = get_reward_manager(arg0, arg1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            0x2::linked_table::push_back<0x2::object::ID, u64>(&mut v0.registry, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
        };
        v0.status = 1;
    }

    entry fun pay_reward<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = withdraw_reward<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::pay::keep<T0>(v0, arg5);
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        verify_version(arg0);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    entry fun update_reward_manager(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg3);
        verify_version(arg0);
        assert!(has_reward_manager(arg0, arg1), 4);
        get_reward_manager(arg0, arg1).rate = arg2;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 0, 2);
    }

    entry fun withdraw<T0>(arg0: &mut Manager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg3);
        verify_version(arg0);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<T0>(get_manager_balance<T0>(arg0))
        } else {
            0x2::balance::split<T0>(get_manager_balance<T0>(arg0), arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg2);
        };
    }

    public fun withdraw_reward<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        assert!(has_reward_manager(arg0, arg1), 4);
        let v0 = get_reward_manager(arg0, arg1);
        assert!(v0.status == 1, 6);
        assert!(0x2::kiosk::has_access(arg3, arg4), 1);
        assert!(0x2::kiosk::has_item(arg3, arg2), 7);
        assert!(0x2::linked_table::contains<0x2::object::ID, u64>(&v0.registry, arg2), 8);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = *0x1::type_name::as_string(&v1);
        let v3 = (((*0x2::linked_table::borrow<0x1::ascii::String, u64>(&v0.rewards, v2) as u128) * (*0x2::linked_table::borrow<0x2::object::ID, u64>(&v0.registry, arg2) as u128) / (v0.supply as u128)) as u64);
        let v4 = get_reward<T0>(v0, arg1, arg5);
        let v5 = &mut v4.paid;
        let v6 = v3 - get_or_zero<0x2::object::ID>(v5, arg2);
        let v7 = &mut v4.paid;
        let v8 = WithdrawRewardEvent{
            nft_type   : arg1,
            nft_id     : arg2,
            coin       : v2,
            paid       : v6,
            total_paid : increment<0x2::object::ID>(v7, arg2, v6),
        };
        0x2::event::emit<WithdrawRewardEvent>(v8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.balance, v6), arg5)
    }

    // decompiled from Move bytecode v6
}

