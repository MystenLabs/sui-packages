module 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::task {
    struct TaskCreated has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        payment_amount: u64,
        priority_tier: u8,
        verification_type: u8,
        expires_at: u64,
        created_at: u64,
    }

    struct TaskReserved has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        reserved_at: u64,
        reservation_expires_at: u64,
    }

    struct TaskAccepted has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        skill_id: 0x2::object::ID,
        bond_amount: u64,
        accepted_at: u64,
    }

    struct TaskSubmitted has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        output_ref: 0x1::string::String,
        output_hash: 0x1::string::String,
        submitted_at: u64,
    }

    struct TaskVerified has copy, drop {
        task_id: 0x2::object::ID,
        verification_type: u8,
        verification_method: 0x1::string::String,
        verified_at: u64,
    }

    struct TaskSettled has copy, drop {
        task_id: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        payment_amount: u64,
        protocol_fee: u64,
        worker_received: u64,
        bond_returned: u64,
        settled_at: u64,
    }

    struct TaskCancelled has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        refund_amount: u64,
        cancelled_at: u64,
    }

    struct TaskExpired has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        worker_agent: 0x1::option::Option<0x2::object::ID>,
        refund_amount: u64,
        bond_slashed: u64,
        expired_at: u64,
    }

    struct TaskFailed has copy, drop {
        task_id: 0x2::object::ID,
        requester_agent: 0x2::object::ID,
        worker_agent: 0x2::object::ID,
        failure_reason: 0x1::string::String,
        refund_amount: u64,
        bond_returned: u64,
        failed_at: u64,
    }

    struct Task has key {
        id: 0x2::object::UID,
        requester_agent: 0x2::object::ID,
        worker_agent: 0x1::option::Option<0x2::object::ID>,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        input_payload_ref: 0x1::string::String,
        expected_output_hash: 0x1::option::Option<0x1::string::String>,
        output_ref: 0x1::option::Option<0x1::string::String>,
        output_hash: 0x1::option::Option<0x1::string::String>,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        worker_bond: 0x2::balance::Balance<0x2::sui::SUI>,
        payment_amount: u64,
        worker_bond_required: u64,
        priority_tier: u8,
        verification_type: u8,
        status: u8,
        created_at: u64,
        reserved_at: 0x1::option::Option<u64>,
        reserved_by: 0x1::option::Option<0x2::object::ID>,
        accepted_at: 0x1::option::Option<u64>,
        submitted_at: 0x1::option::Option<u64>,
        verified_at: 0x1::option::Option<u64>,
        settled_at: 0x1::option::Option<u64>,
        expires_at: u64,
    }

    public fun id(arg0: &Task) : 0x2::object::ID {
        0x2::object::id<Task>(arg0)
    }

    public fun verification_type(arg0: &Task) : u8 {
        arg0.verification_type
    }

    public fun accept(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg4), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg0.expires_at, 3);
        let v1 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1);
        if (arg0.status == 1) {
            assert!(0x1::option::contains<0x2::object::ID>(&arg0.reserved_by, &v1), 1);
            assert!(v0 <= *0x1::option::borrow<u64>(&arg0.reserved_at) + 60000, 6);
        } else {
            assert!(arg0.status == 0, 2);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.worker_bond_required, 8);
        arg0.worker_agent = 0x1::option::some<0x2::object::ID>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.worker_bond, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.accepted_at = 0x1::option::some<u64>(v0);
        arg0.status = 3;
        let v2 = TaskAccepted{
            task_id         : 0x2::object::id<Task>(arg0),
            worker_agent    : v1,
            requester_agent : arg0.requester_agent,
            skill_id        : arg0.skill_id,
            bond_amount     : arg0.worker_bond_required,
            accepted_at     : v0,
        };
        0x2::event::emit<TaskAccepted>(v2);
    }

    public fun accepted_at(arg0: &Task) : 0x1::option::Option<u64> {
        arg0.accepted_at
    }

    public fun can_be_cancelled(arg0: &Task) : bool {
        arg0.status == 0 || arg0.status == 1
    }

    public fun cancel(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        assert!(arg0.status == 0 || arg0.status == 1, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg3), 0x2::tx_context::sender(arg3));
        arg0.status = 7;
        let v0 = TaskCancelled{
            task_id         : 0x2::object::id<Task>(arg0),
            requester_agent : arg0.requester_agent,
            refund_amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            cancelled_at    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TaskCancelled>(v0);
    }

    public fun claim_bond(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 9, 2);
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.worker_agent, &v0), 11);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond) > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.worker_bond), arg2), 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1));
    }

    public fun claim_refund(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 9, 2);
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg2), 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1));
    }

    public fun confirm(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.status == 4, 2);
        assert!(arg0.verification_type == 1, 21);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.status = 5;
        arg0.verified_at = 0x1::option::some<u64>(v0);
        let v1 = TaskVerified{
            task_id             : 0x2::object::id<Task>(arg0),
            verification_type   : arg0.verification_type,
            verification_method : 0x1::string::utf8(b"requester_confirm"),
            verified_at         : v0,
        };
        0x2::event::emit<TaskVerified>(v1);
    }

    public fun create(arg0: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::Skill, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg0) == 0x2::tx_context::sender(arg8), 0);
        assert!(!0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::deprecated(arg1), 18);
        assert!(arg5 <= 2, 20);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v1 >= 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::base_price_mist(arg1) * 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::priority_multiplier(arg1, arg5) / 10000, 7);
        let v2 = if (arg6 == 0) {
            0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::timeout_seconds(arg1)
        } else {
            arg6
        };
        let v3 = Task{
            id                   : 0x2::object::new(arg8),
            requester_agent      : 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg0),
            worker_agent         : 0x1::option::none<0x2::object::ID>(),
            skill_id             : 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::Skill>(arg1),
            skill_version        : 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::version(arg1),
            input_payload_ref    : arg2,
            expected_output_hash : arg3,
            output_ref           : 0x1::option::none<0x1::string::String>(),
            output_hash          : 0x1::option::none<0x1::string::String>(),
            escrow               : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            worker_bond          : 0x2::balance::zero<0x2::sui::SUI>(),
            payment_amount       : v1,
            worker_bond_required : 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::worker_bond_mist(arg1),
            priority_tier        : arg5,
            verification_type    : 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::verification_type(arg1),
            status               : 0,
            created_at           : v0,
            reserved_at          : 0x1::option::none<u64>(),
            reserved_by          : 0x1::option::none<0x2::object::ID>(),
            accepted_at          : 0x1::option::none<u64>(),
            submitted_at         : 0x1::option::none<u64>(),
            verified_at          : 0x1::option::none<u64>(),
            settled_at           : 0x1::option::none<u64>(),
            expires_at           : v0 + v2 * 1000,
        };
        let v4 = TaskCreated{
            task_id           : 0x2::object::id<Task>(&v3),
            requester_agent   : v3.requester_agent,
            skill_id          : v3.skill_id,
            skill_version     : v3.skill_version,
            payment_amount    : v1,
            priority_tier     : arg5,
            verification_type : v3.verification_type,
            expires_at        : v3.expires_at,
            created_at        : v0,
        };
        0x2::event::emit<TaskCreated>(v4);
        0x2::transfer::share_object<Task>(v3);
    }

    public fun created_at(arg0: &Task) : u64 {
        arg0.created_at
    }

    public fun escrow_balance(arg0: &Task) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun expected_output_hash(arg0: &Task) : 0x1::option::Option<0x1::string::String> {
        arg0.expected_output_hash
    }

    public fun expire(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &mut 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.expires_at, 2);
        let v1 = if (arg0.status == 0) {
            true
        } else if (arg0.status == 1) {
            true
        } else if (arg0.status == 3) {
            true
        } else {
            arg0.status == 4
        };
        assert!(v1, 2);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond);
        let v3 = 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1);
        if (arg0.status == 4 && arg0.verification_type == 1) {
            arg0.status = 5;
            arg0.verified_at = 0x1::option::some<u64>(v0);
            let v4 = TaskVerified{
                task_id             : 0x2::object::id<Task>(arg0),
                verification_type   : arg0.verification_type,
                verification_method : 0x1::string::utf8(b"requester_timeout"),
                verified_at         : v0,
            };
            0x2::event::emit<TaskVerified>(v4);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg4), v3);
        let v5 = if (0x1::option::is_some<0x2::object::ID>(&arg0.worker_agent) && v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.worker_bond, v2 * 5000 / 10000), arg4), v3);
            0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::deposit(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.worker_bond), arg4));
            v2
        } else {
            0
        };
        arg0.status = 8;
        let v6 = TaskExpired{
            task_id         : 0x2::object::id<Task>(arg0),
            requester_agent : arg0.requester_agent,
            worker_agent    : arg0.worker_agent,
            refund_amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            bond_slashed    : v5,
            expired_at      : v0,
        };
        0x2::event::emit<TaskExpired>(v6);
    }

    public fun expires_at(arg0: &Task) : u64 {
        arg0.expires_at
    }

    public fun extend_deadline(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at, 3);
        assert!(arg2 > arg0.expires_at, 2);
        let v0 = if (arg0.status != 6) {
            if (arg0.status != 7) {
                if (arg0.status != 8) {
                    arg0.status != 9
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        arg0.expires_at = arg2;
    }

    public fun input_payload_ref(arg0: &Task) : 0x1::string::String {
        arg0.input_payload_ref
    }

    public fun is_awaiting_worker(arg0: &Task) : bool {
        if (arg0.status == 0) {
            true
        } else if (arg0.status == 1) {
            true
        } else if (arg0.status == 2) {
            true
        } else {
            arg0.status == 3
        }
    }

    public fun is_expired(arg0: &Task, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun is_terminal(arg0: &Task) : bool {
        if (arg0.status == 6) {
            true
        } else if (arg0.status == 7) {
            true
        } else if (arg0.status == 8) {
            true
        } else {
            arg0.status == 9
        }
    }

    public fun output_hash(arg0: &Task) : 0x1::option::Option<0x1::string::String> {
        arg0.output_hash
    }

    public fun output_ref(arg0: &Task) : 0x1::option::Option<0x1::string::String> {
        arg0.output_ref
    }

    public fun payment_amount(arg0: &Task) : u64 {
        arg0.payment_amount
    }

    public fun priority_tier(arg0: &Task) : u8 {
        arg0.priority_tier
    }

    public fun reject(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg5), 0);
        assert!(arg0.status == 4, 2);
        assert!(arg0.verification_type == 1, 21);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.requester_agent, 12);
        let v0 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.worker_agent, &v0), 11);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg5), 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.worker_bond), arg5), 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg2));
        };
        arg0.status = 9;
        let v2 = TaskFailed{
            task_id         : 0x2::object::id<Task>(arg0),
            requester_agent : arg0.requester_agent,
            worker_agent    : *0x1::option::borrow<0x2::object::ID>(&arg0.worker_agent),
            failure_reason  : arg3,
            refund_amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
            bond_returned   : v1,
            failed_at       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TaskFailed>(v2);
    }

    public fun requester_agent(arg0: &Task) : 0x2::object::ID {
        arg0.requester_agent
    }

    public fun reserve(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.expires_at, 3);
        if (0x1::option::is_some<u64>(&arg0.reserved_at)) {
            assert!(v0 > *0x1::option::borrow<u64>(&arg0.reserved_at) + 60000, 5);
        };
        let v1 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1);
        arg0.reserved_at = 0x1::option::some<u64>(v0);
        arg0.reserved_by = 0x1::option::some<0x2::object::ID>(v1);
        arg0.status = 1;
        let v2 = TaskReserved{
            task_id                : 0x2::object::id<Task>(arg0),
            worker_agent           : v1,
            reserved_at            : v0,
            reservation_expires_at : v0 + 60000,
        };
        0x2::event::emit<TaskReserved>(v2);
    }

    public fun reserved_at(arg0: &Task) : 0x1::option::Option<u64> {
        arg0.reserved_at
    }

    public fun reserved_by(arg0: &Task) : 0x1::option::Option<0x2::object::ID> {
        arg0.reserved_by
    }

    public fun settle(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &mut 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 5, 2);
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg4), 0);
        let v0 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.worker_agent, &v0), 11);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1);
        let v3 = arg0.payment_amount * 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::fee_bps(arg2) / 10000;
        0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::deposit(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v3), arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg4), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.worker_bond), arg4), v2);
        arg0.settled_at = 0x1::option::some<u64>(v1);
        arg0.status = 6;
        let v4 = TaskSettled{
            task_id         : 0x2::object::id<Task>(arg0),
            worker_agent    : *0x1::option::borrow<0x2::object::ID>(&arg0.worker_agent),
            requester_agent : arg0.requester_agent,
            payment_amount  : arg0.payment_amount,
            protocol_fee    : v3,
            worker_received : arg0.payment_amount - v3,
            bond_returned   : 0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond),
            settled_at      : v1,
        };
        0x2::event::emit<TaskSettled>(v4);
    }

    public fun settled_at(arg0: &Task) : 0x1::option::Option<u64> {
        arg0.settled_at
    }

    public fun skill_id(arg0: &Task) : 0x2::object::ID {
        arg0.skill_id
    }

    public fun skill_version(arg0: &Task) : 0x1::string::String {
        arg0.skill_version
    }

    public fun status(arg0: &Task) : u8 {
        arg0.status
    }

    public fun submit(arg0: &mut Task, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg5), 0);
        assert!(arg0.status == 3, 2);
        let v0 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.worker_agent, &v0), 11);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 < arg0.expires_at, 3);
        arg0.output_ref = 0x1::option::some<0x1::string::String>(arg2);
        arg0.output_hash = 0x1::option::some<0x1::string::String>(arg3);
        arg0.submitted_at = 0x1::option::some<u64>(v1);
        arg0.status = 4;
        let v2 = TaskSubmitted{
            task_id      : 0x2::object::id<Task>(arg0),
            worker_agent : *0x1::option::borrow<0x2::object::ID>(&arg0.worker_agent),
            output_ref   : *0x1::option::borrow<0x1::string::String>(&arg0.output_ref),
            output_hash  : *0x1::option::borrow<0x1::string::String>(&arg0.output_hash),
            submitted_at : v1,
        };
        0x2::event::emit<TaskSubmitted>(v2);
        if (arg0.verification_type == 2) {
            arg0.status = 5;
            arg0.verified_at = 0x1::option::some<u64>(v1);
            let v3 = TaskVerified{
                task_id             : 0x2::object::id<Task>(arg0),
                verification_type   : arg0.verification_type,
                verification_method : 0x1::string::utf8(b"time_bound_submit"),
                verified_at         : v1,
            };
            0x2::event::emit<TaskVerified>(v3);
        };
    }

    public fun submitted_at(arg0: &Task) : 0x1::option::Option<u64> {
        arg0.submitted_at
    }

    public fun verified_at(arg0: &Task) : 0x1::option::Option<u64> {
        arg0.verified_at
    }

    public fun verify_deterministic(arg0: &mut Task, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 4, 2);
        assert!(arg0.verification_type == 0, 21);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (0x1::option::borrow<0x1::string::String>(&arg0.expected_output_hash) == 0x1::option::borrow<0x1::string::String>(&arg0.output_hash)) {
            arg0.status = 5;
            arg0.verified_at = 0x1::option::some<u64>(v0);
            let v1 = TaskVerified{
                task_id             : 0x2::object::id<Task>(arg0),
                verification_type   : arg0.verification_type,
                verification_method : 0x1::string::utf8(b"hash_match"),
                verified_at         : v0,
            };
            0x2::event::emit<TaskVerified>(v1);
        } else {
            arg0.status = 9;
            let v2 = TaskFailed{
                task_id         : 0x2::object::id<Task>(arg0),
                requester_agent : arg0.requester_agent,
                worker_agent    : *0x1::option::borrow<0x2::object::ID>(&arg0.worker_agent),
                failure_reason  : 0x1::string::utf8(b"hash_mismatch"),
                refund_amount   : arg0.payment_amount,
                bond_returned   : 0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond),
                failed_at       : v0,
            };
            0x2::event::emit<TaskFailed>(v2);
        };
    }

    public fun worker_agent(arg0: &Task) : 0x1::option::Option<0x2::object::ID> {
        arg0.worker_agent
    }

    public fun worker_bond_balance(arg0: &Task) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.worker_bond)
    }

    public fun worker_bond_required(arg0: &Task) : u64 {
        arg0.worker_bond_required
    }

    // decompiled from Move bytecode v6
}

