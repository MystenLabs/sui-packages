module 0x85b9a5bb6ce0570caebb30222472e02317d7229e08eaf3698cd0ab81d847c064::agreement {
    struct AgreementCreated has copy, drop {
        agreement_id: 0x2::object::ID,
        employer: address,
        worker: address,
        description: vector<u8>,
        deadline: u64,
    }

    struct AgreementFunded has copy, drop {
        agreement_id: 0x2::object::ID,
        employer: address,
        contract_amount: u64,
        platform_fee: u64,
    }

    struct AgreementFinished has copy, drop {
        agreement_id: 0x2::object::ID,
        finished_by: address,
    }

    struct AgreementFulfilled has copy, drop {
        agreement_id: 0x2::object::ID,
        fulfilled_by: address,
    }

    struct AgreementTerminated has copy, drop {
        agreement_id: 0x2::object::ID,
        terminated_by: address,
        reason: vector<u8>,
    }

    struct Agreement has key {
        id: 0x2::object::UID,
        employer: address,
        worker: address,
        description: vector<u8>,
        contract_amount: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        created_at: u64,
        deadline: u64,
    }

    public entry fun create_agreement(arg0: address, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch(arg5);
        assert!(v1 <= arg4, 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v2 > 0, 6);
        assert!(v3 > 0, 6);
        let v4 = 0x2::object::new(arg5);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = Agreement{
            id              : v4,
            employer        : v0,
            worker          : arg0,
            description     : arg1,
            contract_amount : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            platform_fee    : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            status          : 1,
            created_at      : v1,
            deadline        : arg4,
        };
        let v7 = AgreementCreated{
            agreement_id : v5,
            employer     : v0,
            worker       : arg0,
            description  : arg1,
            deadline     : arg4,
        };
        0x2::event::emit<AgreementCreated>(v7);
        let v8 = AgreementFunded{
            agreement_id    : v5,
            employer        : v0,
            contract_amount : v2,
            platform_fee    : v3,
        };
        0x2::event::emit<AgreementFunded>(v8);
        0x2::transfer::share_object<Agreement>(v6);
    }

    public entry fun finish_agreement(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.worker, 5);
        assert!(arg0.status == 1, 1);
        arg0.status = 2;
        let v1 = AgreementFinished{
            agreement_id : 0x2::object::uid_to_inner(&arg0.id),
            finished_by  : v0,
        };
        0x2::event::emit<AgreementFinished>(v1);
    }

    public entry fun fulfill_agreement(arg0: &mut Agreement, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.employer, 4);
        assert!(arg0.status == 2, 1);
        arg0.status = 3;
        let v1 = AgreementFulfilled{
            agreement_id : 0x2::object::uid_to_inner(&arg0.id),
            fulfilled_by : v0,
        };
        0x2::event::emit<AgreementFulfilled>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.contract_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_amount), arg1), arg0.worker);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.platform_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fee), arg1), @0x68d8cf382e47825b901e8a2112b10dfd51b3e39a6138ef0b32e39193b21e5d63);
    }

    public fun get_agreement_amounts(arg0: &Agreement) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.contract_amount), 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fee))
    }

    public fun get_agreement_details(arg0: &Agreement) : (address, address, vector<u8>, u64, u64, u8, u64, u64) {
        (arg0.employer, arg0.worker, arg0.description, 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_amount), 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fee), arg0.status, arg0.deadline, arg0.created_at)
    }

    public fun get_agreement_parties(arg0: &Agreement) : (address, address) {
        (arg0.employer, arg0.worker)
    }

    public fun get_status(arg0: &Agreement) : u8 {
        arg0.status
    }

    public fun is_expired(arg0: &Agreement, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) > arg0.deadline
    }

    public fun is_finished(arg0: &Agreement) : bool {
        arg0.status == 2
    }

    public fun is_fulfilled(arg0: &Agreement) : bool {
        arg0.status == 3
    }

    public entry fun terminate_agreement(arg0: &mut Agreement, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.employer, 4);
        assert!(arg0.status == 1 || arg0.status == 2, 1);
        arg0.status = 4;
        let v1 = AgreementTerminated{
            agreement_id  : 0x2::object::uid_to_inner(&arg0.id),
            terminated_by : v0,
            reason        : arg1,
        };
        0x2::event::emit<AgreementTerminated>(v1);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.contract_amount);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.contract_amount, v2, arg2), arg0.employer);
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fee);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.platform_fee, v3, arg2), @0x68d8cf382e47825b901e8a2112b10dfd51b3e39a6138ef0b32e39193b21e5d63);
        };
    }

    // decompiled from Move bytecode v6
}

