module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::staking {
    struct StakingRegistry has key {
        id: 0x2::object::UID,
        template_stakes: 0x2::table::Table<address, TemplateStakeInfo>,
        total_staked: u64,
        total_positions: u64,
    }

    struct TemplateStakeInfo has store {
        total_staked: u64,
        staker_count: u64,
        stakers: 0x2::table::Table<address, StakerPosition>,
    }

    struct StakerPosition has store {
        balance: 0x2::balance::Balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>,
        last_stake_time_ms: u64,
        unstake_requested_ms: u64,
    }

    struct StakeReceipt has store, key {
        id: 0x2::object::UID,
        template_id: address,
        staker: address,
        amount: u64,
        staked_at_ms: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        template_id: address,
        amount: u64,
        total_on_template: u64,
        timestamp_ms: u64,
    }

    struct UnstakeRequested has copy, drop {
        staker: address,
        template_id: address,
        amount: u64,
        cooldown_ends_ms: u64,
        timestamp_ms: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        template_id: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public entry fun add_stake(arg0: &mut StakingRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::coin::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&arg3);
        assert!(v2 > 0, 106);
        assert!(0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1), 102);
        let v3 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, arg1);
        assert!(0x2::table::contains<address, StakerPosition>(&v3.stakers, v0), 102);
        let v4 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v3.stakers, v0);
        0x2::balance::join<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v4.balance, 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg3));
        v4.last_stake_time_ms = v1;
        v4.unstake_requested_ms = 0;
        v3.total_staked = v3.total_staked + v2;
        arg0.total_staked = arg0.total_staked + v2;
        let v5 = Staked{
            staker            : v0,
            template_id       : arg1,
            amount            : v2,
            total_on_template : v3.total_staked,
            timestamp_ms      : v1,
        };
        0x2::event::emit<Staked>(v5);
    }

    public entry fun add_stake_with_registry(arg0: &mut StakingRegistry, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&arg4);
        assert!(v2 > 0, 106);
        assert!(0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg2), 102);
        let v3 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, arg2);
        assert!(0x2::table::contains<address, StakerPosition>(&v3.stakers, v0), 102);
        let v4 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v3.stakers, v0);
        0x2::balance::join<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v4.balance, 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg4));
        v4.last_stake_time_ms = v1;
        v4.unstake_requested_ms = 0;
        v3.total_staked = v3.total_staked + v2;
        arg0.total_staked = arg0.total_staked + v2;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_stake(arg1, arg2, v3.total_staked);
        let v5 = Staked{
            staker            : v0,
            template_id       : arg2,
            amount            : v2,
            total_on_template : v3.total_staked,
            timestamp_ms      : v1,
        };
        0x2::event::emit<Staked>(v5);
    }

    public entry fun complete_unstake(arg0: &mut StakingRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1), 102);
        let v2 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, arg1);
        assert!(0x2::table::contains<address, StakerPosition>(&v2.stakers, v0), 102);
        let v3 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v2.stakers, v0);
        assert!(v3.unstake_requested_ms > 0, 103);
        assert!(v1 >= v3.unstake_requested_ms + 600000, 104);
        let v4 = 0x2::balance::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&v3.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>>(0x2::coin::from_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(0x2::balance::withdraw_all<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v3.balance), arg3), v0);
        v2.total_staked = v2.total_staked - v4;
        v2.staker_count = v2.staker_count - 1;
        arg0.total_staked = arg0.total_staked - v4;
        arg0.total_positions = arg0.total_positions - 1;
        let StakerPosition {
            balance              : v5,
            last_stake_time_ms   : _,
            unstake_requested_ms : _,
        } = 0x2::table::remove<address, StakerPosition>(&mut v2.stakers, v0);
        0x2::balance::destroy_zero<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(v5);
        let v8 = Unstaked{
            staker       : v0,
            template_id  : arg1,
            amount       : v4,
            timestamp_ms : v1,
        };
        0x2::event::emit<Unstaked>(v8);
    }

    public entry fun complete_unstake_with_registry(arg0: &mut StakingRegistry, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg2), 102);
        let v2 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, arg2);
        assert!(0x2::table::contains<address, StakerPosition>(&v2.stakers, v0), 102);
        let v3 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v2.stakers, v0);
        assert!(v3.unstake_requested_ms > 0, 103);
        assert!(v1 >= v3.unstake_requested_ms + 600000, 104);
        let v4 = 0x2::balance::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&v3.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>>(0x2::coin::from_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(0x2::balance::withdraw_all<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v3.balance), arg4), v0);
        v2.total_staked = v2.total_staked - v4;
        v2.staker_count = v2.staker_count - 1;
        arg0.total_staked = arg0.total_staked - v4;
        arg0.total_positions = arg0.total_positions - 1;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_stake(arg1, arg2, v2.total_staked);
        let StakerPosition {
            balance              : v5,
            last_stake_time_ms   : _,
            unstake_requested_ms : _,
        } = 0x2::table::remove<address, StakerPosition>(&mut v2.stakers, v0);
        0x2::balance::destroy_zero<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(v5);
        let v8 = Unstaked{
            staker       : v0,
            template_id  : arg2,
            amount       : v4,
            timestamp_ms : v1,
        };
        0x2::event::emit<Unstaked>(v8);
    }

    public fun get_staker_position(arg0: &StakingRegistry, arg1: address, arg2: address) : (u64, u64) {
        if (!0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, TemplateStakeInfo>(&arg0.template_stakes, arg1);
        if (!0x2::table::contains<address, StakerPosition>(&v0.stakers, arg2)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<address, StakerPosition>(&v0.stakers, arg2);
        (0x2::balance::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&v1.balance), v1.last_stake_time_ms)
    }

    public fun get_template_staker_count(arg0: &StakingRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1)) {
            0x2::table::borrow<address, TemplateStakeInfo>(&arg0.template_stakes, arg1).staker_count
        } else {
            0
        }
    }

    public fun get_template_total_stake(arg0: &StakingRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1)) {
            0x2::table::borrow<address, TemplateStakeInfo>(&arg0.template_stakes, arg1).total_staked
        } else {
            0
        }
    }

    public fun get_total_positions(arg0: &StakingRegistry) : u64 {
        arg0.total_positions
    }

    public fun get_total_staked(arg0: &StakingRegistry) : u64 {
        arg0.total_staked
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingRegistry{
            id              : 0x2::object::new(arg0),
            template_stakes : 0x2::table::new<address, TemplateStakeInfo>(arg0),
            total_staked    : 0,
            total_positions : 0,
        };
        0x2::transfer::share_object<StakingRegistry>(v0);
    }

    public entry fun request_unstake(arg0: &mut StakingRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, arg1), 102);
        let v2 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, arg1);
        assert!(0x2::table::contains<address, StakerPosition>(&v2.stakers, v0), 102);
        let v3 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v2.stakers, v0);
        assert!(v3.unstake_requested_ms == 0, 105);
        v3.unstake_requested_ms = v1;
        let v4 = UnstakeRequested{
            staker           : v0,
            template_id      : arg1,
            amount           : 0x2::balance::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&v3.balance),
            cooldown_ends_ms : v1 + 600000,
            timestamp_ms     : v1,
        };
        0x2::event::emit<UnstakeRequested>(v4);
    }

    public entry fun stake(arg0: &mut StakingRegistry, arg1: &0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::Template, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::coin::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&arg3);
        let v3 = 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::template_id(arg1);
        assert!(0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::is_template_active(arg1), 100);
        assert!(v2 >= 100000000, 101);
        if (!0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, v3)) {
            let v4 = TemplateStakeInfo{
                total_staked : 0,
                staker_count : 0,
                stakers      : 0x2::table::new<address, StakerPosition>(arg4),
            };
            0x2::table::add<address, TemplateStakeInfo>(&mut arg0.template_stakes, v3, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, v3);
        if (!0x2::table::contains<address, StakerPosition>(&v5.stakers, v0)) {
            let v6 = StakerPosition{
                balance              : 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg3),
                last_stake_time_ms   : v1,
                unstake_requested_ms : 0,
            };
            0x2::table::add<address, StakerPosition>(&mut v5.stakers, v0, v6);
            v5.staker_count = v5.staker_count + 1;
            arg0.total_positions = arg0.total_positions + 1;
        } else {
            let v7 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v5.stakers, v0);
            0x2::balance::join<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v7.balance, 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg3));
            v7.last_stake_time_ms = v1;
            v7.unstake_requested_ms = 0;
        };
        v5.total_staked = v5.total_staked + v2;
        arg0.total_staked = arg0.total_staked + v2;
        let v8 = StakeReceipt{
            id           : 0x2::object::new(arg4),
            template_id  : v3,
            staker       : v0,
            amount       : v2,
            staked_at_ms : v1,
        };
        0x2::transfer::transfer<StakeReceipt>(v8, v0);
        let v9 = Staked{
            staker            : v0,
            template_id       : v3,
            amount            : v2,
            total_on_template : v5.total_staked,
            timestamp_ms      : v1,
        };
        0x2::event::emit<Staked>(v9);
    }

    public entry fun stake_with_registry(arg0: &mut StakingRegistry, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: &0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::Template, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&arg4);
        let v3 = 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::template_id(arg2);
        assert!(0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool::is_template_active(arg2), 100);
        assert!(v2 >= 100000000, 101);
        if (!0x2::table::contains<address, TemplateStakeInfo>(&arg0.template_stakes, v3)) {
            let v4 = TemplateStakeInfo{
                total_staked : 0,
                staker_count : 0,
                stakers      : 0x2::table::new<address, StakerPosition>(arg5),
            };
            0x2::table::add<address, TemplateStakeInfo>(&mut arg0.template_stakes, v3, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, TemplateStakeInfo>(&mut arg0.template_stakes, v3);
        if (!0x2::table::contains<address, StakerPosition>(&v5.stakers, v0)) {
            let v6 = StakerPosition{
                balance              : 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg4),
                last_stake_time_ms   : v1,
                unstake_requested_ms : 0,
            };
            0x2::table::add<address, StakerPosition>(&mut v5.stakers, v0, v6);
            v5.staker_count = v5.staker_count + 1;
            arg0.total_positions = arg0.total_positions + 1;
        } else {
            let v7 = 0x2::table::borrow_mut<address, StakerPosition>(&mut v5.stakers, v0);
            0x2::balance::join<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(&mut v7.balance, 0x2::coin::into_balance<0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3>(arg4));
            v7.last_stake_time_ms = v1;
            v7.unstake_requested_ms = 0;
        };
        v5.total_staked = v5.total_staked + v2;
        arg0.total_staked = arg0.total_staked + v2;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_stake(arg1, v3, v5.total_staked);
        let v8 = StakeReceipt{
            id           : 0x2::object::new(arg5),
            template_id  : v3,
            staker       : v0,
            amount       : v2,
            staked_at_ms : v1,
        };
        0x2::transfer::transfer<StakeReceipt>(v8, v0);
        let v9 = Staked{
            staker            : v0,
            template_id       : v3,
            amount            : v2,
            total_on_template : v5.total_staked,
            timestamp_ms      : v1,
        };
        0x2::event::emit<Staked>(v9);
    }

    // decompiled from Move bytecode v6
}

