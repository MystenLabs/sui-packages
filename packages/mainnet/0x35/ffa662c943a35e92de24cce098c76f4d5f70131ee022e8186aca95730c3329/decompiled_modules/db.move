module 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db {
    struct PublishedEvent has copy, drop {
        db: 0x2::object::ID,
        manager_badge: 0x2::object::ID,
    }

    struct NodeRegisteredEvent has copy, drop {
        badge_id: 0x2::object::ID,
        node_small_id: SmallId,
    }

    struct NodeSubscribedToModelEvent has copy, drop {
        node_small_id: SmallId,
        model_name: 0x1::ascii::String,
        echelon_id: EchelonId,
    }

    struct AtomaManagerBadge has store, key {
        id: 0x2::object::UID,
    }

    struct NodeBadge has store, key {
        id: 0x2::object::UID,
        small_id: SmallId,
    }

    struct SmallId has copy, drop, store {
        inner: u64,
    }

    struct AtomaDb has key {
        id: 0x2::object::UID,
        tickets: 0x2::object::UID,
        next_node_small_id: SmallId,
        nodes: 0x2::table::Table<SmallId, NodeEntry>,
        models: 0x2::object_table::ObjectTable<0x1::ascii::String, ModelEntry>,
        fee_treasury: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>,
        communal_treasury: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>,
        cross_validation_probability_permille: u64,
        cross_validation_extra_nodes_count: u64,
        is_registration_disabled: bool,
        registration_collateral_in_protocol_token: u64,
        permille_to_slash_node_on_timeout: u64,
        permille_for_oracle_on_dispute: u64,
        permille_for_honest_nodes_on_dispute: u64,
    }

    struct NodeEntry has store {
        was_disabled_in_epoch: 0x1::option::Option<u64>,
        collateral: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>,
        last_fee_epoch: u64,
        last_fee_epoch_amount: u64,
        available_fee_amount: u64,
    }

    struct ModelEntry has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        modality: u64,
        is_disabled: bool,
        echelons: vector<ModelEchelon>,
    }

    struct ModelEchelon has store {
        id: EchelonId,
        settlement_timeout_ms: u64,
        input_fee_per_token: u64,
        output_fee_per_token: u64,
        relative_performance: u64,
        oracles: 0x2::vec_set::VecSet<SmallId>,
        nodes: 0x2::table_vec::TableVec<SmallId>,
    }

    struct EchelonId has copy, drop, store {
        id: u64,
    }

    public fun add_model(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: ModelEntry) {
        0x2::object_table::add<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2.name, arg2);
    }

    public fun add_model_echelon(arg0: &AtomaManagerBadge, arg1: &mut ModelEntry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 312012003);
        assert!(arg4 > 0, 312012003);
        assert!(arg5 > 0, 312012004);
        let v0 = EchelonId{id: arg2};
        assert!(!contains_echelon(&arg1.echelons, v0), 312012006);
        let v1 = ModelEchelon{
            id                    : v0,
            settlement_timeout_ms : 60000,
            input_fee_per_token   : arg3,
            output_fee_per_token  : arg4,
            relative_performance  : arg5,
            oracles               : 0x2::vec_set::empty<SmallId>(),
            nodes                 : 0x2::table_vec::empty<SmallId>(arg6),
        };
        0x1::vector::push_back<ModelEchelon>(&mut arg1.echelons, v1);
    }

    public entry fun add_model_echelon_entry(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2);
        add_model_echelon(arg1, v0, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun add_model_echelon_oracle_node(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = EchelonId{id: arg3};
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        let v2 = SmallId{inner: arg4};
        0x2::vec_set::insert<SmallId>(&mut get_echelon_mut(v1, v0).oracles, v2);
    }

    public entry fun add_model_entry(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        add_model(arg0, arg1, create_model(arg1, arg2, arg3, arg4));
    }

    public entry fun add_node_to_model(arg0: &mut AtomaDb, arg1: &mut NodeBadge, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2);
        assert!(!v0.is_disabled, 312012001);
        assert!(!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, arg2), 312012009);
        let v1 = EchelonId{id: arg3};
        let v2 = &mut v0.echelons;
        0x2::table_vec::push_back<SmallId>(&mut get_echelon_mut(v2, v1).nodes, arg1.small_id);
        0x2::dynamic_field::add<0x1::ascii::String, EchelonId>(&mut arg1.id, arg2, v1);
        let v3 = NodeSubscribedToModelEvent{
            node_small_id : arg1.small_id,
            model_name    : arg2,
            echelon_id    : v1,
        };
        0x2::event::emit<NodeSubscribedToModelEvent>(v3);
    }

    public(friend) fun attribute_fee_to_node(arg0: &mut AtomaDb, arg1: SmallId, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<SmallId, NodeEntry>(&arg0.nodes, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<SmallId, NodeEntry>(&mut arg0.nodes, arg1);
        let v1 = 0x2::tx_context::epoch(arg3);
        if (v0.last_fee_epoch == v1) {
            v0.last_fee_epoch_amount = v0.last_fee_epoch_amount + arg2;
        } else {
            v0.available_fee_amount = v0.available_fee_amount + v0.last_fee_epoch_amount;
            v0.last_fee_epoch_amount = arg2;
            v0.last_fee_epoch = v1;
        };
    }

    fun contains_echelon(arg0: &vector<ModelEchelon>, arg1: EchelonId) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ModelEchelon>(arg0)) {
            if (0x1::vector::borrow<ModelEchelon>(arg0, v0).id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_manager_badge(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AtomaManagerBadge {
        assert!(0x2::package::from_module<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::atoma::ATOMA>(arg0), 312012002);
        AtomaManagerBadge{id: 0x2::object::new(arg1)}
    }

    public entry fun create_manager_badge_entry(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_manager_badge(arg0, arg1);
        0x2::transfer::transfer<AtomaManagerBadge>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_model(arg0: &AtomaManagerBadge, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ModelEntry {
        ModelEntry{
            id          : 0x2::object::new(arg3),
            name        : arg1,
            modality    : arg2,
            is_disabled : false,
            echelons    : 0x1::vector::empty<ModelEchelon>(),
        }
    }

    public(friend) fun deposit_fee_to_node(arg0: &mut AtomaDb, arg1: SmallId, arg2: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>, arg3: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<SmallId, NodeEntry>(&arg0.nodes, arg1)) {
            deposit_to_communal_treasury(arg0, arg2);
        } else {
            attribute_fee_to_node(arg0, arg1, 0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&arg2), arg3);
            0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut arg0.fee_treasury, arg2);
        };
    }

    public(friend) fun deposit_to_communal_treasury(arg0: &mut AtomaDb, arg1: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>) {
        0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut arg0.communal_treasury, arg1);
    }

    public(friend) fun deposit_to_fee_treasury(arg0: &mut AtomaDb, arg1: 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>) {
        0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut arg0.fee_treasury, arg1);
    }

    public entry fun destroy_disabled_node(arg0: &mut AtomaDb, arg1: NodeBadge, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_fees(arg0, &arg1, arg2);
        let NodeEntry {
            was_disabled_in_epoch : v0,
            collateral            : v1,
            last_fee_epoch        : _,
            last_fee_epoch_amount : _,
            available_fee_amount  : _,
        } = 0x2::table::remove<SmallId, NodeEntry>(&mut arg0.nodes, arg1.small_id);
        let v5 = v0;
        assert!(0x1::option::extract<u64>(&mut v5) + 2 <= 0x2::tx_context::epoch(arg2), 312012013);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>>(0x2::coin::from_balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(v1, arg2), 0x2::tx_context::sender(arg2));
        let NodeBadge {
            id       : v6,
            small_id : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    public entry fun disable_model(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String) {
        0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).is_disabled = true;
    }

    public entry fun disable_registration(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge) {
        arg0.is_registration_disabled = true;
    }

    public entry fun enable_model(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String) {
        0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).is_disabled = false;
    }

    public entry fun enable_registration(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge) {
        arg0.is_registration_disabled = false;
    }

    public fun get_cross_validation_extra_nodes_count(arg0: &AtomaDb) : u64 {
        arg0.cross_validation_extra_nodes_count
    }

    public fun get_cross_validation_probability_permille(arg0: &AtomaDb) : u64 {
        arg0.cross_validation_probability_permille
    }

    fun get_echelon(arg0: &vector<ModelEchelon>, arg1: EchelonId) : &ModelEchelon {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ModelEchelon>(arg0)) {
            let v1 = 0x1::vector::borrow<ModelEchelon>(arg0, v0);
            if (v1.id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 312012005
    }

    fun get_echelon_mut(arg0: &mut vector<ModelEchelon>, arg1: EchelonId) : &mut ModelEchelon {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ModelEchelon>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<ModelEchelon>(arg0, v0);
            if (v1.id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 312012005
    }

    public fun get_model_echelon(arg0: &AtomaDb, arg1: 0x1::ascii::String, arg2: EchelonId) : &ModelEchelon {
        get_echelon(&0x2::object_table::borrow<0x1::ascii::String, ModelEntry>(&arg0.models, arg1).echelons, arg2)
    }

    public fun get_model_echelon_fees(arg0: &ModelEchelon) : (u64, u64) {
        (arg0.input_fee_per_token, arg0.output_fee_per_token)
    }

    public fun get_model_echelon_id(arg0: &ModelEchelon) : EchelonId {
        arg0.id
    }

    public fun get_model_echelon_nodes(arg0: &ModelEchelon) : &0x2::table_vec::TableVec<SmallId> {
        &arg0.nodes
    }

    public fun get_model_echelon_performance(arg0: &ModelEchelon) : u64 {
        arg0.relative_performance
    }

    public fun get_model_echelon_settlement_timeout_ms(arg0: &ModelEchelon) : u64 {
        arg0.settlement_timeout_ms
    }

    public fun get_model_echelons_if_enabled(arg0: &AtomaDb, arg1: 0x1::ascii::String) : &vector<ModelEchelon> {
        let v0 = 0x2::object_table::borrow<0x1::ascii::String, ModelEntry>(&arg0.models, arg1);
        assert!(!v0.is_disabled, 312012001);
        &v0.echelons
    }

    public fun get_model_modality(arg0: &AtomaDb, arg1: 0x1::ascii::String) : u64 {
        0x2::object_table::borrow<0x1::ascii::String, ModelEntry>(&arg0.models, arg1).modality
    }

    public fun get_node_id(arg0: &NodeBadge) : SmallId {
        arg0.small_id
    }

    fun get_node_id_if_unslashed_or_swap_remove(arg0: &0x2::table::Table<SmallId, NodeEntry>, arg1: &mut 0x2::table_vec::TableVec<SmallId>, arg2: u64) : 0x1::option::Option<SmallId> {
        let v0 = *0x2::table_vec::borrow<SmallId>(arg1, arg2);
        if (0x2::table::contains<SmallId, NodeEntry>(arg0, v0)) {
            let v1 = 0x2::table::borrow<SmallId, NodeEntry>(arg0, v0);
            if (0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&v1.collateral) > 0 && 0x1::option::is_none<u64>(&v1.was_disabled_in_epoch)) {
                return 0x1::option::some<SmallId>(v0)
            };
        };
        0x2::table_vec::swap_remove<SmallId>(arg1, arg2);
        0x1::option::none<SmallId>()
    }

    public fun get_opaque_inner_id(arg0: SmallId) : u64 {
        arg0.inner
    }

    public fun get_permille_for_honest_nodes_on_dispute(arg0: &AtomaDb) : u64 {
        arg0.permille_for_honest_nodes_on_dispute
    }

    public fun get_permille_for_oracle_on_dispute(arg0: &AtomaDb) : u64 {
        arg0.permille_for_oracle_on_dispute
    }

    public(friend) fun get_tickets_uid_mut(arg0: &mut AtomaDb) : &mut 0x2::object::UID {
        &mut arg0.tickets
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SmallId{inner: 1};
        let v1 = AtomaDb{
            id                                        : 0x2::object::new(arg0),
            tickets                                   : 0x2::object::new(arg0),
            next_node_small_id                        : v0,
            nodes                                     : 0x2::table::new<SmallId, NodeEntry>(arg0),
            models                                    : 0x2::object_table::new<0x1::ascii::String, ModelEntry>(arg0),
            fee_treasury                              : 0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(),
            communal_treasury                         : 0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(),
            cross_validation_probability_permille     : 10,
            cross_validation_extra_nodes_count        : 1,
            is_registration_disabled                  : false,
            registration_collateral_in_protocol_token : 1000,
            permille_to_slash_node_on_timeout         : 100,
            permille_for_oracle_on_dispute            : 100,
            permille_for_honest_nodes_on_dispute      : 200,
        };
        let v2 = AtomaManagerBadge{id: 0x2::object::new(arg0)};
        let v3 = PublishedEvent{
            db            : 0x2::object::id<AtomaDb>(&v1),
            manager_badge : 0x2::object::id<AtomaManagerBadge>(&v2),
        };
        0x2::event::emit<PublishedEvent>(v3);
        0x2::transfer::share_object<AtomaDb>(v1);
        0x2::transfer::transfer<AtomaManagerBadge>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_oracle(arg0: &AtomaDb, arg1: 0x1::ascii::String, arg2: EchelonId, arg3: SmallId) : bool {
        0x2::vec_set::contains<SmallId>(&get_echelon(&0x2::object_table::borrow<0x1::ascii::String, ModelEntry>(&arg0.models, arg1).echelons, arg2).oracles, &arg3)
    }

    public entry fun permanently_disable_node(arg0: &mut AtomaDb, arg1: &NodeBadge, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<SmallId, NodeEntry>(&mut arg0.nodes, arg1.small_id);
        assert!(0x1::option::is_none<u64>(&v0.was_disabled_in_epoch), 312012012);
        v0.was_disabled_in_epoch = 0x1::option::some<u64>(0x2::tx_context::epoch(arg2));
    }

    public(friend) fun refund_to_user(arg0: &mut AtomaDb, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>>(0x2::coin::from_balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut arg0.fee_treasury, arg2), arg3), arg1);
        };
    }

    public fun register_node(arg0: &mut AtomaDb, arg1: &mut 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>, arg2: &mut 0x2::tx_context::TxContext) : NodeBadge {
        assert!(!arg0.is_registration_disabled, 312012000);
        let v0 = arg0.next_node_small_id;
        arg0.next_node_small_id.inner = arg0.next_node_small_id.inner + 1;
        let v1 = NodeEntry{
            was_disabled_in_epoch : 0x1::option::none<u64>(),
            collateral            : 0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(arg1, arg0.registration_collateral_in_protocol_token),
            last_fee_epoch        : 0x2::tx_context::epoch(arg2),
            last_fee_epoch_amount : 0,
            available_fee_amount  : 0,
        };
        0x2::table::add<SmallId, NodeEntry>(&mut arg0.nodes, v0, v1);
        let v2 = 0x2::object::new(arg2);
        let v3 = NodeRegisteredEvent{
            badge_id      : 0x2::object::uid_to_inner(&v2),
            node_small_id : v0,
        };
        0x2::event::emit<NodeRegisteredEvent>(v3);
        NodeBadge{
            id       : v2,
            small_id : v0,
        }
    }

    public entry fun register_node_entry(arg0: &mut AtomaDb, arg1: &mut 0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(arg1);
        let v1 = register_node(arg0, v0, arg2);
        0x2::transfer::transfer<NodeBadge>(v1, 0x2::tx_context::sender(arg2));
    }

    fun remove_echelon(arg0: &mut vector<ModelEchelon>, arg1: EchelonId) : ModelEchelon {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ModelEchelon>(arg0)) {
            if (0x1::vector::borrow<ModelEchelon>(arg0, v0).id == arg1) {
                return 0x1::vector::swap_remove<ModelEchelon>(arg0, v0)
            };
            v0 = v0 + 1;
        };
        abort 312012005
    }

    public entry fun remove_model(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String) {
        let ModelEntry {
            id          : v0,
            name        : _,
            modality    : _,
            is_disabled : _,
            echelons    : v4,
        } = 0x2::object_table::remove<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2);
        let v5 = v4;
        0x2::object::delete(v0);
        while (0 < 0x1::vector::length<ModelEchelon>(&v5)) {
            let ModelEchelon {
                id                    : _,
                settlement_timeout_ms : _,
                input_fee_per_token   : _,
                output_fee_per_token  : _,
                relative_performance  : _,
                oracles               : _,
                nodes                 : v12,
            } = 0x1::vector::pop_back<ModelEchelon>(&mut v5);
            0x2::table_vec::drop<SmallId>(v12);
        };
        0x1::vector::destroy_empty<ModelEchelon>(v5);
    }

    public entry fun remove_model_echelon(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = EchelonId{id: arg3};
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        let ModelEchelon {
            id                    : _,
            settlement_timeout_ms : _,
            input_fee_per_token   : _,
            output_fee_per_token  : _,
            relative_performance  : _,
            oracles               : _,
            nodes                 : v8,
        } = remove_echelon(v1, v0);
        0x2::table_vec::drop<SmallId>(v8);
    }

    public entry fun remove_model_echelon_oracle_node(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = EchelonId{id: arg3};
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        let v2 = SmallId{inner: arg4};
        0x2::vec_set::remove<SmallId>(&mut get_echelon_mut(v1, v0).oracles, &v2);
    }

    public entry fun remove_node_from_model(arg0: &mut AtomaDb, arg1: &mut NodeBadge, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = 0x2::dynamic_field::remove_if_exists<0x1::ascii::String, EchelonId>(&mut arg1.id, arg2);
        assert!(0x1::option::is_some<EchelonId>(&v0), 312012010);
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        let v2 = get_echelon_mut(v1, 0x1::option::extract<EchelonId>(&mut v0));
        assert!(0x2::table_vec::length<SmallId>(&v2.nodes) > arg3, 312012011);
        assert!(0x2::table_vec::swap_remove<SmallId>(&mut v2.nodes, arg3) == arg1.small_id, 312012011);
    }

    fun sample_node(arg0: &0x2::table::Table<SmallId, NodeEntry>, arg1: &mut 0x2::table_vec::TableVec<SmallId>, arg2: &mut 0x2::random::RandomGenerator) : 0x1::option::Option<SmallId> {
        let v0;
        let v1;
        loop {
            let v2 = 0x2::table_vec::length<SmallId>(arg1);
            if (v2 == 0) {
                let v3 = b"All echelon nodes have been slashed";
                0x1::debug::print<vector<u8>>(&v3);
                v1 = 0x1::option::none<SmallId>();
                return v1
            };
            let v4 = 0x2::random::generate_u64(arg2) % v2;
            v0 = *0x2::table_vec::borrow<SmallId>(arg1, v4);
            if (0x2::table::contains<SmallId, NodeEntry>(arg0, v0)) {
                let v5 = 0x2::table::borrow<SmallId, NodeEntry>(arg0, v0);
                if (0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&v5.collateral) > 0 && 0x1::option::is_none<u64>(&v5.was_disabled_in_epoch)) {
                    break
                };
            };
            0x2::table_vec::swap_remove<SmallId>(arg1, v4);
        };
        v1 = 0x1::option::some<SmallId>(v0);
        v1
    }

    public(friend) fun sample_node_by_echelon_id(arg0: &mut AtomaDb, arg1: 0x1::ascii::String, arg2: EchelonId, arg3: &mut 0x2::random::RandomGenerator) : 0x1::option::Option<SmallId> {
        let v0 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg1).echelons;
        let v1 = &mut get_echelon_mut(v0, arg2).nodes;
        sample_node(&arg0.nodes, v1, arg3)
    }

    fun sample_unique_nodes(arg0: &0x2::table::Table<SmallId, NodeEntry>, arg1: &mut 0x2::table_vec::TableVec<SmallId>, arg2: u64, arg3: &mut 0x2::random::RandomGenerator) : vector<SmallId> {
        assert!(arg2 > 0, 312012014);
        let v0 = 0x1::vector::empty<SmallId>();
        let v1 = 0x2::table_vec::length<SmallId>(arg1);
        let v2 = v1 % arg2;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = if (v2 > 0) {
                v2 = v2 - 1;
                1
            } else {
                0
            };
            let v5 = v1 / arg2 + v4;
            let v6 = get_node_id_if_unslashed_or_swap_remove(arg0, arg1, v1 - 1 - v3 + 0x2::random::generate_u64(arg3) % v5);
            if (0x1::option::is_some<SmallId>(&v6)) {
                0x1::vector::push_back<SmallId>(&mut v0, 0x1::option::extract<SmallId>(&mut v6));
            };
            v3 = v3 + v5;
        };
        if (0x1::vector::length<SmallId>(&v0) == arg2) {
            v0
        } else {
            let v8 = 0x1::vector::empty<SmallId>();
            let v9 = 0;
            while (0x1::vector::length<SmallId>(&v8) < arg2 || v9 <= arg2 * 4) {
                let v10 = sample_node(arg0, arg1, arg3);
                if (0x1::option::is_none<SmallId>(&v10)) {
                    return v8
                };
                let v11 = 0x1::option::extract<SmallId>(&mut v10);
                if (!0x1::vector::contains<SmallId>(&v8, &v11)) {
                    0x1::vector::push_back<SmallId>(&mut v8, v11);
                };
                v9 = v9 + 1;
            };
            v8
        }
    }

    public(friend) fun sample_unique_nodes_by_echelon_id(arg0: &mut AtomaDb, arg1: 0x1::ascii::String, arg2: EchelonId, arg3: u64, arg4: &mut 0x2::random::RandomGenerator) : vector<SmallId> {
        let v0 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg1).echelons;
        let v1 = &mut get_echelon_mut(v0, arg2).nodes;
        sample_unique_nodes(&arg0.nodes, v1, arg3, arg4)
    }

    public(friend) fun sample_unique_nodes_by_echelon_index(arg0: &mut AtomaDb, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: &mut 0x2::random::RandomGenerator) : vector<SmallId> {
        let v0 = &mut 0x1::vector::borrow_mut<ModelEchelon>(&mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg1).echelons, arg2).nodes;
        sample_unique_nodes(&arg0.nodes, v0, arg3, arg4)
    }

    public entry fun set_cross_validation_extra_nodes_count(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        arg0.cross_validation_extra_nodes_count = arg2;
    }

    public entry fun set_cross_validation_probability_permille(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        arg0.cross_validation_probability_permille = arg2;
    }

    public entry fun set_model_echelon_fee(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = EchelonId{id: arg3};
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        let v2 = get_echelon_mut(v1, v0);
        v2.input_fee_per_token = arg4;
        v2.output_fee_per_token = arg5;
    }

    public entry fun set_model_echelon_settlement_timeout_ms(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = EchelonId{id: arg3};
        let v1 = &mut 0x2::object_table::borrow_mut<0x1::ascii::String, ModelEntry>(&mut arg0.models, arg2).echelons;
        get_echelon_mut(v1, v0).settlement_timeout_ms = arg4;
    }

    public entry fun set_permille_for_honest_nodes_on_dispute(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        assert!(arg2 + arg0.permille_for_oracle_on_dispute <= 1000, 312012007);
        arg0.permille_for_honest_nodes_on_dispute = arg2;
    }

    public entry fun set_permille_for_oracle_on_dispute(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        assert!(arg2 + arg0.permille_for_honest_nodes_on_dispute <= 1000, 312012007);
        arg0.permille_for_oracle_on_dispute = arg2;
    }

    public entry fun set_permille_to_slash_node_on_timeout(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        assert!(arg2 <= 1000, 312012007);
        arg0.permille_to_slash_node_on_timeout = arg2;
    }

    public entry fun set_required_registration_toma_collateral(arg0: &mut AtomaDb, arg1: &AtomaManagerBadge, arg2: u64) {
        arg0.registration_collateral_in_protocol_token = arg2;
    }

    public(friend) fun slash_node_on_dispute(arg0: &mut AtomaDb, arg1: SmallId) : 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA> {
        if (!0x2::table::contains<SmallId, NodeEntry>(&arg0.nodes, arg1)) {
            0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>()
        } else {
            0x2::balance::withdraw_all<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut 0x2::table::borrow_mut<SmallId, NodeEntry>(&mut arg0.nodes, arg1).collateral)
        }
    }

    public(friend) fun slash_node_on_timeout(arg0: &mut AtomaDb, arg1: SmallId) : 0x2::balance::Balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA> {
        if (!0x2::table::contains<SmallId, NodeEntry>(&arg0.nodes, arg1)) {
            return 0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>()
        };
        let v0 = 0x2::table::borrow_mut<SmallId, NodeEntry>(&mut arg0.nodes, arg1);
        let v1 = 0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&v0.collateral);
        if (v1 == 0) {
            0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>()
        } else {
            0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v0.collateral, 0x1::u64::divide_and_round_up(v1 * arg0.permille_to_slash_node_on_timeout, 1000))
        }
    }

    public entry fun withdraw_fees(arg0: &mut AtomaDb, arg1: &NodeBadge, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.small_id;
        attribute_fee_to_node(arg0, v0, 0, arg2);
        let v1 = 0x2::table::borrow_mut<SmallId, NodeEntry>(&mut arg0.nodes, v0);
        let v2 = v1.available_fee_amount;
        if (v2 > 0) {
            v1.available_fee_amount = 0;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>>(0x2::coin::from_balance<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut arg0.fee_treasury, v2), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

