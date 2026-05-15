module 0x306583ea1ac49ef7ad98cc1cf1cf6a52636d9712f4332234eb47e0ae1bb8714d::walrus_pulse {
    struct Form has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        owner: address,
        admins: 0x2::vec_set::VecSet<address>,
        response_blob_ids: vector<0x1::string::String>,
        is_active: bool,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        rewarded: 0x2::vec_set::VecSet<address>,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        owner: address,
    }

    struct ResponseSubmitted has copy, drop {
        form_id: 0x2::object::ID,
        response_blob_id: 0x1::string::String,
        submitter: address,
    }

    struct PoolFunded has copy, drop {
        form_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct RewardSent has copy, drop {
        form_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        remaining_pool: u64,
    }

    struct AdminAdded has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
        removed_by: address,
    }

    struct OwnershipTransferred has copy, drop {
        form_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public entry fun add_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
            let v0 = AdminAdded{
                form_id  : 0x2::object::uid_to_inner(&arg0.id),
                admin    : arg1,
                added_by : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<AdminAdded>(v0);
        };
    }

    public fun admins(arg0: &Form) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.admins)
    }

    public entry fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x1::string::utf8(arg0);
        let v4 = 0x1::string::utf8(arg2);
        let v5 = 0x2::vec_set::empty<address>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg3)) {
            let v7 = *0x1::vector::borrow<address>(&arg3, v6);
            if (v7 != v2 && !0x2::vec_set::contains<address>(&v5, &v7)) {
                0x2::vec_set::insert<address>(&mut v5, v7);
                let v8 = AdminAdded{
                    form_id  : v1,
                    admin    : v7,
                    added_by : v2,
                };
                0x2::event::emit<AdminAdded>(v8);
            };
            v6 = v6 + 1;
        };
        let v9 = FormCreated{
            form_id        : v1,
            title          : v3,
            schema_blob_id : v4,
            owner          : v2,
        };
        0x2::event::emit<FormCreated>(v9);
        let v10 = Form{
            id                : v0,
            title             : v3,
            description       : 0x1::string::utf8(arg1),
            schema_blob_id    : v4,
            owner             : v2,
            admins            : v5,
            response_blob_ids : 0x1::vector::empty<0x1::string::String>(),
            is_active         : true,
            reward_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            rewarded          : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<Form>(v10);
    }

    public entry fun deactivate_form(arg0: &mut Form, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg0, arg1), 5);
        arg0.is_active = false;
    }

    public entry fun fund_reward_pool(arg0: &mut Form, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = PoolFunded{
            form_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount      : v0,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool),
        };
        0x2::event::emit<PoolFunded>(v1);
    }

    public fun is_active(arg0: &Form) : bool {
        arg0.is_active
    }

    fun is_authorized(arg0: &Form, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        v0 == arg0.owner || 0x2::vec_set::contains<address>(&arg0.admins, &v0)
    }

    public fun is_rewarded(arg0: &Form, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.rewarded, &arg1)
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public entry fun remove_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
            let v0 = AdminRemoved{
                form_id    : 0x2::object::uid_to_inner(&arg0.id),
                admin      : arg1,
                removed_by : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<AdminRemoved>(v0);
        };
    }

    public fun response_blob_ids(arg0: &Form) : vector<0x1::string::String> {
        arg0.response_blob_ids
    }

    public fun response_count(arg0: &Form) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.response_blob_ids)
    }

    public fun reward_pool_balance(arg0: &Form) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool)
    }

    public entry fun reward_respondent(arg0: &mut Form, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 > 0, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool) >= arg2, 2);
        assert!(!0x2::vec_set::contains<address>(&arg0.rewarded, &arg1), 3);
        0x2::vec_set::insert<address>(&mut arg0.rewarded, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, arg2), arg3), arg1);
        let v0 = RewardSent{
            form_id        : 0x2::object::uid_to_inner(&arg0.id),
            recipient      : arg1,
            amount         : arg2,
            remaining_pool : 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool),
        };
        0x2::event::emit<RewardSent>(v0);
    }

    public fun schema_blob_id(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public entry fun submit_response(arg0: &mut Form, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = ResponseSubmitted{
            form_id          : 0x2::object::uid_to_inner(&arg0.id),
            response_blob_id : v0,
            submitter        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ResponseSubmitted>(v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.response_blob_ids, v0);
    }

    public fun title(arg0: &Form) : 0x1::string::String {
        arg0.title
    }

    public entry fun transfer_ownership(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1 != arg0.owner, 0);
        if (0x2::vec_set::contains<address>(&arg0.admins, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        };
        arg0.owner = arg1;
        let v0 = OwnershipTransferred{
            form_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public entry fun withdraw_reward_pool(arg0: &mut Form, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, v0), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

