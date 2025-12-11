module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_registry_id: 0x2::object::ID,
        owner: 0x1::option::Option<0x2::object::ID>,
        collateral: 0x2::balance::Balance<T0>,
        debt: u64,
        created_timestamp: u64,
        interest_rate_bps: u64,
        last_debt_update_timestamp: u64,
        last_interest_rate_update_timestamp: u64,
        stake: u256,
        reward_snapshot_coll: u256,
        reward_snapshot_debt: u256,
    }

    public(friend) fun add_balance_vault_collateral<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collateral, arg1);
    }

    public fun assert_vault_registry_id<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.vault_registry_id == arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultRegistryIdMismatch());
    }

    public fun borrow_vault_debt<T0>(arg0: &Vault<T0>) : u64 {
        arg0.debt
    }

    public(friend) fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u256, arg5: u256, arg6: u256, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : (Vault<T0>, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin) {
        let v0 = Vault<T0>{
            id                                  : 0x2::object::new(arg8),
            vault_registry_id                   : arg7,
            owner                               : 0x1::option::none<0x2::object::ID>(),
            collateral                          : 0x2::coin::into_balance<T0>(arg0),
            debt                                : arg3,
            created_timestamp                   : arg1,
            interest_rate_bps                   : arg2,
            last_debt_update_timestamp          : arg1,
            last_interest_rate_update_timestamp : arg1,
            stake                               : arg4,
            reward_snapshot_coll                : arg5,
            reward_snapshot_debt                : arg6,
        };
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::create_vault_admin(0x2::object::id<Vault<T0>>(&v0), arg1, arg8);
        v0.owner = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(&v1));
        (v0, v1)
    }

    public(friend) fun delete_vault_and_return_collateral<T0>(arg0: Vault<T0>) : 0x2::balance::Balance<T0> {
        let Vault {
            id                                  : v0,
            vault_registry_id                   : _,
            owner                               : _,
            collateral                          : v3,
            debt                                : _,
            created_timestamp                   : _,
            interest_rate_bps                   : _,
            last_debt_update_timestamp          : _,
            last_interest_rate_update_timestamp : _,
            stake                               : _,
            reward_snapshot_coll                : _,
            reward_snapshot_debt                : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public fun get_interest_debt<T0>(arg0: u64, arg1: &Vault<T0>) : u64 {
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_sui(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_sui(arg1.debt), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_bps(arg1.interest_rate_bps)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::ONE_YEAR_MS()))))
    }

    public fun get_vault_admin_owner_id<T0>(arg0: &Vault<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.owner
    }

    public(friend) fun get_vault_collateral_balance<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collateral, arg1)
    }

    public fun get_vault_collateral_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun get_vault_info<T0>(arg0: &Vault<T0>) : (u64, u64, u256, u256, u256, u64, u64, u64) {
        (arg0.debt, 0x2::balance::value<T0>(&arg0.collateral), arg0.stake, arg0.reward_snapshot_coll, arg0.reward_snapshot_debt, arg0.interest_rate_bps, arg0.last_debt_update_timestamp, arg0.last_interest_rate_update_timestamp)
    }

    public fun get_vault_interest_rate_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.interest_rate_bps
    }

    public(friend) fun update_vault_debt<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.debt = arg1;
        arg0.last_debt_update_timestamp = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun update_vault_interest_rate<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.interest_rate_bps = arg1;
        arg0.last_interest_rate_update_timestamp = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun update_vault_stake<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256, arg3: u256) {
        arg0.stake = arg3;
        arg0.reward_snapshot_coll = arg1;
        arg0.reward_snapshot_debt = arg2;
    }

    // decompiled from Move bytecode v6
}

