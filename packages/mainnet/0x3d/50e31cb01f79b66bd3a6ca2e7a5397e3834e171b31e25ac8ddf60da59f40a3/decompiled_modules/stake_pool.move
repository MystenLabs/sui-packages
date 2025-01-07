module 0x3d50e31cb01f79b66bd3a6ca2e7a5397e3834e171b31e25ac8ddf60da59f40a3::stake_pool {
    struct StakePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        coin_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        reward_rate: u64,
        total_nfts: u64,
        staked_nfts: u64,
    }

    public fun create_stake_pool<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : StakePool<T0> {
        StakePool<T0>{
            id           : 0x2::object::new(arg7),
            owner        : arg1,
            treasury_cap : arg0,
            coin_type    : 0x1::type_name::get<T0>(),
            name         : 0x1::string::utf8(arg2),
            description  : 0x1::string::utf8(arg3),
            url          : 0x2::url::new_unsafe_from_bytes(arg4),
            reward_rate  : arg5,
            total_nfts   : arg6,
            staked_nfts  : 0,
        }
    }

    public(friend) fun decrement_staked_nfts_<T0>(arg0: &mut StakePool<T0>) {
        arg0.staked_nfts = arg0.staked_nfts - 1;
    }

    public fun id<T0>(arg0: &StakePool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun increment_staked_nfts_<T0>(arg0: &mut StakePool<T0>) {
        arg0.staked_nfts = arg0.staked_nfts + 1;
    }

    public fun is_owner<T0>(arg0: &StakePool<T0>, arg1: address) : bool {
        arg0.owner != arg1
    }

    public fun owner<T0>(arg0: &StakePool<T0>) : address {
        arg0.owner
    }

    public fun reward_rate<T0>(arg0: &StakePool<T0>) : u64 {
        arg0.reward_rate
    }

    public fun staked_nfts<T0>(arg0: &StakePool<T0>) : u64 {
        arg0.staked_nfts
    }

    public fun total_nfts<T0>(arg0: &StakePool<T0>) : u64 {
        arg0.total_nfts
    }

    public(friend) fun treasury_cap_<T0>(arg0: &mut StakePool<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    // decompiled from Move bytecode v6
}

