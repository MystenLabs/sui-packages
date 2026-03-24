module 0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        members: 0x2::vec_map::VecMap<address, u64>,
        threshold: u64,
        proposal_count: u64,
        object_bag: 0x2::object_bag::ObjectBag,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ProposalKey has copy, drop, store {
        id: u64,
    }

    struct Proposal has store {
        id: u64,
        proposer: address,
        description: 0x1::string::String,
        action_type: u8,
        approvals: 0x2::vec_set::VecSet<address>,
        approval_weight: u64,
        status: u8,
        created_epoch: u64,
        expiration_epoch: u64,
    }

    struct CoinTransferKey has copy, drop, store {
        proposal_id: u64,
    }

    struct CoinTransferData has drop, store {
        recipients: vector<address>,
        amounts: vector<u64>,
    }

    struct ObjectTransferKey has copy, drop, store {
        proposal_id: u64,
    }

    struct ObjectTransferData has drop, store {
        object_ids: vector<0x2::object::ID>,
        recipients: vector<address>,
    }

    struct ConfigChangeKey has copy, drop, store {
        proposal_id: u64,
    }

    struct ConfigChangeData has drop, store {
        members_to_add: vector<address>,
        weights_to_add: vector<u64>,
        members_to_remove: vector<address>,
        new_threshold: u64,
    }

    public fun accept_object<T0: store + key>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_is_member(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg1);
        let v1 = 0x2::object::id<T0>(&v0);
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg0.object_bag, v1, v0);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_object_deposited(0x2::object::id<Vault>(arg0), v1, 0x2::tx_context::sender(arg2));
    }

    public fun action_coin_transfer() : u8 {
        0
    }

    public fun action_config_change() : u8 {
        2
    }

    public fun action_object_transfer() : u8 {
        1
    }

    entry fun approve(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_is_member(arg0, v0);
        let v1 = *0x2::vec_map::get<address, u64>(&arg0.members, &v0);
        let v2 = ProposalKey{id: arg1};
        let v3 = 0x2::dynamic_field::borrow_mut<ProposalKey, Proposal>(&mut arg0.id, v2);
        assert!(v3.status == 0, 1);
        assert!(0x2::tx_context::epoch(arg2) <= v3.expiration_epoch, 1);
        assert!(!0x2::vec_set::contains<address>(&v3.approvals, &v0), 5);
        0x2::vec_set::insert<address>(&mut v3.approvals, v0);
        v3.approval_weight = v3.approval_weight + v1;
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_approved(0x2::object::id<Vault>(arg0), arg1, v0, v1, v3.approval_weight, arg0.threshold);
    }

    fun assert_executable(arg0: &Vault, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        let v0 = ProposalKey{id: arg1};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0, 1);
        assert!(v1.approval_weight >= arg0.threshold, 1);
        assert!(0x2::tx_context::epoch(arg3) <= v1.expiration_epoch, 1);
        assert!(v1.action_type == arg2, 1);
    }

    fun assert_is_member(arg0: &Vault, arg1: address) {
        assert!(0x2::vec_map::contains<address, u64>(&arg0.members, &arg1), 0);
    }

    fun assert_vault_invariants(arg0: &Vault) {
        assert!(0x2::vec_map::length<address, u64>(&arg0.members) > 0, 2);
        assert!(arg0.threshold > 0, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u64>(&arg0.members)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.members, v1);
            assert!(*v3 > 0, 3);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        assert!(arg0.threshold <= v0, 1);
    }

    entry fun cancel_proposal(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = ProposalKey{id: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<ProposalKey, Proposal>(&mut arg0.id, v0);
        assert!(v1.status == 0, 1);
        assert!(v1.proposer == 0x2::tx_context::sender(arg2), 0);
        v1.status = 2;
        let v2 = v1.action_type;
        if (v2 == 0) {
            let v3 = CoinTransferKey{proposal_id: arg1};
            let CoinTransferData {
                recipients : _,
                amounts    : _,
            } = 0x2::dynamic_field::remove<CoinTransferKey, CoinTransferData>(&mut arg0.id, v3);
        } else if (v2 == 1) {
            let v6 = ObjectTransferKey{proposal_id: arg1};
            let ObjectTransferData {
                object_ids : _,
                recipients : _,
            } = 0x2::dynamic_field::remove<ObjectTransferKey, ObjectTransferData>(&mut arg0.id, v6);
        } else if (v2 == 2) {
            let v9 = ConfigChangeKey{proposal_id: arg1};
            let ConfigChangeData {
                members_to_add    : _,
                weights_to_add    : _,
                members_to_remove : _,
                new_threshold     : _,
            } = 0x2::dynamic_field::remove<ConfigChangeKey, ConfigChangeData>(&mut arg0.id, v9);
        };
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_cancelled(0x2::object::id<Vault>(arg0), arg1, 0x2::tx_context::sender(arg2));
    }

    public fun coin_balance<T0>(arg0: &Vault) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    fun create_proposal(arg0: &mut Vault, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.proposal_count;
        arg0.proposal_count = v0 + 1;
        let v1 = Proposal{
            id               : v0,
            proposer         : arg1,
            description      : arg2,
            action_type      : arg3,
            approvals        : 0x2::vec_set::empty<address>(),
            approval_weight  : 0,
            status           : 0,
            created_epoch    : 0x2::tx_context::epoch(arg5),
            expiration_epoch : arg4,
        };
        let v2 = ProposalKey{id: v0};
        0x2::dynamic_field::add<ProposalKey, Proposal>(&mut arg0.id, v2, v1);
        v0
    }

    entry fun create_vault(arg0: 0x1::string::String, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 4);
        let v1 = 0x2::vec_map::empty<address, u64>();
        let v2 = 0;
        let v3 = 0x2::vec_set::empty<address>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg1, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg2, v4);
            assert!(v6 > 0, 3);
            assert!(!0x2::vec_set::contains<address>(&v3, &v5), 5);
            0x2::vec_set::insert<address>(&mut v3, v5);
            0x2::vec_map::insert<address, u64>(&mut v1, v5, v6);
            v2 = v2 + v6;
            v4 = v4 + 1;
        };
        assert!(arg3 > 0, 1);
        assert!(arg3 <= v2, 1);
        let v7 = Vault{
            id             : 0x2::object::new(arg4),
            name           : arg0,
            members        : v1,
            threshold      : arg3,
            proposal_count : 0,
            object_bag     : 0x2::object_bag::new(arg4),
        };
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_vault_created(0x2::object::id<Vault>(&v7), arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
        0x2::transfer::share_object<Vault>(v7);
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_coin_deposited(0x2::object::id<Vault>(arg0), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), v0, 0x2::tx_context::sender(arg2));
    }

    entry fun execute_coin_transfer<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_executable(arg0, arg1, 0, arg2);
        let v0 = CoinTransferKey{proposal_id: arg1};
        let CoinTransferData {
            recipients : v1,
            amounts    : v2,
        } = 0x2::dynamic_field::remove<CoinTransferKey, CoinTransferData>(&mut arg0.id, v0);
        let v3 = v2;
        let v4 = v1;
        let v5 = CoinKey<T0>{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v5);
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v6, *0x1::vector::borrow<u64>(&v3, v7)), arg2), *0x1::vector::borrow<address>(&v4, v7));
            v7 = v7 + 1;
        };
        mark_executed(arg0, arg1);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_executed(0x2::object::id<Vault>(arg0), arg1, 0x2::tx_context::sender(arg2), 0);
    }

    entry fun execute_config_change(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_executable(arg0, arg1, 2, arg2);
        let v0 = ConfigChangeKey{proposal_id: arg1};
        let ConfigChangeData {
            members_to_add    : v1,
            weights_to_add    : v2,
            members_to_remove : v3,
            new_threshold     : v4,
        } = 0x2::dynamic_field::remove<ConfigChangeKey, ConfigChangeData>(&mut arg0.id, v0);
        let v5 = v3;
        let v6 = v2;
        let v7 = v1;
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v5)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.members, 0x1::vector::borrow<address>(&v5, v8));
            v8 = v8 + 1;
        };
        v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v7)) {
            if (0x2::vec_map::contains<address, u64>(&arg0.members, 0x1::vector::borrow<address>(&v7, v8))) {
                *0x2::vec_map::get_mut<address, u64>(&mut arg0.members, 0x1::vector::borrow<address>(&v7, v8)) = *0x1::vector::borrow<u64>(&v6, v8);
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.members, *0x1::vector::borrow<address>(&v7, v8), *0x1::vector::borrow<u64>(&v6, v8));
            };
            v8 = v8 + 1;
        };
        arg0.threshold = v4;
        assert_vault_invariants(arg0);
        mark_executed(arg0, arg1);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_members_changed(0x2::object::id<Vault>(arg0), arg1, v7, v5, v4);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_executed(0x2::object::id<Vault>(arg0), arg1, 0x2::tx_context::sender(arg2), 2);
    }

    public fun execute_single_object_transfer<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = ProposalKey{id: arg1};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0 || v1.status == 1, 1);
        if (v1.status == 0) {
            assert!(v1.approval_weight >= arg0.threshold, 1);
            assert!(0x2::tx_context::epoch(arg3) <= v1.expiration_epoch, 1);
            assert!(v1.action_type == 1, 1);
        };
        let v2 = ObjectTransferKey{proposal_id: arg1};
        let v3 = 0x2::dynamic_field::borrow<ObjectTransferKey, ObjectTransferData>(&arg0.id, v2);
        let (v4, v5) = find_id_in_vector(&v3.object_ids, &arg2);
        assert!(v4, 6);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg0.object_bag, arg2), *0x1::vector::borrow<address>(&v3.recipients, v5));
    }

    entry fun finalize_object_transfer(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_executable(arg0, arg1, 1, arg2);
        let v0 = ObjectTransferKey{proposal_id: arg1};
        let ObjectTransferData {
            object_ids : _,
            recipients : _,
        } = 0x2::dynamic_field::remove<ObjectTransferKey, ObjectTransferData>(&mut arg0.id, v0);
        mark_executed(arg0, arg1);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_executed(0x2::object::id<Vault>(arg0), arg1, 0x2::tx_context::sender(arg2), 1);
    }

    fun find_id_in_vector(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun has_object(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::object_bag::contains<0x2::object::ID>(&arg0.object_bag, arg1)
    }

    public fun is_member(arg0: &Vault, arg1: address) : bool {
        0x2::vec_map::contains<address, u64>(&arg0.members, &arg1)
    }

    fun mark_executed(arg0: &mut Vault, arg1: u64) {
        let v0 = ProposalKey{id: arg1};
        0x2::dynamic_field::borrow_mut<ProposalKey, Proposal>(&mut arg0.id, v0).status = 1;
    }

    public fun member_weight(arg0: &Vault, arg1: address) : u64 {
        *0x2::vec_map::get<address, u64>(&arg0.members, &arg1)
    }

    public fun proposal_action_type(arg0: &Vault, arg1: u64) : u8 {
        let v0 = ProposalKey{id: arg1};
        0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0).action_type
    }

    public fun proposal_approval_weight(arg0: &Vault, arg1: u64) : u64 {
        let v0 = ProposalKey{id: arg1};
        0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0).approval_weight
    }

    public fun proposal_status(arg0: &Vault, arg1: u64) : u8 {
        let v0 = ProposalKey{id: arg1};
        0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0).status
    }

    entry fun propose_coin_transfer<T0>(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_is_member(arg0, v0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        assert!(0x1::vector::length<address>(&arg2) > 0, 2);
        assert!(arg4 > 0x2::tx_context::epoch(arg5), 1);
        let v1 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v1), 6);
        assert!(0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1)) >= sum_vector(&arg3), 6);
        let v2 = create_proposal(arg0, v0, arg1, 0, arg4, arg5);
        let v3 = CoinTransferKey{proposal_id: v2};
        let v4 = CoinTransferData{
            recipients : arg2,
            amounts    : arg3,
        };
        0x2::dynamic_field::add<CoinTransferKey, CoinTransferData>(&mut arg0.id, v3, v4);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_created(0x2::object::id<Vault>(arg0), v2, 0, v0, arg1, arg4);
    }

    entry fun propose_config_change(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<address>, arg3: vector<u64>, arg4: vector<address>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_is_member(arg0, v0);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        assert!(arg6 > 0x2::tx_context::epoch(arg7), 1);
        assert!(arg5 > 0, 1);
        validate_config_change(arg0, &arg2, &arg3, &arg4, arg5);
        let v1 = create_proposal(arg0, v0, arg1, 2, arg6, arg7);
        let v2 = ConfigChangeKey{proposal_id: v1};
        let v3 = ConfigChangeData{
            members_to_add    : arg2,
            weights_to_add    : arg3,
            members_to_remove : arg4,
            new_threshold     : arg5,
        };
        0x2::dynamic_field::add<ConfigChangeKey, ConfigChangeData>(&mut arg0.id, v2, v3);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_created(0x2::object::id<Vault>(arg0), v1, 2, v0, arg1, arg6);
    }

    entry fun propose_object_transfer(arg0: &mut Vault, arg1: 0x1::string::String, arg2: vector<0x2::object::ID>, arg3: vector<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_is_member(arg0, v0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<address>(&arg3), 4);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) > 0, 2);
        assert!(arg4 > 0x2::tx_context::epoch(arg5), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            assert!(0x2::object_bag::contains<0x2::object::ID>(&arg0.object_bag, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1)), 6);
            v1 = v1 + 1;
        };
        let v2 = create_proposal(arg0, v0, arg1, 1, arg4, arg5);
        let v3 = ObjectTransferKey{proposal_id: v2};
        let v4 = ObjectTransferData{
            object_ids : arg2,
            recipients : arg3,
        };
        0x2::dynamic_field::add<ObjectTransferKey, ObjectTransferData>(&mut arg0.id, v3, v4);
        0x7245087ea4ca1ddf74bff2f6a137e310312e8526b872d620e1c73544ce4e8c8c::events::emit_proposal_created(0x2::object::id<Vault>(arg0), v2, 1, v0, arg1, arg4);
    }

    public fun status_cancelled() : u8 {
        2
    }

    public fun status_executed() : u8 {
        1
    }

    public fun status_pending() : u8 {
        0
    }

    fun sum_vector(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun validate_config_change(arg0: &Vault, arg1: &vector<address>, arg2: &vector<u64>, arg3: &vector<address>, arg4: u64) {
        let v0 = 0;
        let v1 = 0x2::vec_map::length<address, u64>(&arg0.members);
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<address, u64>(&arg0.members)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.members, v2);
            let v5 = false;
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(arg3)) {
                if (*v3 == *0x1::vector::borrow<address>(arg3, v6)) {
                    v5 = true;
                    break
                };
                v6 = v6 + 1;
            };
            if (!v5) {
                v0 = v0 + *v4;
            } else {
                v1 = v1 - 1;
            };
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 0x1::vector::length<address>(arg1)) {
            let v7 = *0x1::vector::borrow<u64>(arg2, v2);
            assert!(v7 > 0, 3);
            if (!0x2::vec_map::contains<address, u64>(&arg0.members, 0x1::vector::borrow<address>(arg1, v2))) {
                v1 = v1 + 1;
                v0 = v0 + v7;
            } else {
                let v8 = v0 - *0x2::vec_map::get<address, u64>(&arg0.members, 0x1::vector::borrow<address>(arg1, v2));
                v0 = v8 + v7;
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 2);
        assert!(arg4 > 0, 1);
        assert!(arg4 <= v0, 1);
    }

    public fun vault_members(arg0: &Vault) : &0x2::vec_map::VecMap<address, u64> {
        &arg0.members
    }

    public fun vault_name(arg0: &Vault) : &0x1::string::String {
        &arg0.name
    }

    public fun vault_proposal_count(arg0: &Vault) : u64 {
        arg0.proposal_count
    }

    public fun vault_threshold(arg0: &Vault) : u64 {
        arg0.threshold
    }

    // decompiled from Move bytecode v6
}

