module 0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::sweep {
    struct DepositVault has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct VaultClaimed has copy, drop {
        registry_id: 0x2::object::ID,
        vault_address: address,
        key: vector<u8>,
    }

    struct FundsSwept<phantom T0> has copy, drop {
        registry_id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
    }

    fun assert_scope(arg0: &DepositVault, arg1: &0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry) {
        assert!(arg0.registry_id == 0x2::object::id<0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry>(arg1), 13835058794016538625);
    }

    public fun claim_vault(arg0: &mut 0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : DepositVault {
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_version(arg0);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_not_paused(arg0);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_sweeper_or_admin(arg0, arg2);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_key_length(&arg1);
        let v0 = 0x2::object::id<0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry>(arg0);
        let v1 = DepositVault{
            id          : 0x2::derived_object::claim<vector<u8>>(0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::uid_mut(arg0), arg1),
            registry_id : v0,
        };
        let v2 = VaultClaimed{
            registry_id   : v0,
            vault_address : 0x2::object::uid_to_address(&v1.id),
            key           : arg1,
        };
        0x2::event::emit<VaultClaimed>(v2);
        v1
    }

    public fun share_vault(arg0: DepositVault) {
        0x2::transfer::share_object<DepositVault>(arg0);
    }

    public fun sweep_balance<T0>(arg0: &mut DepositVault, arg1: &0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_version(arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_not_paused(arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_sweeper_or_admin(arg1, arg4);
        assert_scope(arg0, arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_destination(arg1, arg2);
        assert!(arg3 > 0, 13835340165914165251);
        0x2::balance::send_funds<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg3)), arg2);
        let v0 = FundsSwept<T0>{
            registry_id : 0x2::object::id<0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry>(arg1),
            from        : 0x2::object::uid_to_address(&arg0.id),
            to          : arg2,
            amount      : arg3,
        };
        0x2::event::emit<FundsSwept<T0>>(v0);
    }

    public fun sweep_coin<T0>(arg0: &mut DepositVault, arg1: &0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry, arg2: address, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::tx_context::TxContext) {
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_version(arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_not_paused(arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_sweeper_or_admin(arg1, arg4);
        assert_scope(arg0, arg1);
        0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::assert_destination(arg1, arg2);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
        } else {
            0x2::coin::send_funds<T0>(v0, arg2);
            let v2 = FundsSwept<T0>{
                registry_id : 0x2::object::id<0x6b6dbfb3a4ed0b255a54a3fbdcc02ce98d580cfb3b27d6d262fd92b2573b901::registry::Registry>(arg1),
                from        : 0x2::object::uid_to_address(&arg0.id),
                to          : arg2,
                amount      : v1,
            };
            0x2::event::emit<FundsSwept<T0>>(v2);
        };
    }

    public fun vault_address(arg0: &DepositVault) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun vault_registry_id(arg0: &DepositVault) : 0x2::object::ID {
        arg0.registry_id
    }

    // decompiled from Move bytecode v7
}

