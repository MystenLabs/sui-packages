module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data {
    struct StakingData has key {
        id: 0x2::object::UID,
        owner: address,
        current_level: u8,
        points: u64,
        current_multiplier: u64,
        ephemeral_multiplier: vector<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>,
        staked_nfts_ids: 0x2::table::Table<0x2::object::ID, bool>,
        last_claimed: u64,
    }

    public(friend) fun add_ephemeral_multiplier_to_staking_data(arg0: &mut StakingData, arg1: u64, arg2: u64, arg3: bool) {
        0x1::vector::push_back<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&mut arg0.ephemeral_multiplier, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::new_ephemeral_multiplier(arg1, arg2, arg3));
    }

    fun calculate_points_for_level(arg0: u8) : u64 {
        if (arg0 == 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_MAX_LEVEL()) {
            return 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_LEVEL_25_POINTS()
        };
        let v0 = (arg0 as u64);
        let v1 = v0 * v0;
        v1 * v1 * 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_LEVEL_25_POINTS() / 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_LEVEL_DENOMINATOR()
    }

    public fun create_and_return_staking_data(arg0: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : StakingData {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg0);
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::can_create_staking_data(arg0, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EStakingDataExists());
        let v0 = new_staking_data(arg1, arg2);
        let v1 = 0x2::object::id<StakingData>(&v0);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::add_staking_data(arg0, arg1, v1);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_data_created(arg1, v1);
        v0
    }

    public fun create_and_share_staking_data(arg0: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        share_staking_data(create_and_return_staking_data(arg0, arg1, arg2));
    }

    public(friend) fun decrease_current_multiplier(arg0: &mut StakingData, arg1: u64) {
        assert!(arg0.current_multiplier >= arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EUnderflow());
        arg0.current_multiplier = arg0.current_multiplier - arg1;
    }

    public(friend) fun decrease_points(arg0: &mut StakingData, arg1: u64) {
        assert!(arg0.points >= arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EUnderflow());
        arg0.points = arg0.points - arg1;
    }

    public(friend) fun get_current_level(arg0: &StakingData) : u8 {
        arg0.current_level
    }

    public(friend) fun get_current_level_mut(arg0: &mut StakingData) : &mut u8 {
        &mut arg0.current_level
    }

    public(friend) fun get_current_multiplier(arg0: &StakingData) : u64 {
        arg0.current_multiplier
    }

    public(friend) fun get_ephemeral_multiplier(arg0: &StakingData) : vector<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier> {
        arg0.ephemeral_multiplier
    }

    public(friend) fun get_last_claimed(arg0: &StakingData) : u64 {
        arg0.last_claimed
    }

    public(friend) fun get_points(arg0: &StakingData) : u64 {
        arg0.points
    }

    public(friend) fun get_staked_nfts_ids_mut(arg0: &mut StakingData) : &mut 0x2::table::Table<0x2::object::ID, bool> {
        &mut arg0.staked_nfts_ids
    }

    public(friend) fun has_enough_points(arg0: &StakingData) : bool {
        arg0.points >= calculate_points_for_level(arg0.current_level + 1)
    }

    public(friend) fun increase_current_multiplier(arg0: &mut StakingData, arg1: u64) {
        assert!(arg0.current_multiplier <= 18446744073709551615 - arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EOverflow());
        arg0.current_multiplier = arg0.current_multiplier + arg1;
    }

    public(friend) fun increase_points(arg0: &mut StakingData, arg1: u64) {
        assert!(arg0.points <= 18446744073709551615 - arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EOverflow());
        arg0.points = arg0.points + arg1;
    }

    public(friend) fun is_in_staking_data(arg0: &StakingData, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.staked_nfts_ids, arg1)
    }

    fun new_staking_data(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : StakingData {
        StakingData{
            id                   : 0x2::object::new(arg1),
            owner                : arg0,
            current_level        : 0,
            points               : 0,
            current_multiplier   : 0,
            ephemeral_multiplier : 0x1::vector::empty<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(),
            staked_nfts_ids      : 0x2::table::new<0x2::object::ID, bool>(arg1),
            last_claimed         : 0,
        }
    }

    public(friend) fun remove_admin_ephemeral_multiplier(arg0: &mut StakingData, arg1: 0x1::option::Option<u64>) {
        let v0 = 0;
        let v1 = 0x1::option::is_none<u64>(&arg1);
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            0x1::option::extract<u64>(&mut arg1)
        } else {
            0
        };
        while (v0 < 0x1::vector::length<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&arg0.ephemeral_multiplier)) {
            let v3 = 0x1::vector::borrow<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&arg0.ephemeral_multiplier, v0);
            if (!0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::get_is_lock_based(v3) && (v1 || 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::get_expiry_time(v3) == v2)) {
                0x1::vector::swap_remove<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&mut arg0.ephemeral_multiplier, v0);
                if (!v1) {
                    return
                } else {
                    continue
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun share_staking_data(arg0: StakingData) {
        0x2::transfer::share_object<StakingData>(arg0);
    }

    public(friend) fun update_points(arg0: &mut StakingData, arg1: u64) {
        let v0 = 0;
        let v1 = arg0.current_multiplier;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&arg0.ephemeral_multiplier)) {
            let v3 = 0x1::vector::borrow<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&arg0.ephemeral_multiplier, v2);
            let v4 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::get_expiry_time(v3);
            let v5 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::get_multiplier(v3);
            if (v4 > arg1) {
                v1 = v1 + v5;
                v2 = v2 + 1;
                continue
            };
            if (v4 > arg0.last_claimed) {
                v0 = v0 + 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EXPERIENCE_FOR_SECOND() * (v4 - arg0.last_claimed) / 1000 * v5;
                0x1::vector::swap_remove<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&mut arg0.ephemeral_multiplier, v2);
                continue
            };
            0x1::vector::swap_remove<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::ephemeral_multiplier::EphemeralMultiplier>(&mut arg0.ephemeral_multiplier, v2);
        };
        assert!(arg1 >= arg0.last_claimed, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EIncorrectTimestamp());
        arg0.points = arg0.points + v0 + 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EXPERIENCE_FOR_SECOND() * (arg1 - arg0.last_claimed) / 1000 * v1;
        arg0.last_claimed = arg1;
    }

    public(friend) fun valid_staking_data(arg0: &StakingData, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

