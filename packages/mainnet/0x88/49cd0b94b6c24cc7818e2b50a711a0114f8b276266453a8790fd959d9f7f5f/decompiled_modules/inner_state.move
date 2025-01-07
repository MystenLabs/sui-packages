module 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::inner_state {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State has store {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        whitelisted_validators: 0x2::vec_set::VecSet<address>,
        staked_validators: 0x2::linked_table::LinkedTable<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>,
        rst_cap: 0x2::coin::TreasuryCap<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>,
        deposit_queue: 0x2::coin::Coin<0x2::sui::SUI>,
        rivus_shares: 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::Fund,
        total_fees_claimed: u64,
        total_staked: u64,
        last_epoch: u64,
        activated_staked_sui: u64,
        version: u64,
    }

    struct VersionedState has store {
        inner: 0x2::versioned::Versioned,
    }

    public(friend) fun add_validator(arg0: &mut VersionedState, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_mut(arg0, arg3);
        internal_add_validator(v0, arg1, arg2, v1);
    }

    fun borrow_mut_validator(arg0: &mut State, arg1: address) : &mut 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator {
        0x2::linked_table::borrow_mut<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&mut arg0.staked_validators, arg1)
    }

    fun borrow_validator(arg0: &State, arg1: address) : &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator {
        0x2::linked_table::borrow<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg0.staked_validators, arg1)
    }

    public(friend) fun burn_rst(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VersionedState, arg2: 0x2::coin::Coin<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_mut(arg1, arg3);
        internal_burn_rst(arg0, v0, arg2, v1);
    }

    public(friend) fun claim_protocol_fees(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VersionedState, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_mut(arg1, arg3);
        update_pool(arg0, v0, 0x2::tx_context::epoch(v1));
        claim_rewards(arg0, v0, arg2, v1);
    }

    fun claim_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut State, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        let v1 = *0x2::linked_table::front<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg1.staked_validators);
        let v2 = 0;
        while (0x1::option::is_some<address>(&v1)) {
            let v3 = *0x1::option::borrow<address>(&v1);
            let v4 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::protocol_fees_to_claim(0x2::linked_table::borrow<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg1.staked_validators, v3));
            if (v4 > 0) {
                let v5 = compute_unstake_payload(arg1, v4, arg3, 0x1::option::some<address>(v3));
                if (0x1::vector::length<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>(&v5) == 1) {
                    let (v6, v7) = remove_staked_sui(arg0, arg1, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::total_sui_to_unstake(0x1::vector::borrow<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>(&v5, 0)), true, v5, arg3);
                    let v8 = v6;
                    0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::set_last_total_rewards_claimed(0x2::linked_table::borrow_mut<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&mut arg1.staked_validators, v3));
                    v2 = v2 + 0x2::coin::value<0x2::sui::SUI>(&v8);
                    0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_validator_protocol_fees_claimed(v3, 0x2::coin::value<0x2::sui::SUI>(&v8));
                    0x2::coin::join<0x2::sui::SUI>(&mut v0, v8);
                    assert!(v7 == 0, 6);
                };
            };
            v1 = *0x2::linked_table::next<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg1.staked_validators, v3);
        };
        arg1.total_fees_claimed = arg1.total_fees_claimed + 0x2::coin::value<0x2::sui::SUI>(&v0);
        arg1.total_staked = arg1.total_staked - v2;
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_protocol_fees_claimed(0x2::coin::value<0x2::sui::SUI>(&v0), arg1.total_staked);
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::sub_underlying(&mut arg1.rivus_shares, v2, false);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun compute_unstake_payload(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext, arg3: 0x1::option::Option<address>) : vector<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>();
        let v2 = *0x2::linked_table::front<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg0.staked_validators);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            if (0x1::option::is_some<address>(&arg3)) {
                if (*0x1::option::borrow<address>(&arg3) != v3) {
                    v2 = *0x2::linked_table::next<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg0.staked_validators, v3);
                    continue
                };
            };
            let v4 = borrow_validator(arg0, v3);
            let v5 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_staked_suis(v4);
            let v6 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::make_empty_payload(v3);
            if (0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::total_staked(v4) > 0) {
                let v7 = *0x2::linked_table::front<u64, 0x3::staking_pool::StakedSui>(v5);
                while (0x1::option::is_some<u64>(&v7)) {
                    let v8 = *0x1::option::borrow<u64>(&v7);
                    if (0x2::tx_context::epoch(arg2) >= v8) {
                        let v9 = 0x3::staking_pool::staked_sui_amount(0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(v5, v8));
                        let v10 = arg1 - v0;
                        if (v9 >= v10 + 1000000000) {
                            v0 = v0 + v10;
                            0x1::vector::push_back<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakeInfo>(0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::borrow_mut_unstakes(&mut v6), 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::make_unstake_info(v8, v10));
                        } else {
                            v0 = v0 + v9;
                            0x1::vector::push_back<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakeInfo>(0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::borrow_mut_unstakes(&mut v6), 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::make_unstake_info(v8, v9));
                        };
                    };
                    if (v0 >= arg1) {
                        break
                    };
                    v7 = *0x2::linked_table::next<u64, 0x3::staking_pool::StakedSui>(v5, v8);
                };
            };
            0x1::vector::push_back<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>(&mut v1, v6);
            if (v0 >= arg1) {
                break
            };
            v2 = *0x2::linked_table::next<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg0.staked_validators, v3);
        };
        v1
    }

    fun create_state(arg0: 0x2::coin::TreasuryCap<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                     : 0x2::object::new(arg2),
            admin_cap_id           : 0x2::object::id<AdminCap>(arg1),
            whitelisted_validators : 0x2::vec_set::empty<address>(),
            staked_validators      : 0x2::linked_table::new<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(arg2),
            rst_cap                : arg0,
            deposit_queue          : 0x2::coin::zero<0x2::sui::SUI>(arg2),
            rivus_shares           : 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::empty(),
            total_fees_claimed     : 0,
            total_staked           : 0,
            last_epoch             : 0,
            activated_staked_sui   : 0,
            version                : 1,
        }
    }

    public(friend) fun create_versioned_state(arg0: 0x2::coin::TreasuryCap<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : VersionedState {
        let v0 = create_state(arg0, arg1, arg2);
        VersionedState{inner: 0x2::versioned::create<State>(1, v0, arg2)}
    }

    public(friend) fun deposit_to_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VersionedState, arg2: &AdminCap, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_mut(arg1, arg5);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut v0.deposit_queue, arg4, v1);
        update_pool(arg0, v0, 0x2::tx_context::epoch(v1));
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg0, v2, arg3, v1);
        let v4 = 0x3::staking_pool::staked_sui_amount(&v3);
        let v5 = borrow_mut_validator(v0, arg3);
        persist_staked_sui(v5, v3);
        let v6 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_mut_total_staked(v5);
        *v6 = *v6 + v4;
        v0.total_staked = v0.total_staked + v4;
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_validator_staked(arg3, arg4, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::total_staked(borrow_validator(v0, arg3)), v0.total_staked);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun internal_add_validator(arg0: &mut State, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.whitelisted_validators, arg2);
        0x2::linked_table::push_back<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&mut arg0.staked_validators, arg2, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::create_validator(arg2, arg3));
    }

    fun internal_burn_rst(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut State, arg2: 0x2::coin::Coin<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>, arg3: &mut 0x2::tx_context::TxContext) {
        update_pool(arg0, arg1, 0x2::tx_context::epoch(arg3));
        let v0 = 0x2::coin::burn<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>(&mut arg1.rst_cap, arg2);
        let v1 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::sub_shares(&mut arg1.rivus_shares, v0, false);
        assert!(v1 >= 1000000000, 8);
        let v2 = compute_unstake_payload(arg1, v1, arg3, 0x1::option::none<address>());
        let (v3, v4) = remove_staked_sui(arg0, arg1, v1, false, v2, arg3);
        let v5 = v3;
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_withdraw(0x2::tx_context::sender(arg3), 0x2::coin::value<0x2::sui::SUI>(&v5), arg1.total_staked, v0 - v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg3));
    }

    fun internal_mint_rst(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut State, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        update_pool(arg0, arg1, 0x2::tx_context::epoch(arg3));
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 1000000000, 7);
        let v1 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::add_underlying(&mut arg1.rivus_shares, v0, false);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.deposit_queue, arg2);
        0x2::coin::mint_and_transfer<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::rst::RST>(&mut arg1.rst_cap, v1, 0x2::tx_context::sender(arg3), arg3);
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_deposit(0x2::tx_context::sender(arg3), v0, v1, 0x2::coin::value<0x2::sui::SUI>(&arg1.deposit_queue), 0x2::coin::value<0x2::sui::SUI>(&arg1.deposit_queue));
    }

    fun load(arg0: &mut VersionedState, arg1: &mut 0x2::tx_context::TxContext) : (&State, &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_maybe_upgrade(arg0, arg1);
        (v0, v1)
    }

    fun load_maybe_upgrade(arg0: &mut VersionedState, arg1: &mut 0x2::tx_context::TxContext) : (&mut State, &mut 0x2::tx_context::TxContext) {
        upgrade_to_latest(arg0, arg1);
        (0x2::versioned::load_value_mut<State>(&mut arg0.inner), arg1)
    }

    fun load_mut(arg0: &mut VersionedState, arg1: &mut 0x2::tx_context::TxContext) : (&mut State, &mut 0x2::tx_context::TxContext) {
        load_maybe_upgrade(arg0, arg1)
    }

    public(friend) fun mint_rst(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut VersionedState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = load_mut(arg1, arg3);
        internal_mint_rst(arg0, v0, arg2, v1);
    }

    public fun module_version() : u64 {
        1
    }

    fun persist_staked_sui(arg0: &mut 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator, arg1: 0x3::staking_pool::StakedSui) {
        let v0 = 0x3::staking_pool::stake_activation_epoch(&arg1);
        let v1 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_mut_staked_suis(arg0);
        if (0x2::linked_table::contains<u64, 0x3::staking_pool::StakedSui>(v1, v0)) {
            0x3::staking_pool::join_staked_sui(0x2::linked_table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(v1, v0), arg1);
        } else {
            0x2::linked_table::push_back<u64, 0x3::staking_pool::StakedSui>(v1, v0, arg1);
        };
    }

    public fun read_admin_cap_id(arg0: &State) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun read_staked_validator(arg0: &State, arg1: address) : &0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator {
        borrow_validator(arg0, arg1)
    }

    public fun read_staked_validators(arg0: &State) : &0x2::linked_table::LinkedTable<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator> {
        &arg0.staked_validators
    }

    public fun read_total_staked(arg0: &State) : u64 {
        arg0.total_staked
    }

    public fun read_version(arg0: &State) : u64 {
        arg0.version
    }

    public fun read_whitelisted_validators(arg0: &State) : &0x2::vec_set::VecSet<address> {
        &arg0.whitelisted_validators
    }

    fun remove_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut State, arg2: u64, arg3: bool, arg4: vector<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg5);
        let v1 = 0;
        while (0x1::vector::length<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>(&arg4) > v1) {
            let v2 = 0x1::vector::borrow<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakePayload>(&arg4, v1);
            let v3 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::load_validator(v2);
            let v4 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::load_unstakes(v2);
            let v5 = borrow_mut_validator(arg1, v3);
            let v6 = 0;
            while (0x1::vector::length<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakeInfo>(v4) > v6) {
                let v7 = 0x1::vector::borrow<0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::UnstakeInfo>(v4, v6);
                let v8 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::load_unstake_info_epoch(v7);
                let v9 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::unstake_utils::load_unstake_info_amount(v7);
                let v10 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_mut_staked_suis(v5);
                let v11 = 0x2::linked_table::remove<u64, 0x3::staking_pool::StakedSui>(v10, v8);
                let v12 = 0x3::staking_pool::staked_sui_amount(&v11);
                let v13 = if (v12 > v9) {
                    0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, 0x3::staking_pool::split(&mut v11, v9, arg5), arg5), arg5));
                    0x2::linked_table::push_back<u64, 0x3::staking_pool::StakedSui>(v10, v8, v11);
                    v9
                } else {
                    let v13 = if (v12 < v9) {
                        v9 - v12
                    } else {
                        v9
                    };
                    0x2::coin::join<0x2::sui::SUI>(&mut v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, v11, arg5), arg5));
                    v13
                };
                let v14 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_mut_total_staked(v5);
                *v14 = *v14 - v13;
                0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_sui_removed(v3, v8, v13, *v14, *v14);
                v6 = v6 + 1;
            };
            v1 = v1 + 1;
        };
        let v15 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v15 > 0, 2);
        arg1.total_staked = arg1.total_staked - v15;
        if (arg3 == false) {
            if (arg2 > v15 && arg3 == false) {
                let v16 = arg2 - v15;
                0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::add_underlying(&mut arg1.rivus_shares, v16, false);
                0x2::coin::join<0x2::sui::SUI>(&mut arg1.deposit_queue, 0x2::coin::split<0x2::sui::SUI>(&mut v0, v16, arg5));
            } else if (arg2 < v15) {
                let v17 = v15 - arg2;
                0x2::coin::join<0x2::sui::SUI>(&mut arg1.deposit_queue, 0x2::coin::split<0x2::sui::SUI>(&mut v0, v17, arg5));
                0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_excess_unstake(v15, arg2, v17);
            };
        };
        (v0, 0)
    }

    fun update_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut State, arg2: u64) {
        if (arg2 == arg1.last_epoch || 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::shares(&arg1.rivus_shares) == 0) {
            return
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = *0x2::linked_table::front<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg1.staked_validators);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            let v4 = 0x2::linked_table::borrow_mut<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&mut arg1.staked_validators, v3);
            if (0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::total_staked(v4) > 0) {
                let v5 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::stake_pool_id(v4);
                let v6 = 0x3::sui_system::pool_exchange_rates(arg0, &v5);
                let v7 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::stake_utils::get_latest_exchange_rate(v6, arg2);
                let v8 = 0;
                let v9 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::borrow_staked_suis(v4);
                let v10 = *0x2::linked_table::front<u64, 0x3::staking_pool::StakedSui>(v9);
                while (0x1::option::is_some<u64>(&v10)) {
                    let v11 = *0x1::option::borrow<u64>(&v10);
                    let v12 = 0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(v9, v11);
                    if (arg2 >= v11) {
                        let v13 = 0x3::staking_pool::staked_sui_amount(v12);
                        let v14 = 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::stake_utils::calculate_staking_pool_rewards(0x2::table::borrow<u64, 0x3::staking_pool::PoolTokenExchangeRate>(v6, v11), v7, v13);
                        v0 = v0 + v14;
                        v1 = v1 + v13;
                        v8 = v8 + v14;
                    };
                    v10 = *0x2::linked_table::next<u64, 0x3::staking_pool::StakedSui>(v9, v11);
                };
                0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::update_total_rewards(v4, v8);
            };
            v2 = *0x2::linked_table::next<address, 0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::validator::Validator>(&arg1.staked_validators, v3);
        };
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::shares::add_profit(&mut arg1.rivus_shares, v0);
        arg1.last_epoch = arg2;
        arg1.activated_staked_sui = v1;
        0x8849cd0b94b6c24cc7818e2b50a711a0114f8b276266453a8790fd959d9f7f5f::events::emit_pool_update(arg1.last_epoch, arg1.activated_staked_sui, arg1.last_epoch, arg1.activated_staked_sui, v0);
    }

    fun upgrade_to_latest(arg0: &mut VersionedState, arg1: &mut 0x2::tx_context::TxContext) : &mut 0x2::tx_context::TxContext {
        let v0 = 0x2::versioned::version(&arg0.inner);
        if (v0 < 1) {
            let (v1, v2) = 0x2::versioned::remove_value_for_upgrade<State>(&mut arg0.inner);
            let v3 = v1;
            v3.version = 1;
            0x2::versioned::upgrade<State>(&mut arg0.inner, 1, v3, v2);
        };
        assert!(0x2::versioned::version(&arg0.inner) == 1, 5);
        arg1
    }

    // decompiled from Move bytecode v6
}

