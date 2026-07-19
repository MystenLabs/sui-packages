module 0x4471429f256e9da16a0c00d617f5f8dfb231bde0c3cdac2c766bbe7363436ebd::balance_manager {
    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct CapitalVault has key {
        id: 0x2::object::UID,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        paused: bool,
        balances: 0x2::bag::Bag,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        pool_positions: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>,
        active_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        approved_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct Funded has copy, drop {
        typename: 0x1::type_name::TypeName,
        amount: u64,
        funder: address,
    }

    struct Withdrawn has copy, drop {
        typename: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct ProfitPaid has copy, drop {
        typename: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct KeeperCapRotated has copy, drop {
        vault_id: 0x2::object::ID,
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct PauseSet has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct Migrated has copy, drop {
        vault_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct PoolApproved has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct PoolRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun admin_withdraw<T0>(arg0: &mut CapitalVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = raw_withdraw<T0>(arg0, arg2);
        let v1 = arg0.profit_recipient;
        let v2 = Withdrawn{
            typename  : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
            recipient : v1,
        };
        0x2::event::emit<Withdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), v1);
    }

    public fun all_pools(arg0: &CapitalVault) : vector<0x2::object::ID> {
        *0x2::vec_set::keys<0x2::object::ID>(&arg0.active_pools)
    }

    public fun approve_pool(arg0: &mut CapitalVault, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.approved_pools, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.approved_pools, arg2);
            let v0 = PoolApproved{
                vault_id : 0x2::object::id<CapitalVault>(arg0),
                pool_id  : arg2,
            };
            0x2::event::emit<PoolApproved>(v0);
        };
    }

    fun assert_admin(arg0: &CapitalVault, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 6);
        assert!(arg1.vault_id == 0x2::object::id<CapitalVault>(arg0), 6);
    }

    fun assert_keeper(arg0: &CapitalVault, arg1: &KeeperCap) {
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<CapitalVault>(arg0), 0);
    }

    fun assert_operational(arg0: &CapitalVault) {
        assert!(arg0.version == 1, 7);
        assert!(!arg0.paused, 8);
    }

    public(friend) fun assert_pool_approved(arg0: &CapitalVault, arg1: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.approved_pools, &arg1), 9);
    }

    fun assert_version(arg0: &CapitalVault) {
        assert!(arg0.version == 1, 7);
    }

    public fun balance_value<T0>(arg0: &CapitalVault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public(friend) fun borrow_position_mut(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert_keeper(arg0, arg1);
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 3);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg2) && 0x2::vec_set::contains<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg2), &arg3), 5);
        0x2::object_table::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3)
    }

    public fun contains_position(arg0: &CapitalVault, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg1)
    }

    public fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = KeeperCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v4 = 0x2::object::id<AdminCap>(&v2);
        let v5 = 0x2::object::id<KeeperCap>(&v3);
        let v6 = 0x2::tx_context::sender(arg1);
        let v7 = CapitalVault{
            id               : v0,
            version          : 1,
            admin_cap_id     : v4,
            keeper_cap_id    : v5,
            profit_recipient : arg0,
            paused           : false,
            balances         : 0x2::bag::new(arg1),
            positions        : 0x2::object_table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1),
            pool_positions   : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
            active_pools     : 0x2::vec_set::empty<0x2::object::ID>(),
            approved_pools   : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v8 = VaultCreated{
            vault_id         : v1,
            admin_cap_id     : v4,
            keeper_cap_id    : v5,
            owner            : v6,
            profit_recipient : arg0,
        };
        0x2::event::emit<VaultCreated>(v8);
        0x2::transfer::public_transfer<AdminCap>(v2, v6);
        0x2::transfer::public_transfer<KeeperCap>(v3, v6);
        0x2::transfer::share_object<CapitalVault>(v7);
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut CapitalVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun deposit_coin<T0>(arg0: &mut CapitalVault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Funded{
            typename : 0x1::type_name::with_defining_ids<T0>(),
            amount   : 0x2::coin::value<T0>(&arg1),
            funder   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Funded>(v0);
    }

    public fun is_paused(arg0: &CapitalVault) : bool {
        arg0.paused
    }

    public fun is_pool_approved(arg0: &CapitalVault, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.approved_pools, &arg1)
    }

    public fun migrate(arg0: &mut CapitalVault, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        assert!(arg0.version < 1, 7);
        arg0.version = 1;
        let v0 = Migrated{
            vault_id : 0x2::object::id<CapitalVault>(arg0),
            from     : arg0.version,
            to       : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun pay_profit_balance<T0>(arg0: &CapitalVault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = arg0.profit_recipient;
        let v2 = ProfitPaid{
            typename  : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<ProfitPaid>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), v1);
    }

    public fun pool_has_positions(arg0: &CapitalVault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1) && !0x2::vec_set::is_empty<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1))
    }

    public fun position_count(arg0: &CapitalVault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1)) {
            0x2::vec_set::length<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1))
        } else {
            0
        }
    }

    public fun positions_in_pool(arg0: &CapitalVault, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1)) {
            0x2::vec_set::into_keys<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg1))
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun profit_recipient(arg0: &CapitalVault) : address {
        arg0.profit_recipient
    }

    fun raw_withdraw<T0>(arg0: &mut CapitalVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        0x2::balance::split<T0>(v1, arg1)
    }

    public fun revoke_pool(arg0: &mut CapitalVault, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.approved_pools, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.approved_pools, &arg2);
            let v0 = PoolRevoked{
                vault_id : 0x2::object::id<CapitalVault>(arg0),
                pool_id  : arg2,
            };
            0x2::event::emit<PoolRevoked>(v0);
        };
    }

    public fun rotate_keeper_cap(arg0: &mut CapitalVault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = KeeperCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<CapitalVault>(arg0),
        };
        let v1 = 0x2::object::id<KeeperCap>(&v0);
        arg0.keeper_cap_id = v1;
        let v2 = KeeperCapRotated{
            vault_id   : 0x2::object::id<CapitalVault>(arg0),
            old_cap_id : arg0.keeper_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<KeeperCapRotated>(v2);
        0x2::transfer::public_transfer<KeeperCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun set_paused(arg0: &mut CapitalVault, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PauseSet{
            vault_id : 0x2::object::id<CapitalVault>(arg0),
            paused   : arg2,
        };
        0x2::event::emit<PauseSet>(v0);
    }

    public(friend) fun store_position(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: 0x2::object::ID, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : 0x2::object::ID {
        assert_keeper(arg0, arg1);
        assert_operational(arg0);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, v0), 4);
        0x2::object_table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, v0, arg3);
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.pool_positions, arg2), v0);
        } else {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.pool_positions, arg2, 0x2::vec_set::singleton<0x2::object::ID>(v0));
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_pools, arg2);
        };
        v0
    }

    public(friend) fun take_position(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert_keeper(arg0, arg1);
        assert_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3), 3);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.pool_positions, arg2), 5);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.pool_positions, arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v0, &arg3), 5);
        0x2::vec_set::remove<0x2::object::ID>(v0, &arg3);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v0)) {
            0x2::table::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.pool_positions, arg2);
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_pools, &arg2);
        };
        0x2::object_table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3)
    }

    public fun version(arg0: &CapitalVault) : u64 {
        arg0.version
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_keeper(arg0, arg1);
        assert_operational(arg0);
        if (arg2 == 0) {
            return 0x2::balance::zero<T0>()
        };
        raw_withdraw<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

