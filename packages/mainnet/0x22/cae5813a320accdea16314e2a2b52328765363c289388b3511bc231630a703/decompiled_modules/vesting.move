module 0x22cae5813a320accdea16314e2a2b52328765363c289388b3511bc231630a703::vesting {
    struct VestingAdminCapability has key {
        id: 0x2::object::UID,
    }

    struct VestingVault has key {
        id: 0x2::object::UID,
        governance_cap: 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::VestingVoteCap,
        hive_profile: 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveProfile,
        sum_hive_vested: u64,
        hive_to_vest: u64,
        hive_claimed: u64,
    }

    struct HiveVestingSchedule has key {
        id: 0x2::object::UID,
        beneficiary: address,
        proposed_new_beneficiary: 0x1::option::Option<address>,
        available_hive: 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::HiveGems,
        total_vested_amt: u64,
        claimed_amt: u64,
        release_rate: u128,
        start_timestamp: u64,
        unlock_timestamp: u64,
        vesting_duration: u64,
        is_clawback_allowed: bool,
    }

    struct VestingScheduleKrafted has copy, drop {
        schedule_id: address,
        beneficiary: address,
        vested_hive_amt: u64,
        release_rate: u128,
        start_timestamp: u64,
        unlock_timestamp: u64,
        vesting_duration: u64,
        is_clawback_allowed: bool,
    }

    struct AddedToSchedule has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_added: u64,
        new_release_rate: u128,
    }

    struct GemsClawedBack has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_gems_clawed_back: u64,
        new_release_rate: u128,
    }

    struct NewBeneficiaryAccepted has copy, drop {
        schedule_id: address,
        beneficiary: address,
    }

    struct NewBeneficiaryProposed has copy, drop {
        schedule_id: address,
        beneficiary: address,
        new_beneficiary: address,
    }

    struct VestedGemsClaimed has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_gems_claimed: u64,
    }

    struct VotedWithVestedHive has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_gems_used: u64,
        proposal_id: u64,
        latest_vote: bool,
    }

    public entry fun accept_proposed_new_beneficiary(arg0: &VestingAdminCapability, arg1: &mut HiveVestingSchedule, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg1.proposed_new_beneficiary), 5102);
        arg1.beneficiary = 0x1::option::extract<address>(&mut arg1.proposed_new_beneficiary);
        arg1.proposed_new_beneficiary = 0x1::option::none<address>();
        let v0 = NewBeneficiaryAccepted{
            schedule_id : 0x2::object::uid_to_address(&arg1.id),
            beneficiary : arg1.beneficiary,
        };
        0x2::event::emit<NewBeneficiaryAccepted>(v0);
    }

    public entry fun add_hive_for_vesting(arg0: &mut 0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HiveVault, arg1: &mut VestingVault, arg2: &VestingAdminCapability, arg3: 0x2::coin::Coin<0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::burn_hive_and_return(arg0, &mut arg1.hive_profile, 0x2::coin::into_balance<0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HIVE>(arg3), arg4, arg5);
        arg1.sum_hive_vested = arg1.sum_hive_vested + arg4;
        arg1.hive_to_vest = arg1.hive_to_vest + arg4;
        let v1 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HIVE>(v0, v1, arg5);
    }

    public entry fun add_to_vesting_schedule(arg0: &0x2::clock::Clock, arg1: &VestingAdminCapability, arg2: &mut VestingVault, arg3: &mut 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::HiveDaoGovernor, arg4: &mut HiveVestingSchedule, arg5: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg4.start_timestamp + arg4.vesting_duration, 5108);
        assert!(arg5 > 0, 5109);
        arg2.hive_to_vest = arg2.hive_to_vest - arg5;
        0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::join(&mut arg4.available_hive, 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::withdraw_gems_from_comp_profile(&mut arg2.hive_profile, arg5));
        arg4.release_rate = (0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::mul_div_u256((0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg4.available_hive) as u256), (1000000000 as u256), (arg4.vesting_duration as u256)) as u128);
        0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::update_vesting_power(&arg2.governance_cap, arg3, arg5, 0);
        let v0 = AddedToSchedule{
            schedule_id      : 0x2::object::uid_to_address(&arg4.id),
            beneficiary      : arg4.beneficiary,
            hive_added       : arg5,
            new_release_rate : arg4.release_rate,
        };
        0x2::event::emit<AddedToSchedule>(v0);
    }

    fun calc_vested_amt(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg1) {
            return 0
        };
        if (arg3 > arg1 + arg2) {
            (0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::mul_div_u256((arg0 as u256), (arg2 as u256), (1000000000 as u256)) as u64)
        } else {
            (0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::mul_div_u256((arg0 as u256), ((arg3 - arg1) as u256), (1000000000 as u256)) as u64)
        }
    }

    public entry fun cast_vote_with_vested_hive(arg0: &0x2::clock::Clock, arg1: &mut VestingVault, arg2: &mut 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::HiveDaoGovernor, arg3: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveManager, arg4: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::DSuiDisperser<0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::dsui::DSUI>, arg5: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveDisperser, arg6: &mut HiveVestingSchedule, arg7: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveProfile, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg6.beneficiary, 5102);
        assert!(0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::get_profile_owner(arg7) == arg6.beneficiary, 5107);
        let v0 = 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg6.available_hive);
        0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::cast_vote_with_vested_hive(&arg1.governance_cap, arg0, arg2, arg3, arg4, arg5, arg7, v0, arg8, arg9, arg10);
        let v1 = VotedWithVestedHive{
            schedule_id    : 0x2::object::uid_to_address(&arg6.id),
            beneficiary    : arg6.beneficiary,
            hive_gems_used : v0,
            proposal_id    : arg8,
            latest_vote    : arg9,
        };
        0x2::event::emit<VotedWithVestedHive>(v1);
    }

    public entry fun claim_released_hive_gems(arg0: &0x2::clock::Clock, arg1: &mut 0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HiveVault, arg2: &mut VestingVault, arg3: &mut 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::HiveDaoGovernor, arg4: &mut HiveVestingSchedule, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg4.beneficiary, 5102);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0;
        let v2 = v1;
        if (v0 > arg4.unlock_timestamp) {
            let v3 = 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::min_u64(calc_vested_amt(arg4.release_rate, arg4.start_timestamp, arg4.vesting_duration, v0) - arg4.claimed_amt, 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg4.available_hive));
            v2 = v1 + v3;
            let v4 = 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::split(&mut arg4.available_hive, v3);
            0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::deposit_gems_for_hive(arg1, &mut v4, v3, arg5);
            0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::destroy_zero(v4);
            0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::update_vesting_power(&arg2.governance_cap, arg3, 0, v3);
            arg4.claimed_amt = arg4.claimed_amt + v3;
        };
        arg2.hive_claimed = arg2.hive_claimed + v2;
        let v5 = 0x2::object::uid_to_inner(&arg4.id);
        let v6 = VestedGemsClaimed{
            schedule_id       : 0x2::object::id_to_address(&v5),
            beneficiary       : arg4.beneficiary,
            hive_gems_claimed : v2,
        };
        0x2::event::emit<VestedGemsClaimed>(v6);
    }

    public entry fun clawback_unvested_gems(arg0: &0x2::clock::Clock, arg1: &VestingAdminCapability, arg2: &mut VestingVault, arg3: &mut 0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::HiveVault, arg4: &mut 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::HiveDaoGovernor, arg5: &mut HiveVestingSchedule, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.is_clawback_allowed, 5104);
        assert!(arg6 <= arg5.total_vested_amt - calc_vested_amt(arg5.release_rate, arg5.start_timestamp, arg5.vesting_duration, 0x2::clock::timestamp_ms(arg0)), 5103);
        let v0 = 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::split(&mut arg5.available_hive, arg6);
        arg5.release_rate = (0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::mul_div_u256((0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg5.available_hive) as u256), (1000000000 as u256), (arg5.vesting_duration as u256)) as u128);
        arg5.total_vested_amt = arg5.total_vested_amt - arg6;
        arg2.hive_to_vest = arg2.hive_to_vest + arg6;
        0xe1897fb329950bff07aaed50d45ae8e32cff04e22fe8f0b220cb1154a7ddf072::hive::deposit_gems_for_hive(arg3, &mut v0, arg6, arg7);
        0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::destroy_zero(v0);
        0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::update_vesting_power(&arg2.governance_cap, arg4, 0, arg6);
        let v1 = GemsClawedBack{
            schedule_id           : 0x2::object::uid_to_address(&arg5.id),
            beneficiary           : arg5.beneficiary,
            hive_gems_clawed_back : arg6,
            new_release_rate      : arg5.release_rate,
        };
        0x2::event::emit<GemsClawedBack>(v1);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_released_and_claimable_gems_for_schedule(arg0: &HiveVestingSchedule, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = calc_vested_amt(arg0.release_rate, arg0.start_timestamp, arg0.vesting_duration, 0x2::clock::timestamp_ms(arg1));
        let v1 = if (arg0.unlock_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::min_u64(v0 - arg0.claimed_amt, 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg0.available_hive))
        } else {
            0
        };
        (v0, v1)
    }

    public fun get_vesting_schedule_info(arg0: &HiveVestingSchedule) : (address, u64, u64, u64, u128, u64, u64, u64, bool) {
        (arg0.beneficiary, 0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::hive_gems::value(&arg0.available_hive), arg0.total_vested_amt, arg0.claimed_amt, arg0.release_rate, arg0.start_timestamp, arg0.unlock_timestamp, arg0.vesting_duration, arg0.is_clawback_allowed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingAdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VestingAdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_vesting_schedule(arg0: &0x2::clock::Clock, arg1: &mut VestingVault, arg2: &VestingAdminCapability, arg3: &mut 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::HiveDaoGovernor, arg4: address, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        assert!(arg7 > 0 && arg9 > 0, 5105);
        arg1.hive_to_vest = arg1.hive_to_vest - arg5;
        let v0 = HiveVestingSchedule{
            id                       : 0x2::object::new(arg10),
            beneficiary              : arg4,
            proposed_new_beneficiary : 0x1::option::none<address>(),
            available_hive           : 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::withdraw_gems_from_comp_profile(&mut arg1.hive_profile, arg5),
            total_vested_amt         : arg5,
            claimed_amt              : 0,
            release_rate             : (0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::math::mul_div_u256((arg5 as u256), (1000000000 as u256), (arg9 as u256)) as u128),
            start_timestamp          : arg7,
            unlock_timestamp         : arg8,
            vesting_duration         : arg9,
            is_clawback_allowed      : arg6,
        };
        0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::update_vesting_power(&arg1.governance_cap, arg3, arg5, 0);
        let v1 = VestingScheduleKrafted{
            schedule_id         : 0x2::object::uid_to_address(&v0.id),
            beneficiary         : arg4,
            vested_hive_amt     : arg5,
            release_rate        : v0.release_rate,
            start_timestamp     : arg7,
            unlock_timestamp    : arg8,
            vesting_duration    : arg9,
            is_clawback_allowed : arg6,
        };
        0x2::event::emit<VestingScheduleKrafted>(v1);
        0x2::transfer::share_object<HiveVestingSchedule>(v0);
    }

    public entry fun kraft_vesting_vault_obj(arg0: 0x7ed5c3f1054b5b80d969f57369ebef64c36f23d73dd708b24fac5d534b8acad9::hive_dao::VestingVoteCap, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &VestingAdminCapability, arg4: &mut 0x1c096bec7f46dd3dfd04bc2ab7c0050a0a1a504f9f2a2131893350589a50bc6e::dsui_vault::DSuiVault, arg5: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveProfileMappingStore, arg6: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::HiveManager, arg7: &mut 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::DSuiDisperser<0xbc580569b4a4ecf5718a221d93df04a1a8c9e43deae51ff9b619305ebf7b6cc8::dsui::DSUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1b8c7143edbd369019048d6d46d873e3b1972e356f3c047796c97ab120451fb3::hive_profile::kraft_owned_hive_profile(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = VestingVault{
            id              : 0x2::object::new(arg11),
            governance_cap  : arg0,
            hive_profile    : v0,
            sum_hive_vested : 0,
            hive_to_vest    : 0,
            hive_claimed    : 0,
        };
        0x2::transfer::share_object<VestingVault>(v2);
        let v3 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v3, arg11);
    }

    public entry fun set_proposed_new_beneficiary(arg0: &mut HiveVestingSchedule, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 5102);
        arg0.proposed_new_beneficiary = 0x1::option::some<address>(arg1);
        let v0 = NewBeneficiaryProposed{
            schedule_id     : 0x2::object::uid_to_address(&arg0.id),
            beneficiary     : arg0.beneficiary,
            new_beneficiary : arg1,
        };
        0x2::event::emit<NewBeneficiaryProposed>(v0);
    }

    // decompiled from Move bytecode v6
}

