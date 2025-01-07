module 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::staking {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Position has store {
        amount: u64,
        latest_settled_epoch: u64,
        sui_pending: 0x2::balance::Balance<0x2::sui::SUI>,
        flx_pending: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
    }

    struct UnstakeRecipient has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>,
        unlocked_at_epoch: u64,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        num_locked_epochs: u64,
        positions: 0x2::table::Table<address, Position>,
        total_checkpoints: 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::Trace64,
        sui_allocations: vector<u64>,
        flx_allocations: vector<u64>,
        total_staked: 0x2::balance::Balance<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>,
        sui_available: 0x2::balance::Balance<0x2::sui::SUI>,
        flx_available: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
        operators: 0x2::table::Table<address, bool>,
    }

    struct Staked has copy, drop {
        epoch: u64,
        amount: u64,
        sui_earned: u64,
        flx_earned: u64,
        sender: address,
    }

    struct Unstaked has copy, drop {
        epoch: u64,
        amount: u64,
        sui_earned: u64,
        flx_earned: u64,
        sender: address,
    }

    struct Claimed has copy, drop {
        epoch: u64,
        sui: u64,
        flx: u64,
        sender: address,
    }

    struct Allocated has copy, drop {
        epoch: u64,
        sui: u64,
        flx: u64,
        sender: address,
    }

    struct Released has copy, drop {
        amount: u64,
        sender: address,
    }

    fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id                : 0x2::object::new(arg1),
            num_locked_epochs : arg0,
            positions         : 0x2::table::new<address, Position>(arg1),
            total_checkpoints : 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::create(),
            sui_allocations   : 0x1::vector::singleton<u64>(0),
            flx_allocations   : 0x1::vector::singleton<u64>(0),
            total_staked      : 0x2::balance::zero<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(),
            sui_available     : 0x2::balance::zero<0x2::sui::SUI>(),
            flx_available     : 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
            operators         : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(&mut v0.id, v1, 1);
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun set_duration(arg0: &AdminCap, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: u64) {
        0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::set_duration(arg1, arg2);
    }

    public entry fun allocate(arg0: &mut State, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 1 || arg4 == 0, 5);
        assert!(0x2::table::contains<address, bool>(&arg0.operators, 0x2::tx_context::sender(arg6)), 4);
        allocate_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun allocate_internal(arg0: &mut State, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::coin::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg3);
        if (arg4 == 1) {
            0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::check_epoch(arg1, arg5);
            0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::next(arg1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_available, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.flx_available, 0x2::coin::into_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(arg3));
        if (0x1::vector::length<u64>(&arg0.sui_allocations) <= 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1)) {
            0x1::vector::push_back<u64>(&mut arg0.sui_allocations, 0);
            0x1::vector::push_back<u64>(&mut arg0.flx_allocations, 0);
        };
        let v2 = 0x1::vector::borrow_mut<u64>(&mut arg0.sui_allocations, 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1));
        *v2 = *v2 + v0;
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.flx_allocations, 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1));
        *v3 = *v3 + v1;
        let v4 = Allocated{
            epoch  : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1),
            sui    : v0,
            flx    : v1,
            sender : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<Allocated>(v4);
    }

    public fun allocations_at(arg0: &State, arg1: u64) : (u64, u64) {
        (*0x1::vector::borrow<u64>(&arg0.sui_allocations, arg1), *0x1::vector::borrow<u64>(&arg0.flx_allocations, arg1))
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg0.id, v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(&arg0.id);
    }

    public entry fun claim(arg0: &mut State, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 1);
        let (_, _) = harvest(arg0, arg1, v0);
        let v3 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3.sui_pending);
        let v5 = 0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v3.flx_pending);
        assert!(v4 > 0 || v5 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v3.sui_pending), arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::withdraw_all<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v3.flx_pending), arg2), v0);
        let v6 = Claimed{
            epoch  : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1),
            sui    : v4,
            flx    : v5,
            sender : v0,
        };
        0x2::event::emit<Claimed>(v6);
    }

    public fun flx_available(arg0: &State) : u64 {
        0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.flx_available)
    }

    public entry fun grant_operator(arg0: &AdminCap, arg1: &mut State, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.operators, arg2, true);
    }

    fun harvest(arg0: &mut State, arg1: &0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: address) : (u64, u64) {
        let v0 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg2);
        if (v0.latest_settled_epoch == 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1)) {
            return (0, 0)
        };
        let v1 = 0;
        let v2 = 0;
        while (v0.latest_settled_epoch < 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1)) {
            let (_, v4) = 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::upper_lockup_recent(&arg0.total_checkpoints, v0.latest_settled_epoch);
            let v5 = *0x1::vector::borrow<u64>(&arg0.sui_allocations, v0.latest_settled_epoch);
            let v6 = *0x1::vector::borrow<u64>(&arg0.flx_allocations, v0.latest_settled_epoch);
            if (v4 > 0 && (v5 > 0 || v6 > 0)) {
                let v7 = (((v5 as u256) * (v0.amount as u256) / (v4 as u256)) as u64);
                let v8 = &mut arg0.sui_available;
                0x2::balance::join<0x2::sui::SUI>(&mut v0.sui_pending, safe_split<0x2::sui::SUI>(v8, v7));
                v2 = v2 + v7;
                let v9 = (((v6 as u256) * (v0.amount as u256) / (v4 as u256)) as u64);
                let v10 = &mut arg0.flx_available;
                0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v0.flx_pending, safe_split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v10, v9));
                v1 = v1 + v9;
            };
            v0.latest_settled_epoch = v0.latest_settled_epoch + 1;
        };
        (v2, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut State) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg1.id, v0);
        assert!(*v1 < 1, 1000);
        *v1 = 1;
    }

    public fun position_info(arg0: &State, arg1: address) : (u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        (v0.amount, v0.latest_settled_epoch, 0x2::balance::value<0x2::sui::SUI>(&v0.sui_pending), 0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v0.flx_pending))
    }

    public fun recipient_value(arg0: &UnstakeRecipient) : u64 {
        0x2::balance::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&arg0.balance)
    }

    public entry fun release(arg0: UnstakeRecipient, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1) >= arg0.unlocked_at_epoch, 2);
        let UnstakeRecipient {
            id                : v0,
            balance           : v1,
            unlocked_at_epoch : _,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>>(0x2::coin::from_balance<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(0x2::balance::withdraw_all<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&mut v3), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::destroy_zero<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(v3);
        let v4 = Released{
            amount : 0x2::balance::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&v3),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Released>(v4);
    }

    public entry fun revoke_operator(arg0: &AdminCap, arg1: &mut State, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.operators, arg2);
    }

    fun safe_split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 < arg1) {
            0x2::balance::split<T0>(arg0, v0)
        } else {
            0x2::balance::split<T0>(arg0, arg1)
        }
    }

    public entry fun set_num_locked_epochs(arg0: &AdminCap, arg1: &mut State, arg2: u64) {
        arg1.num_locked_epochs = arg2;
    }

    public entry fun setup(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        create(arg1, arg5);
        0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::create(arg2, arg3, arg4, arg5);
    }

    public entry fun stake(arg0: &mut State, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: 0x2::coin::Coin<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0x2::coin::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&arg2) > 0, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v1 = Position{
                amount               : 0,
                latest_settled_epoch : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1),
                sui_pending          : 0x2::balance::zero<0x2::sui::SUI>(),
                flx_pending          : 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v0, v1);
        };
        let (v2, v3) = harvest(arg0, arg1, v0);
        let v4 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        let v5 = 0x2::coin::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&arg2);
        0x2::balance::join<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&mut arg0.total_staked, 0x2::coin::into_balance<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(arg2));
        v4.amount = v4.amount + v5;
        let (_, _) = 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::push(&mut arg0.total_checkpoints, 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1), 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::latest(&arg0.total_checkpoints) + v5);
        let v8 = Staked{
            epoch      : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1),
            amount     : v5,
            sui_earned : v2,
            flx_earned : v3,
            sender     : v0,
        };
        0x2::event::emit<Staked>(v8);
    }

    public fun sui_available(arg0: &State) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_available)
    }

    public fun total_staked(arg0: &State) : u64 {
        0x2::balance::value<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&arg0.total_staked)
    }

    public fun total_staked_at(arg0: &State, arg1: u64) : u64 {
        let (_, v1) = 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::upper_lockup_recent(&arg0.total_checkpoints, arg1);
        v1
    }

    public entry fun unstake(arg0: &mut State, arg1: &mut 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::Epoch, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 1);
        assert!(arg2 > 0, 0);
        let (v1, v2) = harvest(arg0, arg1, v0);
        let v3 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        assert!(v3.amount >= arg2, 3);
        let v4 = UnstakeRecipient{
            id                : 0x2::object::new(arg3),
            balance           : 0x2::balance::split<0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::XFLX>(&mut arg0.total_staked, arg2),
            unlocked_at_epoch : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1) + arg0.num_locked_epochs,
        };
        0x2::transfer::transfer<UnstakeRecipient>(v4, v0);
        v3.amount = v3.amount - arg2;
        let (_, _) = 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::push(&mut arg0.total_checkpoints, 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1), 0xe72e764bf13ee1aa37e211b2a10510c72972499c02dba027cef98af0183cf4e0::checkpoint64::latest(&arg0.total_checkpoints) - arg2);
        let v7 = Unstaked{
            epoch      : 0x7d30f6c265b25255d33de0ed09eec5fb8747cf1a2622646fc8f594cce2180523::epoch::epoch(arg1),
            amount     : arg2,
            sui_earned : v1,
            flx_earned : v2,
            sender     : v0,
        };
        0x2::event::emit<Unstaked>(v7);
    }

    // decompiled from Move bytecode v6
}

