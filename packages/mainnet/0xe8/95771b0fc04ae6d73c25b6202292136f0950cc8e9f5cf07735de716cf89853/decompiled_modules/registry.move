module 0xe895771b0fc04ae6d73c25b6202292136f0950cc8e9f5cf07735de716cf89853::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        forms_created: u64,
        registered_dnas: 0x2::table::Table<vector<u8>, bool>,
        dna_to_form_id: 0x2::table::Table<vector<u8>, address>,
    }

    struct Form has key {
        id: 0x2::object::UID,
        creator: address,
        dna: vector<u8>,
        schema_blob_id: 0x1::string::String,
        action_type: u8,
        reward_amount: u64,
        eligibility_kind: u8,
        eligibility_amount: u64,
        eligibility_type: 0x1::string::String,
        created_at_ms: u64,
        expires_at_ms: u64,
        active: bool,
        drained: bool,
        fee_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        submission_count: u64,
        submitters: 0x2::table::Table<address, u64>,
        max_submissions_per_address: u64,
        max_total_submissions: u64,
        reward_locked: bool,
        schema_version: u64,
        pending_creator: 0x1::option::Option<address>,
        drain_after_ms: u64,
        admins: 0x2::vec_set::VecSet<address>,
        viewers: 0x2::vec_set::VecSet<address>,
    }

    struct FormRegistered has copy, drop {
        form_id: address,
        creator: address,
        dna: vector<u8>,
        schema_blob_id: 0x1::string::String,
        action_type: u8,
        reward_amount: u64,
        eligibility_kind: u8,
        eligibility_amount: u64,
        eligibility_type: 0x1::string::String,
        admins: vector<address>,
        viewers: vector<address>,
        created_at_ms: u64,
        expires_at_ms: u64,
        max_per_address: u64,
        max_total_submissions: u64,
        schema_version: u64,
    }

    struct FormRoleChanged has copy, drop {
        form_id: address,
        wallet: address,
        role: u8,
        enabled: bool,
    }

    struct ResponseAccepted has copy, drop {
        form_id: address,
        dna: vector<u8>,
        response_blob_id: 0x1::string::String,
        submitter: address,
        submission_number: u64,
        global_submission_number: u64,
        schema_version: u64,
        created_at_ms: u64,
    }

    struct RewardPaid has copy, drop {
        form_id: address,
        submitter: address,
        amount: u64,
        remaining_pool: u64,
    }

    struct RewardSkipped has copy, drop {
        form_id: address,
        submitter: address,
        reason: u8,
    }

    struct FormActivationChanged has copy, drop {
        form_id: address,
        active: bool,
    }

    struct FormDrained has copy, drop {
        form_id: address,
        refunded_amount: u64,
    }

    struct DrainScheduled has copy, drop {
        form_id: address,
        drain_after_ms: u64,
    }

    struct PoolToppedUp has copy, drop {
        form_id: address,
        amount: u64,
    }

    struct SchemaUpdated has copy, drop {
        form_id: address,
        new_schema_blob_id: 0x1::string::String,
        schema_version: u64,
    }

    struct RewardAmountUpdated has copy, drop {
        form_id: address,
        new_reward_amount: u64,
    }

    struct PoolBelowReward has copy, drop {
        form_id: address,
        pool_balance: u64,
        reward_amount: u64,
    }

    struct MaxSubmissionsChanged has copy, drop {
        form_id: address,
        max_per_address: u64,
        max_total: u64,
    }

    struct ExpiryExtended has copy, drop {
        form_id: address,
        old_expires_at_ms: u64,
        new_expires_at_ms: u64,
    }

    struct CreatorTransferProposed has copy, drop {
        form_id: address,
        old_creator: address,
        new_creator: address,
    }

    struct CreatorTransferred has copy, drop {
        form_id: address,
        old_creator: address,
        new_creator: address,
    }

    public fun accept_creator_transfer(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::is_some<address>(&arg0.pending_creator), 23);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.pending_creator), 24);
        arg0.creator = v0;
        0x1::option::extract<address>(&mut arg0.pending_creator);
        let v1 = CreatorTransferred{
            form_id     : 0x2::object::uid_to_address(&arg0.id),
            old_creator : arg0.creator,
            new_creator : v0,
        };
        0x2::event::emit<CreatorTransferred>(v1);
    }

    public(friend) fun accept_response(arg0: &mut Form, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (address, u64) {
        assert!(arg0.active, 2);
        assert!(!arg0.drained, 19);
        assert!(0x1::string::length(&arg1) > 0, 15);
        assert!(0x1::string::length(&arg1) <= 256, 21);
        if (arg0.expires_at_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expires_at_ms, 16);
        };
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.submitters, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.submitters, v0)
        } else {
            0
        };
        assert!(v1 < arg0.max_submissions_per_address, 17);
        assert!(arg0.max_total_submissions == 0 || arg0.submission_count < arg0.max_total_submissions, 17);
        if (arg0.action_type == 1 && arg0.reward_amount > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool) >= arg0.reward_amount, 5);
        };
        0x2::table::add<address, u64>(&mut arg0.submitters, v0, v1 + 1);
        arg0.submission_count = arg0.submission_count + 1;
        let v2 = 0x2::object::uid_to_address(&arg0.id);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        if (!arg0.reward_locked && arg0.submission_count == 1) {
            arg0.reward_locked = true;
        };
        let v4 = ResponseAccepted{
            form_id                  : v2,
            dna                      : arg0.dna,
            response_blob_id         : arg1,
            submitter                : v0,
            submission_number        : v1 + 1,
            global_submission_number : arg0.submission_count,
            schema_version           : arg0.schema_version,
            created_at_ms            : v3,
        };
        0x2::event::emit<ResponseAccepted>(v4);
        (v2, v3)
    }

    public fun action_type(arg0: &Form) : u8 {
        arg0.action_type
    }

    fun assert_coin_eligible<T0>(arg0: &Form, arg1: &0x2::coin::Coin<T0>) {
        assert!(arg0.eligibility_kind == 2, 6);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == *0x1::string::as_bytes(&arg0.eligibility_type), 7);
        assert!(0x2::coin::value<T0>(arg1) >= arg0.eligibility_amount, 8);
    }

    public(friend) fun assert_dashboard_access(arg0: &Form, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (is_admin(arg0, 0x2::tx_context::sender(arg1))) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg1);
            0x2::vec_set::contains<address>(&arg0.viewers, &v1)
        };
        assert!(v0, 9);
    }

    fun assert_object_eligible<T0: key>(arg0: &Form, arg1: &T0) {
        assert!(arg0.eligibility_kind == 3, 6);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == *0x1::string::as_bytes(&arg0.eligibility_type), 7);
    }

    fun assert_open_eligibility(arg0: &Form) {
        assert!(arg0.eligibility_kind == 0, 6);
    }

    fun assert_sui_eligible(arg0: &Form, arg1: &0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.eligibility_kind == 1, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.eligibility_amount, 8);
    }

    public fun cancel_scheduled_drain(arg0: &mut Form, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(!arg0.drained, 19);
        assert!(arg0.drain_after_ms > 0, 25);
        arg0.drain_after_ms = 0;
        arg0.active = true;
        let v0 = FormActivationChanged{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            active  : true,
        };
        0x2::event::emit<FormActivationChanged>(v0);
    }

    public fun creator(arg0: &Form) : address {
        arg0.creator
    }

    public fun dna(arg0: &Form) : vector<u8> {
        arg0.dna
    }

    public fun drain_and_deactivate(arg0: &mut Form, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        assert!(!arg0.drained, 19);
        arg0.active = false;
        arg0.drained = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_pool, v0, arg1), arg0.creator);
        };
        let v1 = FormDrained{
            form_id         : 0x2::object::uid_to_address(&arg0.id),
            refunded_amount : v0,
        };
        0x2::event::emit<FormDrained>(v1);
        let v2 = FormActivationChanged{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            active  : false,
        };
        0x2::event::emit<FormActivationChanged>(v2);
    }

    public fun eligibility_kind(arg0: &Form) : u8 {
        arg0.eligibility_kind
    }

    fun execute_reward(arg0: &mut Form, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.action_type == 0) {
            return
        };
        if (arg0.action_type == 1) {
            let v0 = 0x2::tx_context::sender(arg2);
            if (arg0.reward_amount == 0) {
                let v1 = RewardSkipped{
                    form_id   : arg1,
                    submitter : v0,
                    reason    : 0,
                };
                0x2::event::emit<RewardSkipped>(v1);
                return
            };
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_pool, arg0.reward_amount, arg2), v0);
            let v3 = RewardPaid{
                form_id        : arg1,
                submitter      : v0,
                amount         : arg0.reward_amount,
                remaining_pool : v2,
            };
            0x2::event::emit<RewardPaid>(v3);
            if (v2 < arg0.reward_amount && arg0.reward_amount > 0) {
                let v4 = PoolBelowReward{
                    form_id       : arg1,
                    pool_balance  : v2,
                    reward_amount : arg0.reward_amount,
                };
                0x2::event::emit<PoolBelowReward>(v4);
            };
            return
        };
    }

    public fun execute_scheduled_drain(arg0: &mut Form, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(!arg0.drained, 19);
        assert!(arg0.drain_after_ms > 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.drain_after_ms, 25);
        arg0.drain_after_ms = 0;
        drain_and_deactivate(arg0, arg2);
    }

    public fun expires_at_ms(arg0: &Form) : u64 {
        arg0.expires_at_ms
    }

    public fun extend_expiry(arg0: &mut Form, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 9);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.expires_at_ms == 0 || v0 <= arg0.expires_at_ms, 16);
        assert!(arg1 > v0, 16);
        assert!(arg1 > arg0.expires_at_ms, 16);
        arg0.expires_at_ms = arg1;
        let v1 = ExpiryExtended{
            form_id           : 0x2::object::uid_to_address(&arg0.id),
            old_expires_at_ms : arg0.expires_at_ms,
            new_expires_at_ms : arg1,
        };
        0x2::event::emit<ExpiryExtended>(v1);
    }

    public fun form_id_for_dna(arg0: &Registry, arg1: vector<u8>) : address {
        *0x2::table::borrow<vector<u8>, address>(&arg0.dna_to_form_id, arg1)
    }

    public fun has_dashboard_access(arg0: &Form, arg1: address) : bool {
        is_admin(arg0, arg1) || 0x2::vec_set::contains<address>(&arg0.viewers, &arg1)
    }

    public fun has_form_for_dna(arg0: &Registry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, address>(&arg0.dna_to_form_id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            forms_created   : 0,
            registered_dnas : 0x2::table::new<vector<u8>, bool>(arg0),
            dna_to_form_id  : 0x2::table::new<vector<u8>, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_active(arg0: &Form) : bool {
        arg0.active && !arg0.drained
    }

    fun is_admin(arg0: &Form, arg1: address) : bool {
        arg0.creator == arg1 || 0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_drained(arg0: &Form) : bool {
        arg0.drained
    }

    public fun is_reward_locked(arg0: &Form) : bool {
        arg0.reward_locked
    }

    public fun is_submitter(arg0: &Form, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.submitters, arg1)
    }

    public fun max_submissions_per_address(arg0: &Form) : u64 {
        arg0.max_submissions_per_address
    }

    public fun max_total_submissions(arg0: &Form) : u64 {
        arg0.max_total_submissions
    }

    public fun pause_and_schedule_drain(arg0: &mut Form, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(!arg0.drained, 19);
        arg0.active = false;
        let v0 = 0x2::clock::timestamp_ms(arg1) + 3600000;
        arg0.drain_after_ms = v0;
        let v1 = FormActivationChanged{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            active  : false,
        };
        0x2::event::emit<FormActivationChanged>(v1);
        let v2 = DrainScheduled{
            form_id        : 0x2::object::uid_to_address(&arg0.id),
            drain_after_ms : v0,
        };
        0x2::event::emit<DrainScheduled>(v2);
    }

    public fun pool_balance(arg0: &Form) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool)
    }

    public fun propose_creator_transfer(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.pending_creator = 0x1::option::some<address>(arg1);
        let v0 = CreatorTransferProposed{
            form_id     : 0x2::object::uid_to_address(&arg0.id),
            old_creator : arg0.creator,
            new_creator : arg1,
        };
        0x2::event::emit<CreatorTransferProposed>(v0);
    }

    public fun register_form(arg0: &mut Registry, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: 0x1::string::String, arg8: vector<address>, arg9: vector<address>, arg10: u64, arg11: &0x2::clock::Clock, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 13);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.registered_dnas, arg1), 10);
        0x2::table::add<vector<u8>, bool>(&mut arg0.registered_dnas, arg1, true);
        assert!(0x1::string::length(&arg2) > 0, 14);
        assert!(0x1::string::length(&arg2) <= 256, 21);
        assert!(arg3 == 0 || arg3 == 1, 12);
        let v0 = if (arg5 == 0) {
            true
        } else if (arg5 == 1) {
            true
        } else if (arg5 == 2) {
            true
        } else {
            arg5 == 3
        };
        assert!(v0, 26);
        validate_eligibility_type_from_params(arg5, &arg7);
        assert!(0x1::vector::length<address>(&arg8) <= 50, 22);
        assert!(0x1::vector::length<address>(&arg9) <= 50, 22);
        let v1 = 0x2::clock::timestamp_ms(arg11);
        if (arg10 > 0) {
            assert!(arg10 > v1, 16);
        };
        if (arg3 == 1) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg12) >= arg4, 5);
        };
        let v2 = 0x2::tx_context::sender(arg15);
        let v3 = 0x2::object::new(arg15);
        let v4 = 0x2::object::uid_to_address(&v3);
        0x2::table::add<vector<u8>, address>(&mut arg0.dna_to_form_id, arg1, v4);
        let v5 = if (arg13 > 0) {
            arg13
        } else {
            1
        };
        let v6 = Form{
            id                          : v3,
            creator                     : v2,
            dna                         : arg1,
            schema_blob_id              : arg2,
            action_type                 : arg3,
            reward_amount               : arg4,
            eligibility_kind            : arg5,
            eligibility_amount          : arg6,
            eligibility_type            : arg7,
            created_at_ms               : v1,
            expires_at_ms               : arg10,
            active                      : true,
            drained                     : false,
            fee_pool                    : 0x2::coin::into_balance<0x2::sui::SUI>(arg12),
            submission_count            : 0,
            submitters                  : 0x2::table::new<address, u64>(arg15),
            max_submissions_per_address : v5,
            max_total_submissions       : arg14,
            reward_locked               : false,
            schema_version              : 1,
            pending_creator             : 0x1::option::none<address>(),
            drain_after_ms              : 0,
            admins                      : 0x2::vec_set::from_keys<address>(arg8),
            viewers                     : 0x2::vec_set::from_keys<address>(arg9),
        };
        0x2::transfer::share_object<Form>(v6);
        arg0.forms_created = arg0.forms_created + 1;
        let v7 = if (arg13 > 0) {
            arg13
        } else {
            1
        };
        let v8 = FormRegistered{
            form_id               : v4,
            creator               : v2,
            dna                   : arg1,
            schema_blob_id        : arg2,
            action_type           : arg3,
            reward_amount         : arg4,
            eligibility_kind      : arg5,
            eligibility_amount    : arg6,
            eligibility_type      : arg7,
            admins                : arg8,
            viewers               : arg9,
            created_at_ms         : v1,
            expires_at_ms         : arg10,
            max_per_address       : v7,
            max_total_submissions : arg14,
            schema_version        : 1,
        };
        0x2::event::emit<FormRegistered>(v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(&arg8)) {
            let v10 = FormRoleChanged{
                form_id : v4,
                wallet  : *0x1::vector::borrow<address>(&arg8, v9),
                role    : 1,
                enabled : true,
            };
            0x2::event::emit<FormRoleChanged>(v10);
            v9 = v9 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(&arg9)) {
            let v12 = FormRoleChanged{
                form_id : v4,
                wallet  : *0x1::vector::borrow<address>(&arg9, v11),
                role    : 2,
                enabled : true,
            };
            0x2::event::emit<FormRoleChanged>(v12);
            v11 = v11 + 1;
        };
    }

    public fun registry_count(arg0: &Registry) : u64 {
        arg0.forms_created
    }

    public fun reward_amount(arg0: &Form) : u64 {
        arg0.reward_amount
    }

    public fun schema_blob_id(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &Form, arg2: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg2)), 9);
        assert!(arg1.dna == arg0, 9);
    }

    public fun set_admin(arg0: &mut Form, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1);
        let v0 = if (arg2) {
            if (!0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
                assert!(0x2::vec_set::length<address>(&arg0.admins) < 50, 22);
                0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
                true
            } else {
                false
            }
        } else if (0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
            true
        } else {
            false
        };
        if (v0) {
            let v1 = FormRoleChanged{
                form_id : 0x2::object::uid_to_address(&arg0.id),
                wallet  : arg1,
                role    : 1,
                enabled : arg2,
            };
            0x2::event::emit<FormRoleChanged>(v1);
        };
    }

    public fun set_admins_batch(arg0: &mut Form, arg1: vector<address>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) <= 50, 22);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            set_admin(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public fun set_form_active(arg0: &mut Form, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 9);
        assert!(!arg0.drained || !arg1, 19);
        arg0.active = arg1;
        let v0 = FormActivationChanged{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            active  : arg1,
        };
        0x2::event::emit<FormActivationChanged>(v0);
    }

    public fun set_max_submissions(arg0: &mut Form, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 9);
        assert!(arg1 > 0, 22);
        assert!(arg2 == 0 || arg2 >= arg0.submission_count, 22);
        arg0.max_submissions_per_address = arg1;
        arg0.max_total_submissions = arg2;
        let v0 = MaxSubmissionsChanged{
            form_id         : 0x2::object::uid_to_address(&arg0.id),
            max_per_address : arg1,
            max_total       : arg2,
        };
        0x2::event::emit<MaxSubmissionsChanged>(v0);
    }

    public fun set_viewer(arg0: &mut Form, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 1);
        let v0 = if (arg2) {
            if (!0x2::vec_set::contains<address>(&arg0.viewers, &arg1)) {
                assert!(0x2::vec_set::length<address>(&arg0.viewers) < 50, 22);
                0x2::vec_set::insert<address>(&mut arg0.viewers, arg1);
                true
            } else {
                false
            }
        } else if (0x2::vec_set::contains<address>(&arg0.viewers, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.viewers, &arg1);
            true
        } else {
            false
        };
        if (v0) {
            let v1 = FormRoleChanged{
                form_id : 0x2::object::uid_to_address(&arg0.id),
                wallet  : arg1,
                role    : 2,
                enabled : arg2,
            };
            0x2::event::emit<FormRoleChanged>(v1);
        };
    }

    public fun set_viewers_batch(arg0: &mut Form, arg1: vector<address>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) <= 50, 22);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            set_viewer(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun submission_count_of(arg0: &Form, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.submitters, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.submitters, arg1)
        } else {
            0
        }
    }

    public fun submit_and_act(arg0: &mut Form, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_open_eligibility(arg0);
        let (v0, _) = accept_response(arg0, arg1, arg2, arg3);
        execute_reward(arg0, v0, arg3);
    }

    public fun submit_and_act_with_coin<T0>(arg0: &mut Form, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_coin_eligible<T0>(arg0, arg1);
        let (v0, _) = accept_response(arg0, arg2, arg3, arg4);
        execute_reward(arg0, v0, arg4);
    }

    public fun submit_and_act_with_object<T0: key>(arg0: &mut Form, arg1: &T0, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_object_eligible<T0>(arg0, arg1);
        let (v0, _) = accept_response(arg0, arg2, arg3, arg4);
        execute_reward(arg0, v0, arg4);
    }

    public fun submit_and_act_with_sui(arg0: &mut Form, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_sui_eligible(arg0, arg1);
        let (v0, _) = accept_response(arg0, arg2, arg3, arg4);
        execute_reward(arg0, v0, arg4);
    }

    public fun top_up_pool(arg0: &mut Form, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(!arg0.drained, 19);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PoolToppedUp{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            amount  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<PoolToppedUp>(v0);
    }

    public fun update_reward_amount(arg0: &mut Form, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 9);
        assert!(!arg0.reward_locked, 18);
        arg0.reward_amount = arg1;
        let v0 = RewardAmountUpdated{
            form_id           : 0x2::object::uid_to_address(&arg0.id),
            new_reward_amount : arg1,
        };
        0x2::event::emit<RewardAmountUpdated>(v0);
        if (arg1 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool) < arg1) {
            let v1 = PoolBelowReward{
                form_id       : 0x2::object::uid_to_address(&arg0.id),
                pool_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool),
                reward_amount : arg1,
            };
            0x2::event::emit<PoolBelowReward>(v1);
        };
    }

    public fun update_schema_blob_id(arg0: &mut Form, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 9);
        assert!(0x1::string::length(&arg1) > 0, 14);
        assert!(0x1::string::length(&arg1) <= 256, 21);
        arg0.schema_blob_id = arg1;
        arg0.schema_version = arg0.schema_version + 1;
        let v0 = SchemaUpdated{
            form_id            : 0x2::object::uid_to_address(&arg0.id),
            new_schema_blob_id : arg1,
            schema_version     : arg0.schema_version,
        };
        0x2::event::emit<SchemaUpdated>(v0);
    }

    fun validate_eligibility_type_from_params(arg0: u8, arg1: &0x1::string::String) {
        if (arg0 == 2 || arg0 == 3) {
            assert!(0x1::string::length(arg1) > 0, 7);
            let v0 = 0x1::string::utf8(b"::");
            assert!(0x1::string::index_of(arg1, &v0) < 0x1::string::length(arg1), 7);
        };
    }

    // decompiled from Move bytecode v6
}

