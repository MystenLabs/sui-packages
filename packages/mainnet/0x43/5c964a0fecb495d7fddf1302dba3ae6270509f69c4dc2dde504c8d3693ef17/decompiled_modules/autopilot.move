module 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::autopilot {
    struct AgentDirectory has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<address, 0x2::object::ID>,
        social: 0x2::table::Table<address, 0x2::object::ID>,
        groups: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Debit has copy, drop, store {
        at_ms: u64,
        amount: u64,
        digest: vector<u8>,
    }

    struct AgentAllowanceVault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        profile_id: 0x2::object::ID,
        memory_id: address,
        memory_delegate: address,
        agent_executor: address,
        allowance_balance: 0x2::balance::Balance<T0>,
        max_per_tx: u64,
        daily_limit: u64,
        expires_at_ms: u64,
        active: bool,
        epoch: u64,
        allow_create: bool,
        allow_incoming: bool,
        allow_cooldown: bool,
        payees: vector<address>,
        history: vector<Debit>,
    }

    struct AgentReceipt has copy, drop, store {
        digest: vector<u8>,
        kind: u8,
        object_id: 0x2::object::ID,
        amount: u64,
        at_ms: u64,
    }

    struct AgentActionEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        executor: address,
        request_id: vector<u8>,
        object_id: 0x2::object::ID,
        kind: u8,
        amount: u64,
        remaining: u64,
        at_ms: u64,
    }

    struct AgentVaultCreatedEvent has copy, drop {
        owner: address,
        vault_id: 0x2::object::ID,
    }

    struct PublicSocialProfile has key {
        id: 0x2::object::UID,
        owner: address,
        active: bool,
        exclude_alcohol: bool,
        vegetarian: bool,
        updated_at_ms: u64,
    }

    struct GroupConvention has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        weights: 0x2::vec_map::VecMap<address, u64>,
        approvals: 0x2::vec_map::VecMap<address, bool>,
        updated_at_ms: u64,
    }

    struct GroupConventionCreatedEvent has copy, drop {
        group_id: 0x2::object::ID,
        creator: address,
        members: vector<address>,
    }

    public fun activate_split_by_agent<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: &mut 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::GroupSplitEscrow<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg1, &arg4, arg2, arg5, arg6);
        assert!(arg0.allow_create, 201);
        debit<T0>(arg0, 0, arg5, arg6);
        0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::activate_for<T0>(arg0.owner, arg3, arg5, arg6);
        receipt<T0>(arg0, arg4, 3, 0x2::object::id<0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::GroupSplitEscrow<T0>>(arg3), 0, arg5, arg6);
    }

    fun authorize<T0>(arg0: &AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        usdc<T0>();
        assert!(0x2::tx_context::sender(arg5) == arg0.agent_executor, 201);
        let v0 = if (arg0.active) {
            if (arg0.epoch == arg3) {
                0x2::clock::timestamp_ms(arg4) < arg0.expires_at_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 205);
        assert!(0x2::object::id_address<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg1) == arg0.memory_id, 206);
        memory(arg0.owner, arg0.memory_delegate, arg1);
        assert!(0x1::vector::length<u8>(arg2) == 32 && !0x2::dynamic_field::exists<vector<u8>>(&arg0.id, *arg2), 207);
    }

    public fun configure_agent_vault<T0>(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentAllowanceVault<T0>, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool, arg11: vector<address>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _, v4) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg13);
        let v5 = v4;
        let v6 = if (v0 == arg2.owner) {
            if (v1 == arg2.profile_id) {
                if (arg3 != @0x0) {
                    arg3 != v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 201);
        memory(v0, arg4, arg1);
        policy(arg5, arg6, arg7, arg12);
        peers(&arg11, &v5, v0);
        arg2.memory_id = v2;
        arg2.memory_delegate = arg4;
        arg2.agent_executor = arg3;
        arg2.max_per_tx = arg5;
        arg2.daily_limit = arg6;
        arg2.expires_at_ms = arg7;
        arg2.allow_create = arg8;
        arg2.allow_incoming = arg9;
        arg2.allow_cooldown = arg10;
        arg2.payees = arg11;
        arg2.active = true;
        arg2.epoch = arg2.epoch + 1;
    }

    public fun consent_group_convention(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentDirectory, arg3: &mut GroupConvention, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, _) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg6);
        let v5 = v0;
        assert!(0x2::vec_map::contains<address, bool>(&arg3.approvals, &v5), 201);
        *0x2::vec_map::get_mut<address, bool>(&mut arg3.approvals, &v5) = arg4;
        arg3.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v6 = 0x2::object::id<GroupConvention>(arg3);
        if (arg4) {
            if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg2.groups, v5)) {
                0x2::table::add<address, vector<0x2::object::ID>>(&mut arg2.groups, v5, 0x1::vector::empty<0x2::object::ID>());
            };
            let v7 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.groups, v5);
            if (!0x1::vector::contains<0x2::object::ID>(v7, &v6)) {
                assert!(0x1::vector::length<0x2::object::ID>(v7) < 64, 209);
                0x1::vector::push_back<0x2::object::ID>(v7, v6);
            };
        };
    }

    public fun create_agent_allowance_vault<T0>(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentDirectory, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: address, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: bool, arg13: vector<address>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        usdc<T0>();
        let (v0, v1, v2, v3, v4) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg15);
        let v5 = v4;
        memory(v0, arg6, arg1);
        policy(arg7, arg8, arg9, arg14);
        peers(&arg13, &v5, v0);
        let v6 = if (!0x2::table::contains<address, 0x2::object::ID>(&arg2.vaults, v0)) {
            if (arg5 != @0x0) {
                if (arg5 != v0) {
                    if (0x2::coin::value<T0>(&arg3) > 0) {
                        0x2::coin::value<T0>(&arg4) >= v3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 202);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v0);
        let v7 = AgentAllowanceVault<T0>{
            id                : 0x2::object::new(arg15),
            owner             : v0,
            profile_id        : v1,
            memory_id         : v2,
            memory_delegate   : arg6,
            agent_executor    : arg5,
            allowance_balance : 0x2::coin::into_balance<T0>(arg3),
            max_per_tx        : arg7,
            daily_limit       : arg8,
            expires_at_ms     : arg9,
            active            : true,
            epoch             : 0,
            allow_create      : arg10,
            allow_incoming    : arg11,
            allow_cooldown    : arg12,
            payees            : arg13,
            history           : 0x1::vector::empty<Debit>(),
        };
        let v8 = 0x2::object::id<AgentAllowanceVault<T0>>(&v7);
        0x2::table::add<address, 0x2::object::ID>(&mut arg2.vaults, v0, v8);
        let v9 = AgentVaultCreatedEvent{
            owner    : v0,
            vault_id : v8,
        };
        0x2::event::emit<AgentVaultCreatedEvent>(v9);
        0x2::transfer::share_object<AgentAllowanceVault<T0>>(v7);
    }

    public fun create_agent_directory(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentDirectory{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::table::new<address, 0x2::object::ID>(arg0),
            social : 0x2::table::new<address, 0x2::object::ID>(arg0),
            groups : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<AgentDirectory>(v0);
    }

    public fun create_conventional_split_by_agent<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: &GroupConvention, arg4: 0x1::string::String, arg5: u64, arg6: vector<bool>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, u64>(&arg3.weights, &arg0.owner), 208);
        let v0 = 0x2::vec_map::keys<address, u64>(&arg3.weights);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            assert!(*0x2::vec_map::get<address, bool>(&arg3.approvals, &v4), 208);
            if (v4 != arg0.owner) {
                0x1::vector::push_back<address>(&mut v1, v4);
                0x1::vector::push_back<u64>(&mut v2, (((arg5 as u128) * (*0x2::vec_map::get<address, u64>(&arg3.weights, &v4) as u128) / 10000) as u64));
            };
            v3 = v3 + 1;
        };
        create_group_split_by_agent<T0>(arg0, arg1, arg2, arg4, arg5, v1, v2, arg6, arg7, arg8, arg9);
    }

    public fun create_group_convention(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentDirectory, arg3: 0x1::string::String, arg4: vector<address>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, v4) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg7);
        let v5 = v4;
        let v6 = v0;
        let v7 = if (0x1::string::length(&arg3) > 0) {
            if (0x1::string::length(&arg3) <= 120) {
                if (0x1::vector::length<address>(&arg4) > 1) {
                    if (0x1::vector::length<address>(&arg4) <= 65) {
                        0x1::vector::length<address>(&arg4) == 0x1::vector::length<u64>(&arg5)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 202);
        let v8 = GroupConvention{
            id            : 0x2::object::new(arg7),
            creator       : v6,
            title         : arg3,
            weights       : 0x2::vec_map::empty<address, u64>(),
            approvals     : 0x2::vec_map::empty<address, bool>(),
            updated_at_ms : 0x2::clock::timestamp_ms(arg6),
        };
        let v9 = 0;
        let v10 = 0;
        while (v9 < 0x1::vector::length<address>(&arg4)) {
            let v11 = *0x1::vector::borrow<address>(&arg4, v9);
            let v12 = if (v11 == v6 || 0x1::vector::contains<address>(&v5, &v11)) {
                if (!0x2::vec_map::contains<address, u64>(&v8.weights, &v11)) {
                    *0x1::vector::borrow<u64>(&arg5, v9) > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v12, 208);
            0x2::vec_map::insert<address, u64>(&mut v8.weights, v11, *0x1::vector::borrow<u64>(&arg5, v9));
            0x2::vec_map::insert<address, bool>(&mut v8.approvals, v11, v11 == v6);
            v10 = v10 + *0x1::vector::borrow<u64>(&arg5, v9);
            v9 = v9 + 1;
        };
        assert!(v10 == 10000 && 0x2::vec_map::contains<address, u64>(&v8.weights, &v6), 202);
        let v13 = 0x2::object::id<GroupConvention>(&v8);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg2.groups, v6)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg2.groups, v6, 0x1::vector::empty<0x2::object::ID>());
        };
        assert!(0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg2.groups, v6)) < 64, 209);
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.groups, v6), v13);
        let v14 = GroupConventionCreatedEvent{
            group_id : v13,
            creator  : v6,
            members  : arg4,
        };
        0x2::event::emit<GroupConventionCreatedEvent>(v14);
        0x2::transfer::share_object<GroupConvention>(v8);
    }

    public fun create_group_split_by_agent<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg1, &arg8, arg2, arg9, arg10);
        assert!(arg0.allow_create && arg4 <= arg0.max_per_tx, 203);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            assert!(0x1::vector::contains<address>(&arg0.payees, 0x1::vector::borrow<address>(&arg5, v0)), 208);
            v0 = v0 + 1;
        };
        debit<T0>(arg0, 0, arg9, arg10);
        let v1 = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::create_split_for<T0>(arg0.owner, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        receipt<T0>(arg0, arg8, 0, v1, 0, arg9, arg10);
    }

    public fun create_public_preferences(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentDirectory, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, _) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg2.social, v0), 202);
        let v5 = PublicSocialProfile{
            id              : 0x2::object::new(arg6),
            owner           : v0,
            active          : true,
            exclude_alcohol : arg3,
            vegetarian      : arg4,
            updated_at_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg2.social, v0, 0x2::object::id<PublicSocialProfile>(&v5));
        0x2::transfer::share_object<PublicSocialProfile>(v5);
    }

    fun debit<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Debit>(&arg0.history)) {
            if (v0 >= 0x1::vector::borrow<Debit>(&arg0.history, v3).at_ms && v0 - 0x1::vector::borrow<Debit>(&arg0.history, v3).at_ms >= 86400000) {
                0x1::vector::remove<Debit>(&mut arg0.history, v3);
                continue
            };
            v1 = v1 + 0x1::vector::borrow<Debit>(&arg0.history, v3).amount;
            if (0x1::vector::borrow<Debit>(&arg0.history, v3).digest == *0x2::tx_context::digest(arg3)) {
                v2 = v2 + 0x1::vector::borrow<Debit>(&arg0.history, v3).amount;
            };
            v3 = v3 + 1;
        };
        assert!(0x1::vector::length<Debit>(&arg0.history) < 64, 209);
        let v4 = if (v2 <= arg0.max_per_tx) {
            if (arg1 <= arg0.max_per_tx - v2) {
                arg1 <= 0x2::balance::value<T0>(&arg0.allowance_balance)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 203);
        assert!(v1 <= arg0.daily_limit && arg1 <= arg0.daily_limit - v1, 204);
        let v5 = Debit{
            at_ms  : v0,
            amount : arg1,
            digest : *0x2::tx_context::digest(arg3),
        };
        0x1::vector::push_back<Debit>(&mut arg0.history, v5);
    }

    fun memory(arg0: address, arg1: address, arg2: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount) {
        let v0 = if (0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::owner(arg2) == arg0) {
            if (0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_active(arg2)) {
                !0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_admin_quarantined(arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 206);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::delegate_count(arg2)) {
            if (0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::delegate_address_at(arg2, v2) == arg1) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(v1, 206);
    }

    fun peers(arg0: &vector<address>, arg1: &vector<address>, arg2: address) {
        assert!(0x1::vector::length<address>(arg0) <= 64, 208);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            let v3 = if (v2 != arg2) {
                if (v2 != @0x0) {
                    if (0x1::vector::contains<address>(arg1, &v2)) {
                        !0x1::vector::contains<address>(&v0, &v2)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 208);
            0x1::vector::push_back<address>(&mut v0, v2);
            v1 = v1 + 1;
        };
    }

    fun policy(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = if (arg0 > 0) {
            if (arg1 >= arg0) {
                if (arg2 > 0x2::clock::timestamp_ms(arg3)) {
                    arg2 <= 0x2::clock::timestamp_ms(arg3) + 30 * 86400000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 202);
    }

    public fun protect_by_agent<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg1, &arg4, arg2, arg5, arg6);
        assert!(arg0.allow_cooldown && arg3 > 0, 201);
        debit<T0>(arg0, arg3, arg5, arg6);
        let v0 = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::cooldown_for<T0>(arg0.owner, 0x2::coin::take<T0>(&mut arg0.allowance_balance, arg3, arg6), 0x1::string::utf8(b"habit_regret"), arg5, arg6);
        receipt<T0>(arg0, arg4, 4, v0, arg3, arg5, arg6);
    }

    fun receipt<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: vector<u8>, arg2: u8, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = AgentReceipt{
            digest    : *0x2::tx_context::digest(arg6),
            kind      : arg2,
            object_id : arg3,
            amount    : arg4,
            at_ms     : v0,
        };
        0x2::dynamic_field::add<vector<u8>, AgentReceipt>(&mut arg0.id, arg1, v1);
        let v2 = AgentActionEvent{
            vault_id   : 0x2::object::id<AgentAllowanceVault<T0>>(arg0),
            owner      : arg0.owner,
            executor   : 0x2::tx_context::sender(arg6),
            request_id : arg1,
            object_id  : arg3,
            kind       : arg2,
            amount     : arg4,
            remaining  : 0x2::balance::value<T0>(&arg0.allowance_balance),
            at_ms      : v0,
        };
        0x2::event::emit<AgentActionEvent>(v2);
    }

    public fun revoke_agent_vault<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 201);
        arg0.active = false;
        arg0.epoch = arg0.epoch + 1;
    }

    public fun revoke_group_consent(arg0: &mut GroupConvention, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, bool>(&arg0.approvals, &v0), 201);
        *0x2::vec_map::get_mut<address, bool>(&mut arg0.approvals, &v0) = false;
    }

    public fun revoke_public_preferences(arg0: &mut PublicSocialProfile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 201);
        arg0.active = false;
    }

    public fun settle_share_by_agent<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: &mut 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::GroupSplitEscrow<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg1, &arg4, arg2, arg5, arg6);
        let (v0, v1, v2) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::agent_share<T0>(arg3, arg0.owner, arg5);
        let v3 = v1;
        assert!(0x1::vector::contains<address>(&arg0.payees, &v3), 208);
        debit<T0>(arg0, v0, arg5, arg6);
        if (v2) {
            0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::fund_for<T0>(arg0.owner, arg3, 0x2::coin::take<T0>(&mut arg0.allowance_balance, v0, arg6), arg5, arg6);
        } else {
            0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::settle_for<T0>(arg0.owner, arg3, 0x2::coin::take<T0>(&mut arg0.allowance_balance, v0, arg6), arg5, arg6);
        };
        let v4 = if (v2) {
            2
        } else {
            1
        };
        receipt<T0>(arg0, arg4, v4, 0x2::object::id<0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::GroupSplitEscrow<T0>>(arg3), v0, arg5, arg6);
    }

    public fun top_up_agent_vault<T0>(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut AgentAllowanceVault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        usdc<T0>();
        let (v0, v1, v2, v3, _) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg5);
        let v5 = if (v0 == arg2.owner) {
            if (v1 == arg2.profile_id) {
                if (v2 == arg2.memory_id) {
                    if (0x2::coin::value<T0>(&arg4) >= v3) {
                        0x2::coin::value<T0>(&arg3) > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 201);
        0x2::balance::join<T0>(&mut arg2.allowance_balance, 0x2::coin::into_balance<T0>(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v0);
    }

    public fun update_public_preferences(arg0: &0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::UserProfile, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: &mut PublicSocialProfile, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _, _, _) = 0x435c964a0fecb495d7fddf1302dba3ae6270509f69c4dc2dde504c8d3693ef17::core::delegation_profile(arg0, arg1, arg6);
        assert!(v0 == arg2.owner, 201);
        arg2.active = true;
        arg2.exclude_alcohol = arg3;
        arg2.vegetarian = arg4;
        arg2.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
    }

    fun usdc<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 202);
    }

    public fun withdraw_from_agent_vault<T0>(arg0: &mut AgentAllowanceVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner && arg1 > 0, 201);
        arg0.epoch = arg0.epoch + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.allowance_balance, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v7
}

