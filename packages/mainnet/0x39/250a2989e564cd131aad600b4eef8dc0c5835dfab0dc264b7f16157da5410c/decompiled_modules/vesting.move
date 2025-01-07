module 0x39250a2989e564cd131aad600b4eef8dc0c5835dfab0dc264b7f16157da5410c::vesting {
    struct VestingVault has key {
        id: 0x2::object::UID,
        admin_address: address,
        hive_profile: 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile,
        available_vested_hive: u64,
    }

    struct HiveGemsVestingSchedule has key {
        id: 0x2::object::UID,
        beneficiary: address,
        hive_gems: 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::HiveGems,
        claimed_gems: u64,
        proposed_new_beneficiary: 0x1::option::Option<address>,
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

    public entry fun accept_proposed_new_beneficiary(arg0: &VestingVault, arg1: &mut HiveGemsVestingSchedule, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg1.proposed_new_beneficiary) && 0x2::tx_context::sender(arg2) == arg0.admin_address, 5101);
        arg1.beneficiary = 0x1::option::extract<address>(&mut arg1.proposed_new_beneficiary);
        arg1.proposed_new_beneficiary = 0x1::option::none<address>();
        let v0 = NewBeneficiaryAccepted{
            schedule_id : 0x2::object::uid_to_address(&arg1.id),
            beneficiary : arg1.beneficiary,
        };
        0x2::event::emit<NewBeneficiaryAccepted>(v0);
    }

    public entry fun add_to_vesting_schedule(arg0: &mut VestingVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HiveVault, arg2: &mut HiveGemsVestingSchedule, arg3: 0x2::coin::Coin<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin_address, 5101);
        arg0.available_vested_hive = arg0.available_vested_hive + arg4;
        arg2.release_rate = arg2.release_rate + (0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::mul_div_u256((arg4 as u256), (1000000000 as u256), (arg2.vesting_duration as u256)) as u128);
        let v0 = 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, 0x2::coin::into_balance<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>(arg3), arg4, arg5);
        0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::join(&mut arg2.hive_gems, 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::withdraw_gems_from_profile(&mut arg0.hive_profile, arg4));
        let v1 = AddedToSchedule{
            schedule_id      : 0x2::object::uid_to_address(&arg2.id),
            beneficiary      : arg2.beneficiary,
            hive_added       : arg4,
            new_release_rate : arg2.release_rate,
        };
        0x2::event::emit<AddedToSchedule>(v1);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>(v0, v2, arg5);
    }

    fun calc_releasable_amt(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg1) {
            return 0
        };
        if (arg3 > arg1 + arg2) {
            (0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::mul_div_u256((arg0 as u256), (arg2 as u256), (1000000000 as u256)) as u64)
        } else {
            (0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::mul_div_u256((arg0 as u256), ((arg3 - arg1) as u256), (1000000000 as u256)) as u64)
        }
    }

    public entry fun claim_released_hive_gems(arg0: &0x2::clock::Clock, arg1: &mut VestingVault, arg2: &mut HiveGemsVestingSchedule, arg3: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfile, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.beneficiary, 5102);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg2.unlock_timestamp < v0, 5106);
        assert!(0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::get_profile_owner(arg3) == arg2.beneficiary, 5107);
        let v1 = 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::split(&mut arg2.hive_gems, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::min_u64(calc_releasable_amt(arg2.release_rate, arg2.start_timestamp, arg2.vesting_duration, v0) - arg2.claimed_gems, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&arg2.hive_gems)));
        arg2.claimed_gems = arg2.claimed_gems + 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&v1);
        arg1.available_vested_hive = arg1.available_vested_hive - 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&v1);
        let v2 = 0x2::object::uid_to_inner(&arg2.id);
        let v3 = VestedGemsClaimed{
            schedule_id       : 0x2::object::id_to_address(&v2),
            beneficiary       : arg2.beneficiary,
            hive_gems_claimed : 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&v1),
        };
        0x2::event::emit<VestedGemsClaimed>(v3);
        0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::deposit_gems_in_profile(arg3, v1);
    }

    public entry fun clawback_unvested_gems(arg0: &0x2::clock::Clock, arg1: &VestingVault, arg2: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HiveVault, arg3: &mut HiveGemsVestingSchedule, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 5101);
        assert!(arg3.is_clawback_allowed, 5104);
        assert!(arg4 <= 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&arg3.hive_gems) + arg3.claimed_gems - calc_releasable_amt(arg3.release_rate, arg3.start_timestamp, arg3.vesting_duration, 0x2::clock::timestamp_ms(arg0)), 5103);
        let v0 = 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::split(&mut arg3.hive_gems, arg4);
        arg3.release_rate = arg3.release_rate - (0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::mul_div_u256((arg4 as u256), (1000000000 as u256), (arg3.vesting_duration as u256)) as u128);
        let v1 = 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::deposit_gems_for_hive_and_return(arg2, &mut v0, arg4, arg5);
        0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::destroy_zero(v0);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>(v1, v2, arg5);
        let v3 = GemsClawedBack{
            schedule_id           : 0x2::object::uid_to_address(&arg3.id),
            beneficiary           : arg3.beneficiary,
            hive_gems_clawed_back : arg4,
            new_release_rate      : arg3.release_rate,
        };
        0x2::event::emit<GemsClawedBack>(v3);
    }

    public entry fun create_vesting_vault_obj(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xa802cf597dfc88a5f3408fb2ab4b9bc5e09e9e38f44bc3aec157a419f40e09f8::hsui_vault::HSuiVault, arg2: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfileMappingStore, arg3: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HiveProfileConfig, arg4: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::HSuiDisperser<0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hsui::HSUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::kraft_owned_hive_profile(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::string::utf8(b"VestingVault"), 0, 0, 0, arg7);
        let v2 = VestingVault{
            id                    : 0x2::object::new(arg7),
            admin_address         : arg6,
            hive_profile          : v0,
            available_vested_hive : 0,
        };
        0x2::transfer::share_object<VestingVault>(v2);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v3, arg7);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_released_and_claimable_gems_for_schedule(arg0: &HiveGemsVestingSchedule, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = calc_releasable_amt(arg0.release_rate, arg0.start_timestamp, arg0.vesting_duration, 0x2::clock::timestamp_ms(arg1));
        let v1 = if (arg0.unlock_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::min_u64(v0 - arg0.claimed_gems, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&arg0.hive_gems))
        } else {
            0
        };
        (v0, v1)
    }

    public fun get_vesting_schedule_info(arg0: &HiveGemsVestingSchedule) : (address, u64, u64, u128, u64, u64, u64, bool) {
        (arg0.beneficiary, 0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::hive_gems::value(&arg0.hive_gems), arg0.claimed_gems, arg0.release_rate, arg0.start_timestamp, arg0.unlock_timestamp, arg0.vesting_duration, arg0.is_clawback_allowed)
    }

    public fun get_vesting_vault_info(arg0: &VestingVault) : (address, u64) {
        (arg0.admin_address, arg0.available_vested_hive)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun init_vesting_schedule(arg0: &mut VestingVault, arg1: &mut 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HiveVault, arg2: address, arg3: 0x2::coin::Coin<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.admin_address, 5101);
        assert!(arg6 > 0 && arg7 > arg6 && arg8 > 0, 5105);
        arg0.available_vested_hive = arg0.available_vested_hive + arg4;
        let v0 = 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, 0x2::coin::into_balance<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>(arg3), arg4, arg9);
        let v1 = HiveGemsVestingSchedule{
            id                       : 0x2::object::new(arg9),
            beneficiary              : arg2,
            hive_gems                : 0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive_profile::withdraw_gems_from_profile(&mut arg0.hive_profile, arg4),
            claimed_gems             : 0,
            proposed_new_beneficiary : 0x1::option::none<address>(),
            release_rate             : (0x7134b9780c6c66205f8c5acde6df1cefd93f76fd5e6dbf1981fe5b0b8f7b02eb::math::mul_div_u256((arg4 as u256), (1000000000 as u256), (arg8 as u256)) as u128),
            start_timestamp          : arg6,
            unlock_timestamp         : arg7,
            vesting_duration         : arg8,
            is_clawback_allowed      : arg5,
        };
        let v2 = VestingScheduleKrafted{
            schedule_id         : 0x2::object::uid_to_address(&v1.id),
            beneficiary         : arg2,
            vested_hive_amt     : arg4,
            release_rate        : v1.release_rate,
            start_timestamp     : arg6,
            unlock_timestamp    : arg7,
            vesting_duration    : arg8,
            is_clawback_allowed : arg5,
        };
        0x2::event::emit<VestingScheduleKrafted>(v2);
        0x2::transfer::share_object<HiveGemsVestingSchedule>(v1);
        let v3 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<0xd37ba0794a5f1f78902f71b8cb350be46113ed257361a3e00214256bc8d46af::hive::HIVE>(v0, v3, arg9);
    }

    public entry fun set_proposed_new_beneficiary(arg0: &mut HiveGemsVestingSchedule, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
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

