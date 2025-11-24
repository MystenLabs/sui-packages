module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ADMIN has drop {
        dummy_field: bool,
    }

    public fun activate_pool(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::activate_pool_internal(arg1, arg2, arg3);
    }

    public fun create_pool(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::create_pool_internal(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_airdrop_deposit_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::AirdropPackageCap {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::mint_airdrop_package_cap(arg1)
    }

    public fun pause_contract(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::pause_contract_internal(arg1);
    }

    public fun remove_pool(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::remove_pool_internal(arg1, arg2);
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::set_version(arg1, arg2);
    }

    public fun unpause_contract(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::unpause_contract_internal(arg1);
    }

    public fun update_penalty_rate(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64) {
        assert!(arg2 <= 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::get_basis_points_denominator(), 0);
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::update_penalty_rate_internal(arg1, arg2);
    }

    public fun update_reward_rate(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64, arg3: &0x2::clock::Clock) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::update_reward_rate_internal(arg1, arg2, arg3);
    }

    public fun update_unstaking_delay(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64) {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::update_unstaking_delay_internal(arg1, arg2);
    }

    public fun withdraw_penalty_reserve(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::withdraw_penalty_reserve_internal(arg1, arg2, arg3)
    }

    public fun withdraw_reward_balance(arg0: &AdminCap, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::withdraw_reward_balance_internal(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

