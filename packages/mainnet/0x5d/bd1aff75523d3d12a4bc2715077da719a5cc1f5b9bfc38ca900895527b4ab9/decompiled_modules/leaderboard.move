module 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::leaderboard {
    struct TypusLeaderboardRegistry has key {
        id: 0x2::object::UID,
        active_leaderboard_registry: 0x2::object::UID,
        inactive_leaderboard_registry: 0x2::object::UID,
    }

    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        start_ts_ms: u64,
        end_ts_ms: u64,
        score: 0x2::table::Table<address, u64>,
        ranking: 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::CritbitTree<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>,
    }

    struct ActivateLeaderboardEvent has copy, drop {
        key: 0x1::ascii::String,
        id: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ExtendLeaderboardEvent has copy, drop {
        key: 0x1::ascii::String,
        id: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct DeactivateLeaderboardEvent has copy, drop {
        key: 0x1::ascii::String,
        id: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct RemoveLeaderboardEvent has copy, drop {
        key: 0x1::ascii::String,
        id: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct ScoreEvent has copy, drop {
        key: 0x1::ascii::String,
        id: address,
        user: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    public fun activate_leaderboard(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg5);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.active_leaderboard_registry, arg2)) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.active_leaderboard_registry, arg2, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::new<address, Leaderboard>(arg5));
        };
        let v0 = Leaderboard{
            id          : 0x2::object::new(arg5),
            start_ts_ms : arg3,
            end_ts_ms   : arg4,
            score       : 0x2::table::new<address, u64>(arg5),
            ranking     : 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::new<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(arg5),
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = ActivateLeaderboardEvent{
            key         : arg2,
            id          : 0x2::object::id_address<Leaderboard>(&v0),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ActivateLeaderboardEvent>(v3);
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::push_back<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.active_leaderboard_registry, arg2), 0x2::object::id_address<Leaderboard>(&v0), v0);
    }

    public fun deactivate_leaderboard(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg4);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.inactive_leaderboard_registry, arg2)) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.inactive_leaderboard_registry, arg2, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::new<address, Leaderboard>(arg4));
        };
        let v0 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::remove<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.active_leaderboard_registry, arg2), arg3);
        let v1 = DeactivateLeaderboardEvent{
            key         : arg2,
            id          : 0x2::object::id_address<Leaderboard>(&v0),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<DeactivateLeaderboardEvent>(v1);
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::push_back<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.inactive_leaderboard_registry, arg2), 0x2::object::id_address<Leaderboard>(&v0), v0);
    }

    public fun delegate_score(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::issue_manager_cap(arg0, arg6);
        let v1 = score(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::burn_manager_cap(arg0, v0, arg6);
        v1
    }

    public fun extend_leaderboard(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg5);
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::borrow_mut<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.active_leaderboard_registry, arg2), arg3).end_ts_ms = arg4;
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg4);
        let v1 = ExtendLeaderboardEvent{
            key         : arg2,
            id          : arg3,
            log         : v0,
            bcs_padding : vector[],
        };
        0x2::event::emit<ExtendLeaderboardEvent>(v1);
    }

    public(friend) fun get_rankings(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: address, arg6: bool) : vector<vector<u8>> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::version_check(arg0);
        let v0 = if (arg6) {
            &arg1.active_leaderboard_registry
        } else {
            &arg1.inactive_leaderboard_registry
        };
        let v1 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::borrow<address, Leaderboard>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(v0, arg2), arg3);
        if (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::is_empty<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking)) {
            let v2 = 0;
            let v3 = 0x1::vector::empty<vector<u8>>();
            0x1::vector::push_back<vector<u8>>(&mut v3, 0x2::bcs::to_bytes<u64>(&v2));
            return v3
        };
        let v4 = if (0x2::table::contains<address, u64>(&v1.score, arg5)) {
            let v5 = 0x1::vector::empty<vector<u8>>();
            0x1::vector::push_back<vector<u8>>(&mut v5, 0x2::bcs::to_bytes<u64>(0x2::table::borrow<address, u64>(&v1.score, arg5)));
            v5
        } else {
            let v6 = 0;
            let v7 = 0x1::vector::empty<vector<u8>>();
            0x1::vector::push_back<vector<u8>>(&mut v7, 0x2::bcs::to_bytes<u64>(&v6));
            v7
        };
        let v8 = v4;
        let (v9, v10) = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::max_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking);
        let v11 = v9;
        let v12 = 0x2::bcs::to_bytes<u64>(&v11);
        let v13 = vector[];
        let v14 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking, v10);
        let v15 = *0x1::option::borrow<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::front<address>(v14));
        while (arg4 > 0) {
            0x1::vector::push_back<address>(&mut v13, v15);
            arg4 = arg4 - 1;
            let v16 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::next<address>(v14, v15);
            if (0x1::option::is_some<address>(v16)) {
                v15 = *0x1::option::borrow<address>(v16);
                continue
            };
            0x1::vector::append<u8>(&mut v12, 0x2::bcs::to_bytes<vector<address>>(&v13));
            0x1::vector::push_back<vector<u8>>(&mut v8, v12);
            let (v17, v18) = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::previous_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking, v11);
            if (v17 == 0) {
                break
            };
            v11 = v17;
            v12 = 0x2::bcs::to_bytes<u64>(&v11);
            v13 = vector[];
            let v19 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking, v18);
            v14 = v19;
            v15 = *0x1::option::borrow<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::front<address>(v19));
        };
        v8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TypusLeaderboardRegistry{
            id                            : 0x2::object::new(arg0),
            active_leaderboard_registry   : 0x2::object::new(arg0),
            inactive_leaderboard_registry : 0x2::object::new(arg0),
        };
        0x2::transfer::share_object<TypusLeaderboardRegistry>(v0);
    }

    public fun remove_leaderboard(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg4);
        let Leaderboard {
            id          : v0,
            start_ts_ms : _,
            end_ts_ms   : _,
            score       : v3,
            ranking     : v4,
        } = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::remove<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg1.inactive_leaderboard_registry, arg2), arg3);
        let v5 = v4;
        let v6 = v0;
        let v7 = RemoveLeaderboardEvent{
            key         : arg2,
            id          : 0x2::object::uid_to_address(&v6),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<RemoveLeaderboardEvent>(v7);
        0x2::object::delete(v6);
        0x2::table::drop<address, u64>(v3);
        while (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::size<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v5) > 0) {
            0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::drop<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::remove_min_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v5));
        };
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::destroy_empty<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(v5);
    }

    public fun score(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::ManagerCap, arg1: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg2: &mut TypusLeaderboardRegistry, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::version_check(arg1);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg2.active_leaderboard_registry, arg3) || arg5 == 0) {
            return vector[0]
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(&mut arg2.active_leaderboard_registry, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = *0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::front<address, Leaderboard>(v0);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = 0x1::option::destroy_some<address>(v2);
            let v4 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::borrow_mut<address, Leaderboard>(v0, v3);
            if (v1 >= v4.start_ts_ms && v1 < v4.end_ts_ms) {
                if (!0x2::table::contains<address, u64>(&v4.score, arg4)) {
                    0x2::table::add<address, u64>(&mut v4.score, arg4, 0);
                };
                let v5 = 0x2::table::borrow_mut<address, u64>(&mut v4.score, arg4);
                let (v6, v7) = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::find_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v4.ranking, *v5);
                if (v6) {
                    if (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::length<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_mut_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v4.ranking, v7)) == 1) {
                        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::drop<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::remove_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v4.ranking, v7));
                    } else {
                        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::remove<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_mut_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v4.ranking, v7), arg4);
                    };
                };
                *v5 = *v5 + arg5;
                let (v8, v9) = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::find_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v4.ranking, *v5);
                let v10 = v9;
                if (!v8) {
                    v10 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::insert_leaf<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v4.ranking, *v5, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::new<address>(arg7));
                };
                0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::push_back<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_mut_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v4.ranking, v10), arg4);
                let v11 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v11, arg5);
                let v12 = ScoreEvent{
                    key         : arg3,
                    id          : 0x2::object::id_address<Leaderboard>(v4),
                    user        : arg4,
                    log         : v11,
                    bcs_padding : vector[],
                };
                0x2::event::emit<ScoreEvent>(v12);
                let v13 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v13, arg5);
                return v13
            };
            v2 = *0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::next<address, Leaderboard>(v0, v3);
        };
        vector[0]
    }

    entry fun trim_leaderboard(arg0: &0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::Version, arg1: &mut TypusLeaderboardRegistry, arg2: 0x1::ascii::String, arg3: address, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::ecosystem::verify(arg0, arg7);
        let v0 = if (arg4) {
            &mut arg1.active_leaderboard_registry
        } else {
            &mut arg1.inactive_leaderboard_registry
        };
        let v1 = 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::borrow_mut<address, Leaderboard>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_object_table::LinkedObjectTable<address, Leaderboard>>(v0, arg2), arg3);
        if (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::is_empty<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking)) {
            return
        };
        while (arg5 <= arg6) {
            if (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::has_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking, arg5)) {
                if (0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::is_empty<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::borrow_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&v1.ranking, arg5))) {
                    0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::drop<address>(0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::critbit::remove_leaf_by_index<0x5dbd1aff75523d3d12a4bc2715077da719a5cc1f5b9bfc38ca900895527b4ab9::linked_set::LinkedSet<address>>(&mut v1.ranking, arg5));
                };
            };
            arg5 = arg5 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

