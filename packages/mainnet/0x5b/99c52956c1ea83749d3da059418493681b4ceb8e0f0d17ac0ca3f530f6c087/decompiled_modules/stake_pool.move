module 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool {
    struct StakePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        nft_type: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        reward_rate: u64,
        total_nfts: u64,
        staked_nfts: u64,
        mysten: bool,
    }

    struct TreasuryCapDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun create_stake_pool<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x1::type_name::TypeName, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : StakePool<T0> {
        let v0 = StakePool<T0>{
            id          : 0x2::object::new(arg9),
            version     : arg8,
            owner       : arg2,
            nft_type    : arg1,
            coin_type   : 0x1::type_name::get<T0>(),
            name        : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            url         : 0x2::url::new_unsafe_from_bytes(arg5),
            reward_rate : arg6,
            total_nfts  : arg7,
            staked_nfts : 0,
            mysten      : true,
        };
        let v1 = TreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapDfKey, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, v1, arg0);
        v0
    }

    public(friend) fun deactivate_stake_pool<T0>(arg0: &mut StakePool<T0>) : 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_object_field::remove<TreasuryCapDfKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun decrement_staked_nfts_<T0>(arg0: &mut StakePool<T0>) {
        arg0.staked_nfts = arg0.staked_nfts - 1;
    }

    public fun description<T0>(arg0: &StakePool<T0>) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun edit_stake_pool<T0>(arg0: &mut StakePool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64) {
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg3);
        arg0.reward_rate = arg4;
        arg0.total_nfts = arg5;
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

    public fun name<T0>(arg0: &StakePool<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun nft_type<T0>(arg0: &StakePool<T0>) : 0x1::type_name::TypeName {
        arg0.nft_type
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
        let v0 = TreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapDfKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public fun uid<T0>(arg0: &StakePool<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun version<T0>(arg0: &StakePool<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

