module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent {
    struct TriggerCondition has copy, drop, store {
        trigger_type: u8,
        params: vector<u8>,
    }

    struct ActionBlock has copy, drop, store {
        action_type: u8,
        params: vector<u8>,
    }

    struct Intent<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        actions: vector<ActionBlock>,
        constraints: 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints,
        trigger: TriggerCondition,
        vault: 0x2::balance::Balance<T0>,
        active: bool,
        deletion_requested_ms: u64,
        total_executions: u64,
        total_spent: u64,
        last_executed_ms: u64,
        created_at_ms: u64,
        fee_vault_count: u64,
        execution_amount: u64,
        keeper_fee_per_execution: u64,
        keeper_mode: u8,
        max_protocol_fee_per_execution: u64,
        params_version: u64,
        action_params_version: u8,
        min_protocol_config_version: u64,
        min_execution_amount: u64,
        last_mutated_ms: u64,
    }

    struct FeeVaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AttachedCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AttachedCapReceipt {
        intent_id: 0x2::object::ID,
    }

    struct SealedBlobKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IntentCreated has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
    }

    struct IntentExecuted has copy, drop {
        intent_id: 0x2::object::ID,
        execution_number: u64,
        executor: address,
        execution_amount: u64,
        keeper_fee_paid: u64,
        protocol_fee_paid: u64,
        vault_remaining: u64,
        params_version: u64,
    }

    struct IntentConfigUpdated has copy, drop {
        intent_id: 0x2::object::ID,
        params_version: u64,
        mutation_type: u8,
    }

    struct IntentDeletionRequested has copy, drop {
        intent_id: 0x2::object::ID,
        cooldown_expires_ms: u64,
    }

    struct IntentDeleted has copy, drop {
        intent_id: 0x2::object::ID,
        total_executions: u64,
        total_spent: u64,
        vault_returned: u64,
        lifetime_ms: u64,
    }

    struct IntentDeletionCancelled has copy, drop {
        intent_id: 0x2::object::ID,
        params_version: u64,
    }

    struct IntentTotalSpentSaturated has copy, drop {
        intent_id: 0x2::object::ID,
        total_deduction: u64,
    }

    struct IntentParamsVersionSaturated has copy, drop {
        intent_id: 0x2::object::ID,
        saturated_at_version: u64,
    }

    struct IntentToggled has copy, drop {
        intent_id: 0x2::object::ID,
        active: bool,
        params_version: u64,
    }

    struct IntentVaultTopUp has copy, drop {
        intent_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct IntentVaultWithdraw has copy, drop {
        intent_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct FeeVaultDeposit has copy, drop {
        intent_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        new_balance: u64,
    }

    struct FeeVaultWithdraw has copy, drop {
        intent_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
        new_balance: u64,
    }

    struct FeeVaultRemoved has copy, drop {
        intent_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
    }

    struct CapAttached has copy, drop {
        intent_id: 0x2::object::ID,
    }

    struct CapDetached has copy, drop {
        intent_id: 0x2::object::ID,
    }

    struct EmergencyWithdraw has copy, drop {
        intent_id: 0x2::object::ID,
        vault_returned: u64,
    }

    struct KeeperModeChanged has copy, drop {
        intent_id: 0x2::object::ID,
        new_mode: u8,
        params_version: u64,
    }

    public fun action_block_params(arg0: &ActionBlock) : vector<u8> {
        arg0.params
    }

    public fun action_block_type(arg0: &ActionBlock) : u8 {
        arg0.action_type
    }

    public fun action_count<T0>(arg0: &Intent<T0>) : u64 {
        0x1::vector::length<ActionBlock>(&arg0.actions)
    }

    public fun action_params_version<T0>(arg0: &Intent<T0>) : u8 {
        arg0.action_params_version
    }

    public fun actions<T0>(arg0: &Intent<T0>) : &vector<ActionBlock> {
        &arg0.actions
    }

    public fun attach_cap<T0, T1: store + key>(arg0: &mut Intent<T0>, arg1: T1, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        let v0 = AttachedCapKey<T1>{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_<AttachedCapKey<T1>>(&arg0.id, v0), 29);
        let v1 = AttachedCapKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::add<AttachedCapKey<T1>, T1>(&mut arg0.id, v1, arg1);
        arg0.fee_vault_count = arg0.fee_vault_count + 1;
        let v2 = CapAttached{intent_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CapAttached>(v2);
    }

    fun bump_params_version(arg0: &0x2::object::UID, arg1: &mut u64, arg2: &mut u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= *arg2 + 60000, 39);
        *arg2 = v0;
        if (*arg1 < 18446744073709551615) {
            *arg1 = *arg1 + 1;
        } else {
            let v1 = IntentParamsVersionSaturated{
                intent_id            : 0x2::object::uid_to_inner(arg0),
                saturated_at_version : *arg1,
            };
            0x2::event::emit<IntentParamsVersionSaturated>(v1);
        };
    }

    public fun cancel_deletion<T0>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms > 0, 5);
        arg0.deletion_requested_ms = 0;
        arg0.active = true;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg1);
        let v2 = IntentDeletionCancelled{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            params_version : arg0.params_version,
        };
        0x2::event::emit<IntentDeletionCancelled>(v2);
    }

    public fun consume_cap<T0>(arg0: &mut Intent<T0>, arg1: AttachedCapReceipt) {
        let AttachedCapReceipt { intent_id: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 31);
        arg0.fee_vault_count = arg0.fee_vault_count - 1;
        let v1 = CapDetached{intent_id: v0};
        0x2::event::emit<CapDetached>(v1);
    }

    public fun create_intent<T0>(arg0: vector<ActionBlock>, arg1: 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints, arg2: TriggerCondition, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        validate_intent_params(&arg0, &arg2, arg4, arg6, 0x2::coin::value<T0>(&arg3));
        assert!(arg5 == 0 || arg5 <= arg4, 40);
        assert!(0x1::vector::length<ActionBlock>(&arg0) == 1, 41);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = IntentCreated{
            intent_id : 0x2::object::uid_to_inner(&v0),
            owner     : v1,
        };
        0x2::event::emit<IntentCreated>(v2);
        let v3 = Intent<T0>{
            id                             : v0,
            owner                          : v1,
            actions                        : arg0,
            constraints                    : arg1,
            trigger                        : arg2,
            vault                          : 0x2::coin::into_balance<T0>(arg3),
            active                         : true,
            deletion_requested_ms          : 0,
            total_executions               : 0,
            total_spent                    : 0,
            last_executed_ms               : 0,
            created_at_ms                  : 0x2::clock::timestamp_ms(arg9),
            fee_vault_count                : 0,
            execution_amount               : arg4,
            keeper_fee_per_execution       : arg6,
            keeper_mode                    : 0,
            max_protocol_fee_per_execution : arg7,
            params_version                 : 0,
            action_params_version          : 1,
            min_protocol_config_version    : arg8,
            min_execution_amount           : arg5,
            last_mutated_ms                : 0,
        };
        0x2::transfer::share_object<Intent<T0>>(v3);
    }

    public(friend) fun create_intent_for<T0>(arg0: address, arg1: vector<ActionBlock>, arg2: 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints, arg3: TriggerCondition, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        validate_intent_params(&arg1, &arg3, arg5, arg7, 0x2::coin::value<T0>(&arg4));
        assert!(arg6 == 0 || arg6 <= arg5, 40);
        assert!(0x1::vector::length<ActionBlock>(&arg1) == 1, 41);
        let v0 = 0x2::object::new(arg11);
        let v1 = IntentCreated{
            intent_id : 0x2::object::uid_to_inner(&v0),
            owner     : arg0,
        };
        0x2::event::emit<IntentCreated>(v1);
        let v2 = Intent<T0>{
            id                             : v0,
            owner                          : arg0,
            actions                        : arg1,
            constraints                    : arg2,
            trigger                        : arg3,
            vault                          : 0x2::coin::into_balance<T0>(arg4),
            active                         : true,
            deletion_requested_ms          : 0,
            total_executions               : 0,
            total_spent                    : 0,
            last_executed_ms               : 0,
            created_at_ms                  : 0x2::clock::timestamp_ms(arg10),
            fee_vault_count                : 0,
            execution_amount               : arg5,
            keeper_fee_per_execution       : arg7,
            keeper_mode                    : 0,
            max_protocol_fee_per_execution : arg8,
            params_version                 : 0,
            action_params_version          : 1,
            min_protocol_config_version    : arg9,
            min_execution_amount           : arg6,
            last_mutated_ms                : 0,
        };
        0x2::transfer::share_object<Intent<T0>>(v2);
    }

    public fun create_intent_with_fee_vault<T0, T1>(arg0: vector<ActionBlock>, arg1: 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints, arg2: TriggerCondition, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        validate_intent_params(&arg0, &arg2, arg5, arg7, 0x2::coin::value<T0>(&arg3));
        assert!(arg6 == 0 || arg6 <= arg5, 40);
        assert!(0x1::vector::length<ActionBlock>(&arg0) == 1, 41);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0, 28);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = FeeVaultKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut v1, v3, 0x2::coin::into_balance<T1>(arg4));
        let v4 = FeeVaultDeposit{
            intent_id   : 0x2::object::uid_to_inner(&v1),
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount      : v0,
            new_balance : v0,
        };
        0x2::event::emit<FeeVaultDeposit>(v4);
        let v5 = IntentCreated{
            intent_id : 0x2::object::uid_to_inner(&v1),
            owner     : v2,
        };
        0x2::event::emit<IntentCreated>(v5);
        let v6 = Intent<T0>{
            id                             : v1,
            owner                          : v2,
            actions                        : arg0,
            constraints                    : arg1,
            trigger                        : arg2,
            vault                          : 0x2::coin::into_balance<T0>(arg3),
            active                         : true,
            deletion_requested_ms          : 0,
            total_executions               : 0,
            total_spent                    : 0,
            last_executed_ms               : 0,
            created_at_ms                  : 0x2::clock::timestamp_ms(arg10),
            fee_vault_count                : 1,
            execution_amount               : arg5,
            keeper_fee_per_execution       : arg7,
            keeper_mode                    : 0,
            max_protocol_fee_per_execution : arg8,
            params_version                 : 0,
            action_params_version          : 1,
            min_protocol_config_version    : arg9,
            min_execution_amount           : arg6,
            last_mutated_ms                : 0,
        };
        0x2::transfer::share_object<Intent<T0>>(v6);
    }

    public fun create_sealed_intent<T0>(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: TriggerCondition, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 & 128 != 0, 42);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 43);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 44);
        assert!(arg0 <= 6, 14);
        assert!(arg5 >= 1000000, 17);
        assert!(arg5 <= 1000000000, 15);
        assert!(0x2::coin::value<T0>(&arg4) > 0, 16);
        assert!(arg3.trigger_type <= 5, 13);
        assert!(0x1::vector::length<u8>(&arg3.params) <= 512, 19);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = SealedBlobKey{dummy_field: false};
        0x2::dynamic_field::add<SealedBlobKey, vector<u8>>(&mut v0, v2, arg2);
        let v3 = IntentCreated{
            intent_id : 0x2::object::uid_to_inner(&v0),
            owner     : v1,
        };
        0x2::event::emit<IntentCreated>(v3);
        let v4 = ActionBlock{
            action_type : arg0,
            params      : arg1,
        };
        let v5 = 0x1::vector::empty<ActionBlock>();
        0x1::vector::push_back<ActionBlock>(&mut v5, v4);
        let v6 = Intent<T0>{
            id                             : v0,
            owner                          : v1,
            actions                        : v5,
            constraints                    : 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::new_constraints(0, 0, 0, 0, 0),
            trigger                        : arg3,
            vault                          : 0x2::coin::into_balance<T0>(arg4),
            active                         : true,
            deletion_requested_ms          : 0,
            total_executions               : 0,
            total_spent                    : 0,
            last_executed_ms               : 0,
            created_at_ms                  : 0x2::clock::timestamp_ms(arg9),
            fee_vault_count                : 0,
            execution_amount               : 1,
            keeper_fee_per_execution       : arg5,
            keeper_mode                    : 1,
            max_protocol_fee_per_execution : arg6,
            params_version                 : 0,
            action_params_version          : arg8,
            min_protocol_config_version    : arg7,
            min_execution_amount           : 0,
            last_mutated_ms                : 0,
        };
        0x2::transfer::share_object<Intent<T0>>(v6);
    }

    public fun created_at_ms<T0>(arg0: &Intent<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun deletion_cooldown_ms() : u64 {
        30000
    }

    public fun deletion_requested_ms<T0>(arg0: &Intent<T0>) : u64 {
        arg0.deletion_requested_ms
    }

    public fun deposit_fee_coins<T0, T1>(arg0: &mut Intent<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 16);
        let v1 = FeeVaultKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v1)) {
            let v2 = FeeVaultKey<T1>{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v2);
            0x2::balance::join<T1>(v3, 0x2::coin::into_balance<T1>(arg1));
            let v4 = FeeVaultDeposit{
                intent_id   : 0x2::object::uid_to_inner(&arg0.id),
                coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
                amount      : v0,
                new_balance : 0x2::balance::value<T1>(v3),
            };
            0x2::event::emit<FeeVaultDeposit>(v4);
        } else {
            let v5 = FeeVaultKey<T1>{dummy_field: false};
            0x2::dynamic_field::add<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v5, 0x2::coin::into_balance<T1>(arg1));
            arg0.fee_vault_count = arg0.fee_vault_count + 1;
            let v6 = FeeVaultDeposit{
                intent_id   : 0x2::object::uid_to_inner(&arg0.id),
                coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
                amount      : v0,
                new_balance : v0,
            };
            0x2::event::emit<FeeVaultDeposit>(v6);
        };
    }

    public fun detach_cap<T0, T1: store + key>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : T1 {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = AttachedCapKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<AttachedCapKey<T1>>(&arg0.id, v0), 30);
        let v1 = AttachedCapKey<T1>{dummy_field: false};
        arg0.fee_vault_count = arg0.fee_vault_count - 1;
        let v2 = &mut arg0.params_version;
        let v3 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v2, v3, arg1);
        let v4 = CapDetached{intent_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CapDetached>(v4);
        0x2::dynamic_object_field::remove<AttachedCapKey<T1>, T1>(&mut arg0.id, v1)
    }

    public fun emergency_withdraw<T0>(arg0: &mut Intent<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.vault);
        arg0.active = false;
        let v1 = EmergencyWithdraw{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            vault_returned : v0,
        };
        0x2::event::emit<EmergencyWithdraw>(v1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v0), arg1), arg0.owner);
        };
    }

    public(friend) fun execute_intent<T0>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = arg0.execution_amount;
        execute_intent_internal<T0>(arg0, arg1, v0, arg2, arg3, arg4)
    }

    fun execute_intent_internal<T0>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::assert_not_paused(arg1);
        assert!(arg0.active, 2);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::version(arg1) >= arg0.min_protocol_config_version, 36);
        assert!(arg0.params_version == arg3, 23);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::verify(&arg0.constraints, arg0.total_executions, arg0.last_executed_ms, arg4);
        let v0 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::max_spend_per_execution(&arg0.constraints);
        assert!(v0 == 0 || arg2 <= v0, 9);
        let v1 = arg0.keeper_fee_per_execution;
        let v2 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::calculate_protocol_fee(arg1, arg2);
        let v3 = if (v2 > arg0.max_protocol_fee_per_execution) {
            arg0.max_protocol_fee_per_execution
        } else {
            v2
        };
        let v4 = arg2 + v1 + v3;
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v4, 3);
        arg0.last_executed_ms = 0x2::clock::timestamp_ms(arg4);
        if (arg0.total_executions < 18446744073709551615) {
            arg0.total_executions = arg0.total_executions + 1;
        };
        if (arg0.total_spent <= 18446744073709551615 - v4) {
            arg0.total_spent = arg0.total_spent + v4;
        } else {
            arg0.total_spent = 18446744073709551615;
            let v5 = IntentTotalSpentSaturated{
                intent_id       : 0x2::object::uid_to_inner(&arg0.id),
                total_deduction : v4,
            };
            0x2::event::emit<IntentTotalSpentSaturated>(v5);
        };
        let v6 = IntentExecuted{
            intent_id         : 0x2::object::uid_to_inner(&arg0.id),
            execution_number  : arg0.total_executions,
            executor          : 0x2::tx_context::sender(arg5),
            execution_amount  : arg2,
            keeper_fee_paid   : v1,
            protocol_fee_paid : v3,
            vault_remaining   : 0x2::balance::value<T0>(&arg0.vault),
            params_version    : arg0.params_version,
        };
        0x2::event::emit<IntentExecuted>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg5), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v1), arg5), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v3), arg5))
    }

    public(friend) fun execute_intent_variable<T0>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = arg0.min_execution_amount;
        let v1 = if (v0 > 0 && arg2 > 0) {
            assert!(arg2 >= v0, 40);
            assert!(arg2 <= arg0.execution_amount, 9);
            arg2
        } else {
            arg0.execution_amount
        };
        execute_intent_internal<T0>(arg0, arg1, v1, arg3, arg4, arg5)
    }

    public(friend) fun execute_registered<T0>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::KeeperRegistry, arg2: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg0.keeper_mode == 1, 33);
        assert!(!0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_paused(arg1), 12);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_allowed(arg1, 0x2::tx_context::sender(arg5)), 1);
        execute_intent<T0>(arg0, arg2, arg3, arg4, arg5)
    }

    public(friend) fun execute_sealed<T0>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: u64, arg3: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg0.action_params_version & 128 != 0, 42);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::assert_not_paused(arg1);
        assert!(arg0.active, 2);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::version(arg1) >= arg0.min_protocol_config_version, 36);
        assert!(arg0.params_version == arg4, 23);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::verify(arg3, arg0.total_executions, arg0.last_executed_ms, arg5);
        let v0 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::max_spend_per_execution(arg3);
        assert!(v0 == 0 || arg2 <= v0, 9);
        let v1 = arg0.keeper_fee_per_execution;
        let v2 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::calculate_protocol_fee(arg1, arg2);
        let v3 = if (v2 > arg0.max_protocol_fee_per_execution) {
            arg0.max_protocol_fee_per_execution
        } else {
            v2
        };
        let v4 = arg2 + v1 + v3;
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v4, 3);
        arg0.last_executed_ms = 0x2::clock::timestamp_ms(arg5);
        if (arg0.total_executions < 18446744073709551615) {
            arg0.total_executions = arg0.total_executions + 1;
        };
        if (arg0.total_spent <= 18446744073709551615 - v4) {
            arg0.total_spent = arg0.total_spent + v4;
        } else {
            arg0.total_spent = 18446744073709551615;
            let v5 = IntentTotalSpentSaturated{
                intent_id       : 0x2::object::uid_to_inner(&arg0.id),
                total_deduction : v4,
            };
            0x2::event::emit<IntentTotalSpentSaturated>(v5);
        };
        let v6 = IntentExecuted{
            intent_id         : 0x2::object::uid_to_inner(&arg0.id),
            execution_number  : arg0.total_executions,
            executor          : 0x2::tx_context::sender(arg6),
            execution_amount  : arg2,
            keeper_fee_paid   : v1,
            protocol_fee_paid : v3,
            vault_remaining   : 0x2::balance::value<T0>(&arg0.vault),
            params_version    : arg0.params_version,
        };
        0x2::event::emit<IntentExecuted>(v6);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg6), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v1), arg6), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v3), arg6))
    }

    public fun execution_amount<T0>(arg0: &Intent<T0>) : u64 {
        arg0.execution_amount
    }

    public fun extract_cap<T0, T1: store + key>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::KeeperRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) : (T1, AttachedCapReceipt) {
        assert!(!0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_paused(arg1), 12);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_allowed(arg1, 0x2::tx_context::sender(arg3)), 1);
        assert!(arg0.active, 2);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(arg0.params_version == arg2, 23);
        let v0 = AttachedCapKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<AttachedCapKey<T1>>(&arg0.id, v0), 30);
        let v1 = AttachedCapKey<T1>{dummy_field: false};
        let v2 = AttachedCapReceipt{intent_id: 0x2::object::uid_to_inner(&arg0.id)};
        (0x2::dynamic_object_field::remove<AttachedCapKey<T1>, T1>(&mut arg0.id, v1), v2)
    }

    public fun fee_vault_balance<T0, T1>(arg0: &Intent<T0>) : u64 {
        let v0 = FeeVaultKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v0)) {
            let v2 = FeeVaultKey<T1>{dummy_field: false};
            0x2::balance::value<T1>(0x2::dynamic_field::borrow<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun fee_vault_count<T0>(arg0: &Intent<T0>) : u64 {
        arg0.fee_vault_count
    }

    public fun finalize_deletion<T0>(arg0: Intent<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms > 0, 5);
        assert!(arg0.fee_vault_count == 0, 27);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.deletion_requested_ms + 30000, 6);
        let v1 = IntentDeleted{
            intent_id        : 0x2::object::uid_to_inner(&arg0.id),
            total_executions : arg0.total_executions,
            total_spent      : arg0.total_spent,
            vault_returned   : 0x2::balance::value<T0>(&arg0.vault),
            lifetime_ms      : v0 - arg0.created_at_ms,
        };
        0x2::event::emit<IntentDeleted>(v1);
        let Intent {
            id                             : v2,
            owner                          : v3,
            actions                        : _,
            constraints                    : _,
            trigger                        : _,
            vault                          : v7,
            active                         : _,
            deletion_requested_ms          : _,
            total_executions               : _,
            total_spent                    : _,
            last_executed_ms               : _,
            created_at_ms                  : _,
            fee_vault_count                : _,
            execution_amount               : _,
            keeper_fee_per_execution       : _,
            keeper_mode                    : _,
            max_protocol_fee_per_execution : _,
            params_version                 : _,
            action_params_version          : _,
            min_protocol_config_version    : _,
            min_execution_amount           : _,
            last_mutated_ms                : _,
        } = arg0;
        let v24 = v7;
        if (0x2::balance::value<T0>(&v24) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg2), v3);
        } else {
            0x2::balance::destroy_zero<T0>(v24);
        };
        0x2::object::delete(v2);
    }

    public fun finalize_deletion_with_fees<T0, T1>(arg0: Intent<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms > 0, 5);
        let v0 = FeeVaultKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v0)) {
            assert!(arg0.fee_vault_count == 1, 27);
        } else {
            assert!(arg0.fee_vault_count == 0, 27);
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.deletion_requested_ms + 30000, 6);
        let v2 = IntentDeleted{
            intent_id        : 0x2::object::uid_to_inner(&arg0.id),
            total_executions : arg0.total_executions,
            total_spent      : arg0.total_spent,
            vault_returned   : 0x2::balance::value<T0>(&arg0.vault),
            lifetime_ms      : v1 - arg0.created_at_ms,
        };
        0x2::event::emit<IntentDeleted>(v2);
        let Intent {
            id                             : v3,
            owner                          : v4,
            actions                        : _,
            constraints                    : _,
            trigger                        : _,
            vault                          : v8,
            active                         : _,
            deletion_requested_ms          : _,
            total_executions               : _,
            total_spent                    : _,
            last_executed_ms               : _,
            created_at_ms                  : _,
            fee_vault_count                : _,
            execution_amount               : _,
            keeper_fee_per_execution       : _,
            keeper_mode                    : _,
            max_protocol_fee_per_execution : _,
            params_version                 : _,
            action_params_version          : _,
            min_protocol_config_version    : _,
            min_execution_amount           : _,
            last_mutated_ms                : _,
        } = arg0;
        let v25 = v8;
        let v26 = v3;
        if (0x2::balance::value<T0>(&v25) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg2), v4);
        } else {
            0x2::balance::destroy_zero<T0>(v25);
        };
        let v27 = FeeVaultKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&v26, v27)) {
            let v28 = FeeVaultKey<T1>{dummy_field: false};
            let v29 = 0x2::dynamic_field::remove<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut v26, v28);
            if (0x2::balance::value<T1>(&v29) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v29, arg2), v4);
            } else {
                0x2::balance::destroy_zero<T1>(v29);
            };
        };
        0x2::object::delete(v26);
    }

    public fun has_attached_cap<T0, T1: store + key>(arg0: &Intent<T0>) : bool {
        let v0 = AttachedCapKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::exists_<AttachedCapKey<T1>>(&arg0.id, v0)
    }

    public fun has_fee_vault<T0, T1>(arg0: &Intent<T0>) : bool {
        let v0 = FeeVaultKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v0)
    }

    public fun is_active<T0>(arg0: &Intent<T0>) : bool {
        arg0.active
    }

    public fun is_sealed<T0>(arg0: &Intent<T0>) : bool {
        arg0.action_params_version & 128 != 0
    }

    public fun keeper_fee_per_execution<T0>(arg0: &Intent<T0>) : u64 {
        arg0.keeper_fee_per_execution
    }

    public fun keeper_mode<T0>(arg0: &Intent<T0>) : u8 {
        arg0.keeper_mode
    }

    public fun keeper_mode_permissionless() : u8 {
        0
    }

    public fun keeper_mode_registered() : u8 {
        1
    }

    public fun last_executed_ms<T0>(arg0: &Intent<T0>) : u64 {
        arg0.last_executed_ms
    }

    public fun last_mutated_ms<T0>(arg0: &Intent<T0>) : u64 {
        arg0.last_mutated_ms
    }

    public fun make_permissionless<T0>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.keeper_mode == 1, 38);
        arg0.keeper_mode = 0;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg1);
        let v2 = KeeperModeChanged{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            new_mode       : 0,
            params_version : arg0.params_version,
        };
        0x2::event::emit<KeeperModeChanged>(v2);
    }

    public fun max_action_type() : u8 {
        6
    }

    public fun max_keeper_fee() : u64 {
        1000000000
    }

    public fun max_protocol_fee_per_execution<T0>(arg0: &Intent<T0>) : u64 {
        arg0.max_protocol_fee_per_execution
    }

    public fun max_trigger_type() : u8 {
        5
    }

    public fun min_execution_amount<T0>(arg0: &Intent<T0>) : u64 {
        arg0.min_execution_amount
    }

    public fun min_keeper_fee() : u64 {
        1000000
    }

    public fun min_protocol_config_version<T0>(arg0: &Intent<T0>) : u64 {
        arg0.min_protocol_config_version
    }

    public fun new_action(arg0: u8, arg1: vector<u8>) : ActionBlock {
        assert!(arg0 <= 6, 14);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 18);
        ActionBlock{
            action_type : arg0,
            params      : arg1,
        }
    }

    public fun new_trigger(arg0: u8, arg1: vector<u8>) : TriggerCondition {
        assert!(arg0 <= 5, 13);
        assert!(0x1::vector::length<u8>(&arg1) <= 512, 19);
        TriggerCondition{
            trigger_type : arg0,
            params       : arg1,
        }
    }

    public fun owner<T0>(arg0: &Intent<T0>) : address {
        arg0.owner
    }

    public fun params_version<T0>(arg0: &Intent<T0>) : u64 {
        arg0.params_version
    }

    public fun request_deletion<T0>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.active = false;
        arg0.deletion_requested_ms = v0;
        let v1 = &mut arg0.params_version;
        let v2 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v1, v2, arg1);
        let v3 = IntentDeletionRequested{
            intent_id           : 0x2::object::uid_to_inner(&arg0.id),
            cooldown_expires_ms : v0 + 30000,
        };
        0x2::event::emit<IntentDeletionRequested>(v3);
    }

    public fun return_cap<T0, T1: store + key>(arg0: &mut Intent<T0>, arg1: T1, arg2: AttachedCapReceipt) {
        let AttachedCapReceipt { intent_id: v0 } = arg2;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 31);
        let v1 = AttachedCapKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::add<AttachedCapKey<T1>, T1>(&mut arg0.id, v1, arg1);
    }

    public fun sealed_blob<T0>(arg0: &Intent<T0>) : vector<u8> {
        let v0 = SealedBlobKey{dummy_field: false};
        *0x2::dynamic_field::borrow<SealedBlobKey, vector<u8>>(&arg0.id, v0)
    }

    public fun toggle_active<T0>(arg0: &mut Intent<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 8);
        arg0.active = !arg0.active;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg1);
        let v2 = IntentToggled{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            active         : arg0.active,
            params_version : arg0.params_version,
        };
        0x2::event::emit<IntentToggled>(v2);
    }

    public fun top_up_vault<T0>(arg0: &mut Intent<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 16);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = IntentVaultTopUp{
            intent_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<IntentVaultTopUp>(v1);
    }

    public(friend) fun top_up_vault_from_execution<T0>(arg0: &mut Intent<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 16);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = IntentVaultTopUp{
            intent_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<IntentVaultTopUp>(v1);
    }

    public fun total_executions<T0>(arg0: &Intent<T0>) : u64 {
        arg0.total_executions
    }

    public fun total_spent<T0>(arg0: &Intent<T0>) : u64 {
        arg0.total_spent
    }

    public fun trigger_condition_type(arg0: &TriggerCondition) : u8 {
        arg0.trigger_type
    }

    public fun trigger_params<T0>(arg0: &Intent<T0>) : vector<u8> {
        arg0.trigger.params
    }

    public fun trigger_type<T0>(arg0: &Intent<T0>) : u8 {
        arg0.trigger.trigger_type
    }

    public fun update_actions<T0>(arg0: &mut Intent<T0>, arg1: vector<ActionBlock>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        validate_actions(&arg1);
        arg0.actions = arg1;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg2);
        let v2 = IntentConfigUpdated{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            params_version : arg0.params_version,
            mutation_type  : 1,
        };
        0x2::event::emit<IntentConfigUpdated>(v2);
    }

    public fun update_constraints<T0>(arg0: &mut Intent<T0>, arg1: 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::constraints::Constraints, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        arg0.constraints = arg1;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg2);
        let v2 = IntentConfigUpdated{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            params_version : arg0.params_version,
            mutation_type  : 2,
        };
        0x2::event::emit<IntentConfigUpdated>(v2);
    }

    public fun update_keeper_fee<T0>(arg0: &mut Intent<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(arg1 >= 1000000, 17);
        assert!(arg1 <= 1000000000, 15);
        arg0.keeper_fee_per_execution = arg1;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg2);
        let v2 = IntentConfigUpdated{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            params_version : arg0.params_version,
            mutation_type  : 3,
        };
        0x2::event::emit<IntentConfigUpdated>(v2);
    }

    public fun update_max_protocol_fee<T0>(arg0: &mut Intent<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        arg0.max_protocol_fee_per_execution = arg1;
    }

    public fun update_trigger<T0>(arg0: &mut Intent<T0>, arg1: TriggerCondition, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(arg1.trigger_type <= 5, 13);
        assert!(0x1::vector::length<u8>(&arg1.params) <= 512, 19);
        arg0.trigger = arg1;
        let v0 = &mut arg0.params_version;
        let v1 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v0, v1, arg2);
        let v2 = IntentConfigUpdated{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            params_version : arg0.params_version,
            mutation_type  : 0,
        };
        0x2::event::emit<IntentConfigUpdated>(v2);
    }

    fun validate_action(arg0: &ActionBlock) {
        assert!(arg0.action_type <= 6, 14);
        assert!(0x1::vector::length<u8>(&arg0.params) <= 256, 18);
        if (arg0.action_type == 2) {
            assert!(0x1::vector::length<u8>(&arg0.params) == 33, 10);
            let v0 = true;
            let v1 = 1;
            while (v1 < 33) {
                if (*0x1::vector::borrow<u8>(&arg0.params, v1) != 0) {
                    v0 = false;
                    break
                };
                v1 = v1 + 1;
            };
            assert!(!v0, 10);
        };
    }

    fun validate_actions(arg0: &vector<ActionBlock>) {
        let v0 = 0x1::vector::length<ActionBlock>(arg0);
        assert!(v0 > 0, 20);
        assert!(v0 <= 10, 21);
        let v1 = 0;
        while (v1 < v0) {
            validate_action(0x1::vector::borrow<ActionBlock>(arg0, v1));
            v1 = v1 + 1;
        };
    }

    fun validate_intent_params(arg0: &vector<ActionBlock>, arg1: &TriggerCondition, arg2: u64, arg3: u64, arg4: u64) {
        validate_actions(arg0);
        assert!(arg1.trigger_type <= 5, 13);
        assert!(0x1::vector::length<u8>(&arg1.params) <= 512, 19);
        assert!(arg2 > 0, 22);
        assert!(arg3 >= 1000000, 17);
        assert!(arg3 <= 1000000000, 15);
        assert!(arg4 > 0, 16);
    }

    public fun vault_balance<T0>(arg0: &Intent<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun withdraw_execution_fees<T0, T1>(arg0: &mut Intent<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::KeeperRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_paused(arg1), 12);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_allowed(arg1, 0x2::tx_context::sender(arg4)), 1);
        assert!(arg0.active, 2);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(arg0.params_version == arg2, 23);
        assert!(arg3 > 0, 24);
        let v0 = FeeVaultKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v0), 25);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = FeeVaultKey<T1>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v2);
        assert!(0x2::balance::value<T1>(v3) >= arg3, 26);
        let v4 = 0x2::balance::value<T1>(v3);
        let v5 = FeeVaultWithdraw{
            intent_id   : v1,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount      : arg3,
            new_balance : v4,
        };
        0x2::event::emit<FeeVaultWithdraw>(v5);
        if (v4 == 0) {
            let v6 = FeeVaultKey<T1>{dummy_field: false};
            0x2::balance::destroy_zero<T1>(0x2::dynamic_field::remove<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v6));
            arg0.fee_vault_count = arg0.fee_vault_count - 1;
            let v7 = FeeVaultRemoved{
                intent_id : v1,
                coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            };
            0x2::event::emit<FeeVaultRemoved>(v7);
        };
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v3, arg3), arg4)
    }

    public fun withdraw_fee_coins<T0, T1>(arg0: &mut Intent<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 > 0, 24);
        let v0 = FeeVaultKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<FeeVaultKey<T1>>(&arg0.id, v0), 25);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = FeeVaultKey<T1>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v2);
        assert!(0x2::balance::value<T1>(v3) >= arg1, 26);
        let v4 = 0x2::balance::split<T1>(v3, arg1);
        let v5 = 0x2::balance::value<T1>(v3);
        let v6 = FeeVaultWithdraw{
            intent_id   : v1,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount      : arg1,
            new_balance : v5,
        };
        0x2::event::emit<FeeVaultWithdraw>(v6);
        if (v5 == 0) {
            let v7 = FeeVaultKey<T1>{dummy_field: false};
            0x2::balance::destroy_zero<T1>(0x2::dynamic_field::remove<FeeVaultKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v7));
            arg0.fee_vault_count = arg0.fee_vault_count - 1;
            let v8 = FeeVaultRemoved{
                intent_id : v1,
                coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            };
            0x2::event::emit<FeeVaultRemoved>(v8);
        };
        let v9 = &mut arg0.params_version;
        let v10 = &mut arg0.last_mutated_ms;
        bump_params_version(&arg0.id, v9, v10, arg2);
        0x2::coin::from_balance<T1>(v4, arg3)
    }

    public fun withdraw_from_vault<T0>(arg0: &mut Intent<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.deletion_requested_ms == 0, 4);
        assert!(arg1 > 0, 24);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg1, 3);
        let v0 = IntentVaultWithdraw{
            intent_id   : 0x2::object::uid_to_inner(&arg0.id),
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<IntentVaultWithdraw>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

