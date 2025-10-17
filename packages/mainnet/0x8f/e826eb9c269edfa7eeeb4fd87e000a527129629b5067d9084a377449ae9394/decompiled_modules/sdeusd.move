module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::sdeusd {
    struct SDEUSD has drop {
        dummy_field: bool,
    }

    struct SdeUSDManagement has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SDEUSD>,
        deny_cap: 0x2::coin::DenyCapV2<SDEUSD>,
        deusd_balance: 0x2::balance::Balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>,
        silo_balance: 0x2::balance::Balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>,
        vesting_amount: u64,
        last_distribution_timestamp: u64,
        total_unused_reward_amount: u64,
        last_zero_supply_timestamp: u64,
        cooldown_duration: u64,
        cooldowns: 0x2::table::Table<address, UserCooldown>,
        soft_restricted_stakers: 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::Set<address>,
        full_restricted_stakers: 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::Set<address>,
    }

    struct UserCooldown has store {
        cooldown_end: u64,
        underlying_amount: u64,
    }

    struct RewardsReceived has copy, drop, store {
        amount: u64,
    }

    struct CooldownDurationUpdated has copy, drop, store {
        previous_duration: u64,
        new_duration: u64,
    }

    struct Deposit has copy, drop, store {
        sender: address,
        receiver: address,
        assets: u64,
        shares: u64,
    }

    struct Withdraw has copy, drop, store {
        sender: address,
        receiver: address,
        owner: address,
        assets: u64,
        shares: u64,
    }

    struct WithdrawToSilo has copy, drop, store {
        sender: address,
        assets: u64,
        shares: u64,
    }

    struct Unstaked has copy, drop, store {
        user: address,
        receiver: address,
        assets: u64,
    }

    struct UserBlacklisted has copy, drop, store {
        sender: address,
        user: address,
        is_full_blacklisting: bool,
    }

    struct UserUnblacklisted has copy, drop, store {
        sender: address,
        user: address,
        is_full_blacklisting: bool,
    }

    struct WithdrawUnusedRewards has copy, drop, store {
        to: address,
        amount: u64,
    }

    public fun mint(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: &mut 0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(0x2::coin::value<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(arg2) > 0, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!is_restricted_staker(arg0, v0), 4);
        assert!(!is_restricted_staker(arg0, arg4), 4);
        let v1 = preview_mint(arg0, arg3, arg5);
        assert!(v1 > 0, 2);
        0x2::balance::join<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.deusd_balance, 0x2::coin::into_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::coin::split<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(arg2, v1, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<SDEUSD>>(0x2::coin::mint<SDEUSD>(&mut arg0.treasury_cap, arg3, arg6), arg4);
        check_min_shares(arg0);
        update_state_after_supply_increased(arg0, arg5);
        let v2 = Deposit{
            sender   : v0,
            receiver : arg4,
            assets   : v1,
            shares   : arg3,
        };
        0x2::event::emit<Deposit>(v2);
    }

    public fun total_supply(arg0: &SdeUSDManagement) : u64 {
        0x2::coin::total_supply<SDEUSD>(&arg0.treasury_cap)
    }

    public fun add_to_blacklist(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg1, 0x2::tx_context::sender(arg5), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_blacklist_manager()), 1);
        if (arg4) {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::add<address>(&mut arg0.full_restricted_stakers, arg3);
            0x2::coin::deny_list_v2_add<SDEUSD>(arg2, &mut arg0.deny_cap, arg3, arg5);
        } else {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::add<address>(&mut arg0.soft_restricted_stakers, arg3);
        };
        let v0 = UserBlacklisted{
            sender               : 0x2::tx_context::sender(arg5),
            user                 : arg3,
            is_full_blacklisting : arg4,
        };
        0x2::event::emit<UserBlacklisted>(v0);
    }

    fun assert_cooldown_off(arg0: &SdeUSDManagement) {
        assert!(arg0.cooldown_duration == 0, 4);
    }

    fun assert_cooldown_on(arg0: &SdeUSDManagement) {
        assert!(arg0.cooldown_duration != 0, 4);
    }

    fun check_min_shares(arg0: &SdeUSDManagement) {
        let v0 = total_supply(arg0);
        assert!(v0 == 0 || v0 >= 1000000, 8);
    }

    fun convert_to_assets(arg0: &SdeUSDManagement, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        let v0 = total_supply(arg0);
        let v1 = total_assets(arg0, arg3);
        if (v0 == 0 || v1 == 0) {
            arg1
        } else {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(arg1, v1, v0, arg2)
        }
    }

    fun convert_to_shares(arg0: &SdeUSDManagement, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        let v0 = total_supply(arg0);
        let v1 = total_assets(arg0, arg3);
        if (v0 == 0 || v1 == 0) {
            arg1
        } else {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(arg1, v0, v1, arg2)
        }
    }

    public fun cooldown_assets(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: u64, arg3: &mut 0x2::coin::Coin<SDEUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert_cooldown_on(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = max_withdraw(arg0, 0x2::coin::value<SDEUSD>(arg3), arg4);
        assert!(arg2 <= v1, 6);
        let v2 = preview_withdraw(arg0, arg2, arg4);
        update_user_cooldown(arg0, v0, arg2, arg4);
        let v3 = 0x2::coin::split<SDEUSD>(arg3, v2, arg5);
        withdraw_to_silo(arg0, v0, arg2, v3, arg4, arg5);
    }

    public fun cooldown_duration(arg0: &SdeUSDManagement) : u64 {
        arg0.cooldown_duration
    }

    public fun cooldown_shares(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: &mut 0x2::coin::Coin<SDEUSD>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(arg0.cooldown_duration > 0, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<SDEUSD>(arg2);
        let v2 = preview_redeem(arg0, v1, arg3);
        update_user_cooldown(arg0, v0, v2, arg3);
        let v3 = 0x2::coin::split<SDEUSD>(arg2, v1, arg4);
        withdraw_to_silo(arg0, v0, v2, v3, arg3, arg4);
    }

    public fun deposit(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: 0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!is_restricted_staker(arg0, v0), 4);
        assert!(!is_restricted_staker(arg0, arg3), 4);
        let v1 = 0x2::coin::value<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&arg2);
        assert!(v1 > 0, 2);
        let v2 = preview_deposit(arg0, v1, arg4);
        assert!(v2 > 0, 2);
        0x2::balance::join<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.deusd_balance, 0x2::coin::into_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<SDEUSD>>(0x2::coin::mint<SDEUSD>(&mut arg0.treasury_cap, v2, arg5), arg3);
        check_min_shares(arg0);
        update_state_after_supply_increased(arg0, arg4);
        let v3 = Deposit{
            sender   : v0,
            receiver : arg3,
            assets   : v1,
            shares   : v2,
        };
        0x2::event::emit<Deposit>(v3);
    }

    public fun get_total_unused_reward_amount(arg0: &SdeUSDManagement, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.last_zero_supply_timestamp == 18446744073709551615 || arg0.vesting_amount == 0) {
            return arg0.total_unused_reward_amount
        };
        let v0 = 0x1::u64::max(arg0.last_zero_supply_timestamp, arg0.last_distribution_timestamp);
        let v1 = 0x1::u64::min(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg1), arg0.last_distribution_timestamp + 28800);
        let v2 = if (v1 > v0) {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(v1 - v0, arg0.vesting_amount, 28800, false)
        } else {
            0
        };
        arg0.total_unused_reward_amount + v2
    }

    public fun get_unvested_amount(arg0: &SdeUSDManagement, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg1) - arg0.last_distribution_timestamp;
        if (v0 >= 28800) {
            return 0
        };
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(28800 - v0, arg0.vesting_amount, 28800, false)
    }

    public fun get_user_cooldown_info(arg0: &SdeUSDManagement, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, UserCooldown>(&arg0.cooldowns, arg1)) {
            let v2 = 0x2::table::borrow<address, UserCooldown>(&arg0.cooldowns, arg1);
            (v2.cooldown_end, v2.underlying_amount)
        } else {
            (0, 0)
        }
    }

    fun init(arg0: SDEUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SDEUSD>(arg0, 6, b"sdeUSD", b"Staked deUSD", b"Staked deUSD tokens for earning yield", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDEUSD>>(v2);
        let v3 = SdeUSDManagement{
            id                          : 0x2::object::new(arg1),
            treasury_cap                : v0,
            deny_cap                    : v1,
            deusd_balance               : 0x2::balance::zero<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(),
            silo_balance                : 0x2::balance::zero<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(),
            vesting_amount              : 0,
            last_distribution_timestamp : 0,
            total_unused_reward_amount  : 0,
            last_zero_supply_timestamp  : 0,
            cooldown_duration           : 7776000,
            cooldowns                   : 0x2::table::new<address, UserCooldown>(arg1),
            soft_restricted_stakers     : 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::new<address>(arg1),
            full_restricted_stakers     : 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::new<address>(arg1),
        };
        0x2::transfer::share_object<SdeUSDManagement>(v3);
    }

    public fun is_full_restricted(arg0: &SdeUSDManagement, arg1: address) : bool {
        is_full_restricted_staker(arg0, arg1)
    }

    fun is_full_restricted_staker(arg0: &SdeUSDManagement, arg1: address) : bool {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.full_restricted_stakers, arg1)
    }

    fun is_restricted_staker(arg0: &SdeUSDManagement, arg1: address) : bool {
        is_soft_restricted_staker(arg0, arg1) || is_full_restricted_staker(arg0, arg1)
    }

    public fun is_soft_restricted(arg0: &SdeUSDManagement, arg1: address) : bool {
        is_soft_restricted_staker(arg0, arg1)
    }

    fun is_soft_restricted_staker(arg0: &SdeUSDManagement, arg1: address) : bool {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.soft_restricted_stakers, arg1)
    }

    public fun max_withdraw(arg0: &mut SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        preview_redeem(arg0, arg1, arg2)
    }

    public fun preview_deposit(arg0: &SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        convert_to_shares(arg0, arg1, false, arg2)
    }

    public fun preview_mint(arg0: &SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        convert_to_assets(arg0, arg1, true, arg2)
    }

    public fun preview_redeem(arg0: &SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        convert_to_assets(arg0, arg1, false, arg2)
    }

    public fun preview_withdraw(arg0: &SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        convert_to_shares(arg0, arg1, true, arg2)
    }

    public fun redeem(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: 0x2::coin::Coin<SDEUSD>, arg3: address, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert_cooldown_off(arg0);
        let v0 = preview_redeem(arg0, 0x2::coin::value<SDEUSD>(&arg2), arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        withdraw_to_user(arg0, v1, arg4, arg3, v0, arg2, arg5, arg6);
    }

    public fun remove_from_blacklist(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg1, 0x2::tx_context::sender(arg5), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_blacklist_manager()), 1);
        if (arg4) {
            if (0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.full_restricted_stakers, arg3)) {
                0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::remove<address>(&mut arg0.full_restricted_stakers, arg3);
                0x2::coin::deny_list_v2_remove<SDEUSD>(arg2, &mut arg0.deny_cap, arg3, arg5);
            };
        } else if (0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::contains<address>(&arg0.soft_restricted_stakers, arg3)) {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::set::remove<address>(&mut arg0.soft_restricted_stakers, arg3);
        };
        let v0 = UserUnblacklisted{
            sender               : 0x2::tx_context::sender(arg5),
            user                 : arg3,
            is_full_blacklisting : arg4,
        };
        0x2::event::emit<UserUnblacklisted>(v0);
    }

    public fun set_cooldown_duration(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut SdeUSDManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: u64) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg2);
        assert!(arg3 <= 7776000, 5);
        arg1.cooldown_duration = arg3;
        let v0 = CooldownDurationUpdated{
            previous_duration : arg1.cooldown_duration,
            new_duration      : arg3,
        };
        0x2::event::emit<CooldownDurationUpdated>(v0);
    }

    public fun total_assets(arg0: &SdeUSDManagement, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::value<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&arg0.deusd_balance);
        let v1 = get_unvested_amount(arg0, arg1);
        let v2 = get_total_unused_reward_amount(arg0, arg1);
        if (v0 >= v1 + v2) {
            v0 - v1 + v2
        } else {
            0
        }
    }

    public fun transfer_in_rewards(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: 0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::has_role(arg1, 0x2::tx_context::sender(arg4), 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::roles::role_rewarder()), 1);
        let v0 = 0x2::coin::value<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&arg2);
        assert!(v0 > 0, 2);
        update_vesting_amount(arg0, v0, arg3);
        0x2::balance::join<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.deusd_balance, 0x2::coin::into_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(arg2));
        let v1 = RewardsReceived{amount: v0};
        0x2::event::emit<RewardsReceived>(v1);
    }

    public fun unstake(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!is_full_restricted(arg0, v0), 4);
        assert!(0x2::table::contains<address, UserCooldown>(&arg0.cooldowns, v0), 4);
        let v1 = 0x2::table::borrow_mut<address, UserCooldown>(&mut arg0.cooldowns, v0);
        assert!(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg3) >= v1.cooldown_end || arg0.cooldown_duration == 0, 5);
        let v2 = v1.underlying_amount;
        v1.cooldown_end = 0;
        v1.underlying_amount = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>>(0x2::coin::from_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::balance::split<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.silo_balance, v2), arg4), arg2);
        let v3 = Unstaked{
            user     : v0,
            receiver : arg2,
            assets   : v2,
        };
        0x2::event::emit<Unstaked>(v3);
    }

    fun update_state_after_supply_decreased(arg0: &mut SdeUSDManagement, arg1: &0x2::clock::Clock) {
        if (total_supply(arg0) != 0) {
            return
        };
        arg0.last_zero_supply_timestamp = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg1);
    }

    fun update_state_after_supply_increased(arg0: &mut SdeUSDManagement, arg1: &0x2::clock::Clock) {
        if (arg0.last_zero_supply_timestamp == 18446744073709551615) {
            return
        };
        arg0.last_zero_supply_timestamp = 18446744073709551615;
        if (arg0.vesting_amount == 0) {
            return
        };
        let v0 = 0x1::u64::max(arg0.last_zero_supply_timestamp, arg0.last_distribution_timestamp);
        let v1 = 0x1::u64::min(0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg1), arg0.last_distribution_timestamp + 28800);
        let v2 = if (v1 > v0) {
            0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(v1 - v0, arg0.vesting_amount, 28800, false)
        } else {
            0
        };
        arg0.total_unused_reward_amount = arg0.total_unused_reward_amount + v2;
    }

    fun update_user_cooldown(arg0: &mut SdeUSDManagement, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        if (0x2::table::contains<address, UserCooldown>(&arg0.cooldowns, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, UserCooldown>(&mut arg0.cooldowns, arg1);
            v0.cooldown_end = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg3) + arg0.cooldown_duration;
            v0.underlying_amount = v0.underlying_amount + arg2;
        } else {
            let v1 = UserCooldown{
                cooldown_end      : 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg3) + arg0.cooldown_duration,
                underlying_amount : arg2,
            };
            0x2::table::add<address, UserCooldown>(&mut arg0.cooldowns, arg1, v1);
        };
    }

    fun update_vesting_amount(arg0: &mut SdeUSDManagement, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(get_unvested_amount(arg0, arg2) == 0, 9);
        if (arg0.last_zero_supply_timestamp != 18446744073709551615 && arg0.vesting_amount > 0) {
            let v0 = arg0.last_distribution_timestamp + 28800;
            if (0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg2) >= v0 && arg0.last_zero_supply_timestamp < v0) {
                arg0.total_unused_reward_amount = arg0.total_unused_reward_amount + 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(v0 - 0x1::u64::max(arg0.last_zero_supply_timestamp, arg0.last_distribution_timestamp), arg0.vesting_amount, 28800, false);
            };
        };
        arg0.vesting_amount = arg1;
        arg0.last_distribution_timestamp = 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg2);
    }

    public fun withdraw(arg0: &mut SdeUSDManagement, arg1: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg2: u64, arg3: &mut 0x2::coin::Coin<SDEUSD>, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg1);
        assert_cooldown_off(arg0);
        let v0 = 0x2::coin::split<SDEUSD>(arg3, preview_withdraw(arg0, arg2, arg6), arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        withdraw_to_user(arg0, v1, arg5, arg4, arg2, v0, arg6, arg7);
    }

    fun withdraw_to_silo(arg0: &mut SdeUSDManagement, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<SDEUSD>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        let v0 = 0x2::coin::value<SDEUSD>(&arg3);
        assert!(v0 > 0, 2);
        assert!(!is_full_restricted_staker(arg0, arg1), 4);
        0x2::coin::burn<SDEUSD>(&mut arg0.treasury_cap, arg3);
        0x2::balance::join<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.silo_balance, 0x2::coin::into_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::coin::from_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::balance::split<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.deusd_balance, arg2), arg5)));
        check_min_shares(arg0);
        update_state_after_supply_decreased(arg0, arg4);
        let v1 = WithdrawToSilo{
            sender : arg1,
            assets : arg2,
            shares : v0,
        };
        0x2::event::emit<WithdrawToSilo>(v1);
    }

    fun withdraw_to_user(arg0: &mut SdeUSDManagement, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<SDEUSD>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 2);
        let v0 = 0x2::coin::value<SDEUSD>(&arg5);
        assert!(v0 > 0, 2);
        assert!(!is_full_restricted_staker(arg0, arg1), 4);
        assert!(!is_full_restricted_staker(arg0, arg2), 4);
        assert!(!is_full_restricted_staker(arg0, arg3), 4);
        0x2::coin::burn<SDEUSD>(&mut arg0.treasury_cap, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>>(0x2::coin::from_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::balance::split<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg0.deusd_balance, arg4), arg7), arg2);
        check_min_shares(arg0);
        update_state_after_supply_decreased(arg0, arg6);
        let v1 = Withdraw{
            sender   : arg1,
            receiver : arg2,
            owner    : arg3,
            assets   : arg4,
            shares   : v0,
        };
        0x2::event::emit<Withdraw>(v1);
    }

    public fun withdraw_unused_rewards(arg0: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::admin_cap::AdminCap, arg1: &mut SdeUSDManagement, arg2: &0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::GlobalConfig, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::config::check_package_version(arg2);
        if (arg1.vesting_amount != 0) {
            let v0 = arg1.last_distribution_timestamp + 28800;
            if (0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::clock_utils::timestamp_seconds(arg4) > v0) {
                if (arg1.last_zero_supply_timestamp != 18446744073709551615 && arg1.last_zero_supply_timestamp < v0) {
                    arg1.total_unused_reward_amount = arg1.total_unused_reward_amount + 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64::mul_div(v0 - 0x1::u64::max(arg1.last_zero_supply_timestamp, arg1.last_distribution_timestamp), arg1.vesting_amount, 28800, false);
                };
                arg1.vesting_amount = 0;
            };
        };
        let v1 = arg1.total_unused_reward_amount;
        assert!(v1 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>>(0x2::coin::from_balance<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(0x2::balance::split<0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::deusd::DEUSD>(&mut arg1.deusd_balance, v1), arg5), arg3);
        arg1.total_unused_reward_amount = 0;
        let v2 = WithdrawUnusedRewards{
            to     : arg3,
            amount : v1,
        };
        0x2::event::emit<WithdrawUnusedRewards>(v2);
    }

    // decompiled from Move bytecode v6
}

