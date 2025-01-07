module 0x74c36f12e546391e678866268d5cae0609c36a1342af2f66f213dee0de7ec0d8::vesting {
    struct VestingAdminCapability has key {
        id: 0x2::object::UID,
    }

    struct VestingVault has key {
        id: 0x2::object::UID,
        vote_capability: 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::yield_flow::VoteByVestedTokensCapability,
        hive_available: 0x2::balance::Balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>,
        honey_available: 0x2::balance::Balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>,
        sum_hive_vested: u64,
        sum_honey_vested: u64,
        hive_to_vest: u64,
        honey_to_vest: u64,
        hive_claimed: u64,
        honey_claimed: u64,
        module_version: u64,
    }

    struct VestingSchedule has key {
        id: 0x2::object::UID,
        beneficiary: address,
        proposed_new_beneficiary: 0x1::option::Option<address>,
        available_hive: 0x2::balance::Balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>,
        available_honey: 0x2::balance::Balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>,
        total_vested_hive_amt: u64,
        total_vested_honey_amt: u64,
        claimed_hive_amt: u64,
        claimed_honey_amt: u64,
        hive_release_rate: u128,
        honey_release_rate: u128,
        start_timestamp: u64,
        unlock_timestamp: u64,
        vesting_duration: u64,
        is_clawback_allowed: bool,
        module_version: u64,
    }

    struct VestingScheduleKrafted has copy, drop {
        schedule_id: address,
        beneficiary: address,
        vested_hive_amt: u64,
        hive_release_rate: u128,
        vested_honey_amt: u64,
        honey_release_rate: u128,
        start_timestamp: u64,
        unlock_timestamp: u64,
        vesting_duration: u64,
        is_clawback_allowed: bool,
    }

    struct AddedToSchedule has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_added: u64,
        new_hive_release_rate: u128,
        honey_added: u64,
        new_honey_release_rate: u128,
    }

    struct ClawedBack has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_clawed_back: u64,
        honey_clawed_back: u64,
        new_hive_release_rate: u128,
        new_honey_release_rate: u128,
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

    struct TokensClaimed has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_claimed: u64,
        honey_claimed: u64,
    }

    struct VotedWithVestedHive has copy, drop {
        schedule_id: address,
        beneficiary: address,
        hive_used: u64,
        proposal_id: u64,
        latest_vote: bool,
    }

    public fun kraft_genesis_honey(arg0: &mut VestingVault, arg1: &mut 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::DragonFood, arg2: 0x2::coin::TreasuryCap<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg3: &mut 0xdb5668d80a93faa9388ed5ef7318a7823e3af34ee50dc429cf99f4f813c87b40::dragon_trainer::BeesManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x236975aabfc94edd50ea018f4326c023680d5daf357baa5da3ae4f87321f53df::dragon_food::kraft_genesis_honey(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&v0);
        0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg0.honey_available, v0);
        arg0.sum_honey_vested = arg0.sum_honey_vested + v1;
        arg0.honey_to_vest = arg0.honey_to_vest + v1;
    }

    public entry fun accept_proposed_new_beneficiary(arg0: &VestingAdminCapability, arg1: &mut VestingSchedule, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5110);
        assert!(0x1::option::is_some<address>(&arg1.proposed_new_beneficiary), 5102);
        arg1.beneficiary = 0x1::option::extract<address>(&mut arg1.proposed_new_beneficiary);
        arg1.proposed_new_beneficiary = 0x1::option::none<address>();
        let v0 = NewBeneficiaryAccepted{
            schedule_id : 0x2::object::uid_to_address(&arg1.id),
            beneficiary : arg1.beneficiary,
        };
        0x2::event::emit<NewBeneficiaryAccepted>(v0);
    }

    public entry fun add_hive_for_vesting(arg0: &mut VestingVault, arg1: &VestingAdminCapability, arg2: 0x2::coin::Coin<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(arg2);
        0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg0.hive_available, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut v0, arg3));
        arg0.sum_hive_vested = arg0.sum_hive_vested + arg3;
        arg0.hive_to_vest = arg0.hive_to_vest + arg3;
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun add_to_vesting_schedule(arg0: &0x2::clock::Clock, arg1: &VestingAdminCapability, arg2: &mut VestingVault, arg3: &mut VestingSchedule, arg4: u64, arg5: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg3.start_timestamp + arg3.vesting_duration, 5108);
        assert!(arg4 > 0, 5109);
        arg2.hive_to_vest = arg2.hive_to_vest - arg4;
        arg2.honey_to_vest = arg2.honey_to_vest - arg5;
        0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg3.available_hive, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg2.hive_available, arg4));
        arg3.hive_release_rate = (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&arg3.available_hive) as u256), (1000000000 as u256), (arg3.vesting_duration as u256)) as u128);
        arg3.total_vested_hive_amt = arg3.total_vested_hive_amt + arg4;
        0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg3.available_honey, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg2.honey_available, arg5));
        arg3.honey_release_rate = (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&arg3.available_honey) as u256), (1000000000 as u256), (arg3.vesting_duration as u256)) as u128);
        arg3.total_vested_honey_amt = arg3.total_vested_honey_amt + arg5;
        let v0 = AddedToSchedule{
            schedule_id            : 0x2::object::uid_to_address(&arg3.id),
            beneficiary            : arg3.beneficiary,
            hive_added             : arg4,
            new_hive_release_rate  : arg3.hive_release_rate,
            honey_added            : arg5,
            new_honey_release_rate : arg3.honey_release_rate,
        };
        0x2::event::emit<AddedToSchedule>(v0);
    }

    fun calc_vested_amt(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 < arg1) {
            return 0
        };
        if (arg3 > arg1 + arg2) {
            (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((arg0 as u256), (arg2 as u256), (1000000000 as u256)) as u64)
        } else {
            (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((arg0 as u256), ((arg3 - arg1) as u256), (1000000000 as u256)) as u64)
        }
    }

    public entry fun claim_released_tokens(arg0: &0x2::clock::Clock, arg1: &mut VestingVault, arg2: &0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::honey_trade::HoneyManager<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg3: &mut VestingSchedule, arg4: &mut 0x2::token::TokenPolicy<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0, 5110);
        assert!(0x2::tx_context::sender(arg5) == arg3.beneficiary, 5102);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0;
        let v2 = 0;
        if (v0 > arg3.unlock_timestamp) {
            let v3 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::min_u64(calc_vested_amt(arg3.hive_release_rate, arg3.start_timestamp, arg3.vesting_duration, v0) - arg3.claimed_hive_amt, 0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&arg3.available_hive));
            v1 = v3;
            0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::coin_helper::destroy_or_transfer_balance<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg3.available_hive, v3), arg3.beneficiary, arg5);
            let v4 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::min_u64(calc_vested_amt(arg3.honey_release_rate, arg3.start_timestamp, arg3.vesting_duration, v0) - arg3.claimed_honey_amt, 0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&arg3.available_honey));
            v2 = v4;
            0x6f6c10f87906cd84d39f1e52abb6eae13a4ed1f07ee3981511892b17af506f87::honey_trade::transfer_honey_balance(arg4, arg2, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg3.available_honey, v4), arg3.beneficiary, arg5);
            arg3.claimed_hive_amt = arg3.claimed_hive_amt + v3;
            arg3.claimed_honey_amt = arg3.claimed_honey_amt + v4;
        };
        arg1.hive_claimed = arg1.hive_claimed + v1;
        let v5 = 0x2::object::uid_to_inner(&arg3.id);
        let v6 = TokensClaimed{
            schedule_id   : 0x2::object::id_to_address(&v5),
            beneficiary   : arg3.beneficiary,
            hive_claimed  : v1,
            honey_claimed : v2,
        };
        0x2::event::emit<TokensClaimed>(v6);
    }

    public entry fun clawback_unvested_gems(arg0: &0x2::clock::Clock, arg1: &VestingAdminCapability, arg2: &mut VestingVault, arg3: &mut VestingSchedule, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg3.is_clawback_allowed, 5104);
        assert!(arg2.module_version == 0 && arg3.module_version == 0, 5110);
        if (arg4 > 0) {
            assert!(arg4 <= arg3.total_vested_hive_amt - calc_vested_amt(arg3.hive_release_rate, arg3.start_timestamp, arg3.vesting_duration, 0x2::clock::timestamp_ms(arg0)), 5103);
            arg3.hive_release_rate = (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&arg3.available_hive) as u256), (1000000000 as u256), (arg3.vesting_duration as u256)) as u128);
            arg3.total_vested_hive_amt = arg3.total_vested_hive_amt - arg4;
            arg2.hive_to_vest = arg2.hive_to_vest + arg4;
            0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg2.hive_available, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg3.available_hive, arg4));
        };
        if (arg5 > 0) {
            assert!(arg5 <= arg3.total_vested_honey_amt - calc_vested_amt(arg3.honey_release_rate, arg3.start_timestamp, arg3.vesting_duration, 0x2::clock::timestamp_ms(arg0)), 5103);
            arg3.honey_release_rate = (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&arg3.available_honey) as u256), (1000000000 as u256), (arg3.vesting_duration as u256)) as u128);
            arg3.total_vested_honey_amt = arg3.total_vested_honey_amt - arg5;
            arg2.honey_to_vest = arg2.honey_to_vest + arg5;
            0x2::balance::join<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg2.honey_available, 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg3.available_honey, arg5));
        };
        let v0 = ClawedBack{
            schedule_id            : 0x2::object::uid_to_address(&arg3.id),
            beneficiary            : arg3.beneficiary,
            hive_clawed_back       : arg4,
            honey_clawed_back      : arg5,
            new_hive_release_rate  : arg3.hive_release_rate,
            new_honey_release_rate : arg3.honey_release_rate,
        };
        0x2::event::emit<ClawedBack>(v0);
    }

    public fun get_released_and_claimable_hive_for_schedule(arg0: &VestingSchedule, arg1: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        let v0 = calc_vested_amt(arg0.hive_release_rate, arg0.start_timestamp, arg0.vesting_duration, 0x2::clock::timestamp_ms(arg1));
        let v1 = calc_vested_amt(arg0.honey_release_rate, arg0.start_timestamp, arg0.vesting_duration, 0x2::clock::timestamp_ms(arg1));
        let (v2, v3) = if (arg0.unlock_timestamp < 0x2::clock::timestamp_ms(arg1)) {
            (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::min_u64(v0 - arg0.claimed_hive_amt, 0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&arg0.available_hive)), 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::min_u64(v1 - arg0.claimed_honey_amt, 0x2::balance::value<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&arg0.available_honey)))
        } else {
            (0, 0)
        };
        (v0, v2, v1, v3)
    }

    public entry fun increment_schedule(arg0: &mut VestingSchedule) {
        assert!(arg0.module_version < 0, 5111);
        arg0.module_version = 0;
    }

    public entry fun increment_vault(arg0: &mut VestingVault) {
        assert!(arg0.module_version < 0, 5111);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingAdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VestingAdminCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_vesting_schedule(arg0: &0x2::clock::Clock, arg1: &mut VestingVault, arg2: &VestingAdminCapability, arg3: address, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        assert!(arg7 > 0 && arg9 > 0, 5105);
        arg1.hive_to_vest = arg1.hive_to_vest - arg4;
        let v0 = VestingSchedule{
            id                       : 0x2::object::new(arg10),
            beneficiary              : arg3,
            proposed_new_beneficiary : 0x1::option::none<address>(),
            available_hive           : 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(&mut arg1.hive_available, arg4),
            available_honey          : 0x2::balance::split<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(&mut arg1.honey_available, arg5),
            total_vested_hive_amt    : arg4,
            total_vested_honey_amt   : arg5,
            claimed_hive_amt         : 0,
            claimed_honey_amt        : 0,
            hive_release_rate        : (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((arg4 as u256), (1000000000 as u256), (arg9 as u256)) as u128),
            honey_release_rate       : (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u256((arg5 as u256), (1000000000 as u256), (arg9 as u256)) as u128),
            start_timestamp          : arg7,
            unlock_timestamp         : arg8,
            vesting_duration         : arg9,
            is_clawback_allowed      : arg6,
            module_version           : 0,
        };
        let v1 = VestingScheduleKrafted{
            schedule_id         : 0x2::object::uid_to_address(&v0.id),
            beneficiary         : arg3,
            vested_hive_amt     : arg4,
            hive_release_rate   : v0.hive_release_rate,
            vested_honey_amt    : arg5,
            honey_release_rate  : v0.honey_release_rate,
            start_timestamp     : arg7,
            unlock_timestamp    : arg8,
            vesting_duration    : arg9,
            is_clawback_allowed : arg6,
        };
        0x2::event::emit<VestingScheduleKrafted>(v1);
        0x2::transfer::share_object<VestingSchedule>(v0);
    }

    public entry fun kraft_vesting_vault_obj(arg0: 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::yield_flow::VoteByVestedTokensCapability, arg1: &VestingAdminCapability, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingVault{
            id               : 0x2::object::new(arg2),
            vote_capability  : arg0,
            hive_available   : 0x2::balance::zero<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::hive::HIVE>(),
            honey_available  : 0x2::balance::zero<0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey::HONEY>(),
            sum_hive_vested  : 0,
            sum_honey_vested : 0,
            hive_to_vest     : 0,
            honey_to_vest    : 0,
            hive_claimed     : 0,
            honey_claimed    : 0,
            module_version   : 0,
        };
        0x2::transfer::share_object<VestingVault>(v0);
    }

    public entry fun set_proposed_new_beneficiary(arg0: &mut VestingSchedule, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 5110);
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

