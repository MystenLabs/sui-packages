module 0x49b039b07d3738244258afac14c90364f89d3f68c1ded39a267fdf9c65819156::worm {
    struct Form has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        form_blob_id: 0x1::string::String,
        latest_submission_index_blob_id: 0x1::string::String,
        creator: address,
        team_members: vector<address>,
    }

    struct SubmissionMeta has drop, store {
        status: 0x1::string::String,
        note: 0x1::string::String,
        rank: u8,
    }

    struct IncentivePoolKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExpirationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct IncentivePool has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_per_response: u64,
        max_responses: u64,
        current_responses: u64,
    }

    struct FormCreated has copy, drop {
        form_id: address,
        creator: address,
        form_blob_id: 0x1::string::String,
    }

    struct SubmissionIndexUpdated has copy, drop {
        form_id: address,
        new_index_blob_id: 0x1::string::String,
    }

    struct PoolCreated has copy, drop {
        form_id: address,
        pool_id: address,
    }

    struct TeamCreated has copy, drop {
        form_id: address,
        team_id: address,
        members: vector<address>,
    }

    struct MetaUpdated has copy, drop {
        form_id: address,
        submission_blob_id: 0x1::string::String,
        status: 0x1::string::String,
        note: 0x1::string::String,
        rank: u8,
    }

    struct SealApproval has store, key {
        id: 0x2::object::UID,
        form_id: address,
        approved_decryptors: vector<address>,
    }

    public entry fun add_decryptor(arg0: &Form, arg1: &mut SealApproval, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator || 0x1::vector::contains<address>(&arg1.approved_decryptors, &v0), 0);
        0x1::vector::push_back<address>(&mut arg1.approved_decryptors, arg2);
        let v1 = TeamCreated{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            team_id : 0x2::object::uid_to_address(&arg1.id),
            members : arg1.approved_decryptors,
        };
        0x2::event::emit<TeamCreated>(v1);
    }

    public entry fun add_team_member(arg0: &mut Form, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator || 0x1::vector::contains<address>(&arg0.team_members, &v0), 0);
        0x1::vector::push_back<address>(&mut arg0.team_members, arg1);
        let v1 = TeamCreated{
            form_id : 0x2::object::uid_to_address(&arg0.id),
            team_id : 0x2::object::uid_to_address(&arg0.id),
            members : arg0.team_members,
        };
        0x2::event::emit<TeamCreated>(v1);
    }

    public entry fun claim_reward(arg0: &mut Form, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = IncentivePoolKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<IncentivePoolKey, IncentivePool>(&mut arg0.id, v0);
        assert!(v1.current_responses < v1.max_responses, 0);
        let v2 = v1.reward_per_response;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.balance) >= v2, 1);
        v1.current_responses = v1.current_responses + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v2), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = Form{
            id                              : v1,
            title                           : arg0,
            form_blob_id                    : arg1,
            latest_submission_index_blob_id : arg2,
            creator                         : v0,
            team_members                    : 0x1::vector::singleton<address>(v0),
        };
        0x2::transfer::share_object<Form>(v2);
        let v3 = FormCreated{
            form_id      : 0x2::object::uid_to_address(&v1),
            creator      : v0,
            form_blob_id : arg1,
        };
        0x2::event::emit<FormCreated>(v3);
    }

    public entry fun create_incentivized_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = Form{
            id                              : v1,
            title                           : arg0,
            form_blob_id                    : arg1,
            latest_submission_index_blob_id : arg2,
            creator                         : v0,
            team_members                    : 0x1::vector::singleton<address>(v0),
        };
        let v4 = IncentivePool{
            balance             : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            reward_per_response : arg4,
            max_responses       : arg5,
            current_responses   : 0,
        };
        let v5 = IncentivePoolKey{dummy_field: false};
        0x2::dynamic_field::add<IncentivePoolKey, IncentivePool>(&mut v3.id, v5, v4);
        0x2::transfer::share_object<Form>(v3);
        let v6 = FormCreated{
            form_id      : v2,
            creator      : v0,
            form_blob_id : arg1,
        };
        0x2::event::emit<FormCreated>(v6);
        let v7 = PoolCreated{
            form_id : v2,
            pool_id : v2,
        };
        0x2::event::emit<PoolCreated>(v7);
    }

    public entry fun seal_approve(arg0: address, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = SealApproval{
            id                  : v0,
            form_id             : arg0,
            approved_decryptors : arg1,
        };
        0x2::transfer::share_object<SealApproval>(v1);
        let v2 = TeamCreated{
            form_id : arg0,
            team_id : 0x2::object::uid_to_address(&v0),
            members : arg1,
        };
        0x2::event::emit<TeamCreated>(v2);
    }

    public entry fun set_form_expiration(arg0: &mut Form, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        let v0 = ExpirationKey{dummy_field: false};
        0x2::dynamic_field::add<ExpirationKey, u64>(&mut arg0.id, v0, arg1);
    }

    public entry fun update_submission_index(arg0: &mut Form, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ExpirationKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ExpirationKey>(&arg0.id, v0)) {
            let v1 = ExpirationKey{dummy_field: false};
            assert!(0x2::clock::timestamp_ms(arg2) < *0x2::dynamic_field::borrow<ExpirationKey, u64>(&arg0.id, v1), 2);
        };
        arg0.latest_submission_index_blob_id = arg1;
        let v2 = SubmissionIndexUpdated{
            form_id           : 0x2::object::uid_to_address(&arg0.id),
            new_index_blob_id : arg1,
        };
        0x2::event::emit<SubmissionIndexUpdated>(v2);
    }

    public entry fun update_submission_meta(arg0: &mut Form, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.creator || 0x1::vector::contains<address>(&arg0.team_members, &v0), 0);
        let v1 = SubmissionMeta{
            status : arg2,
            note   : arg3,
            rank   : arg4,
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, SubmissionMeta>(&mut arg0.id, arg1) = v1;
        } else {
            0x2::dynamic_field::add<0x1::string::String, SubmissionMeta>(&mut arg0.id, arg1, v1);
        };
        let v2 = MetaUpdated{
            form_id            : 0x2::object::uid_to_address(&arg0.id),
            submission_blob_id : arg1,
            status             : arg2,
            note               : arg3,
            rank               : arg4,
        };
        0x2::event::emit<MetaUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

