module 0x903fac2c15cce6f4a042a0a212542c6b119fb24749a96721861d3d56b724823c::flux_minter {
    struct FluxMinterCap has store, key {
        id: 0x2::object::UID,
        authorized_pools: 0x2::vec_set::VecSet<address>,
    }

    struct PoolAuthorized has copy, drop {
        pool_id: address,
        minter_cap_id: address,
    }

    struct PoolUnauthorized has copy, drop {
        pool_id: address,
        minter_cap_id: address,
    }

    struct TokensMinted has copy, drop {
        minter: address,
        recipient: address,
        amount: u64,
    }

    public entry fun authorize_pool(arg0: &mut FluxMinterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized_pools, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.authorized_pools, arg1);
        let v0 = PoolAuthorized{
            pool_id       : arg1,
            minter_cap_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<PoolAuthorized>(v0);
    }

    public entry fun init_flux_minter(arg0: &0x903fac2c15cce6f4a042a0a212542c6b119fb24749a96721861d3d56b724823c::nft_staking::AdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FluxMinterCap{
            id               : 0x2::object::new(arg2),
            authorized_pools : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::public_transfer<FluxMinterCap>(v0, 0x2::tx_context::sender(arg2));
    }

    fun is_flux_token_type(arg0: 0x1::type_name::TypeName) : bool {
        true
    }

    public fun is_pool_authorized(arg0: &FluxMinterCap, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_pools, &arg1)
    }

    public entry fun mint_flux_for_reward_pool<T0>(arg0: &FluxMinterCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &0x903fac2c15cce6f4a042a0a212542c6b119fb24749a96721861d3d56b724823c::nft_staking::StakingConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<0x903fac2c15cce6f4a042a0a212542c6b119fb24749a96721861d3d56b724823c::nft_staking::StakingConfig>(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_pools, &v0), 1);
        assert!(is_flux_token_type(0x1::type_name::get<T0>()), 3);
        assert!(arg3 > 0, 4);
        let v1 = TokensMinted{
            minter    : 0x2::tx_context::sender(arg4),
            recipient : v0,
            amount    : arg3,
        };
        0x2::event::emit<TokensMinted>(v1);
    }

    public entry fun unauthorize_pool(arg0: &mut FluxMinterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<address>(&arg0.authorized_pools, &arg1), 1);
        0x2::vec_set::remove<address>(&mut arg0.authorized_pools, &arg1);
        let v0 = PoolUnauthorized{
            pool_id       : arg1,
            minter_cap_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<PoolUnauthorized>(v0);
    }

    // decompiled from Move bytecode v6
}

