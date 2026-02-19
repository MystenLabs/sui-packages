module 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::state {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionStateV1 has store, key {
        id: 0x2::object::UID,
        storage: 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::StakedSuiStorage,
        deposit_into_extension_validator_preference: address,
        deposits_enabled: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ExtensionStateV1 {
        ExtensionStateV1{
            id                                          : 0x2::object::new(arg0),
            storage                                     : 0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::new(arg0),
            deposit_into_extension_validator_preference : @0xd30018ec3f5ff1a3c75656abf927a87d7f0529e6dc89c7ddd1bd27ecb05e3db2,
            deposits_enabled                            : true,
        }
    }

    public(friend) fun convert_staked_sui_to_fungible_staked_sui_for_pool_id(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::convert_staked_sui_to_fungible_staked_sui_for_pool_id(&mut arg0.storage, arg1, arg2, arg3);
    }

    public(friend) fun create_extension_key() : ExtensionKey {
        ExtensionKey{dummy_field: false}
    }

    public(friend) fun deposit_into_extension(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_enabled, 13835059086074314753);
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::join(&mut arg0.storage, arg1, 0x3::sui_system::request_add_stake_non_entry(arg1, arg2, arg3, arg4), arg4);
    }

    public(friend) fun deposit_into_extension_validator_preference(arg0: &ExtensionStateV1) : address {
        arg0.deposit_into_extension_validator_preference
    }

    public(friend) fun destroy(arg0: ExtensionStateV1) {
        let ExtensionStateV1 {
            id                                          : v0,
            storage                                     : v1,
            deposit_into_extension_validator_preference : _,
            deposits_enabled                            : _,
        } = arg0;
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::destroy_empty(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun disable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = false;
    }

    public(friend) fun enable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = true;
    }

    public(friend) fun idle_liquidity(arg0: &ExtensionStateV1) : u64 {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::idle_liquidity(&arg0.storage)
    }

    public(friend) fun pool_ids(arg0: &ExtensionStateV1) : vector<0x2::object::ID> {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::pool_ids(&arg0.storage)
    }

    public(friend) fun rebalance_stake(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::rebalance_stake(&mut arg0.storage, arg1, arg2, arg3);
    }

    public(friend) fun set_deposit_into_extension_validator_preference(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address) {
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &arg2) {
                v3 = true;
                /* label 6 */
                assert!(v3, 13835340303353118723);
                arg0.deposit_into_extension_validator_preference = arg2;
                return
            };
            v2 = v2 + 1;
        };
        v3 = false;
        /* goto 6 */
    }

    public(friend) fun stake_idle_liquidity(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::stake_idle_liquidity(&mut arg0.storage, arg1, arg2, arg3, arg4);
    }

    public(friend) fun take_profit(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg2 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        let v0 = total_active_liquidity(arg0, arg1, arg3);
        if (v0 <= arg2) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::split(&mut arg0.storage, arg1, v0 - arg2, arg3), arg3)
    }

    public(friend) fun total_active_liquidity(arg0: &ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : u64 {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::total_active_liquidity(&arg0.storage, arg1, arg2)
    }

    public(friend) fun total_active_liquidity_per_pool_id(arg0: &ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x2::tx_context::TxContext) : vector<u64> {
        0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::total_active_liquidity_per_pool_id(&arg0.storage, arg1, arg2)
    }

    public(friend) fun withdraw_from_extension(arg0: &mut ExtensionStateV1, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = total_active_liquidity(arg0, arg1, arg3);
        let v1 = 0x1::u64::min(arg2, v0);
        if (v1 == 0) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg3)
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x78ea0dce995ebfbe578bee8b8d4164d7fc1392fb482d001ee6cb29ba4a444c40::storage::split(&mut arg0.storage, arg1, v1, arg3), arg3)
    }

    // decompiled from Move bytecode v6
}

