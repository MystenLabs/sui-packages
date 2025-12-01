module 0x1a268b080e2beae4152b1b30fc08a110782a65ed61681c449436cdcc8b3fc584::game {
    struct GameWorld has key {
        id: 0x2::object::UID,
        nodes: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct ValidatorNode has store, key {
        id: 0x2::object::UID,
        validator_address: address,
        faction: u8,
        daemons: vector<Daemon>,
        links: 0x2::vec_set::VecSet<address>,
    }

    struct Daemon has store, key {
        id: 0x2::object::UID,
        level: u8,
        hp: u64,
        max_hp: u64,
        last_charge_epoch: u64,
        owner: address,
    }

    struct NodeKey has store, key {
        id: 0x2::object::UID,
        validator_address: address,
    }

    struct CombatLog has copy, drop {
        attacker: address,
        node_address: address,
        outcome: 0x1::string::String,
        fragments_change: u64,
        fragments_gained: bool,
        damage_dealt: u64,
        target_daemon: 0x1::option::Option<0x2::object::ID>,
    }

    struct ScoreUpdated has copy, drop {
        player: address,
        new_score: u64,
        faction: u8,
        reason: 0x1::string::String,
    }

    struct PlayerState has key {
        id: 0x2::object::UID,
        current_node: 0x1::option::Option<address>,
        arrival_time: u64,
        last_hack: u64,
        faction: u8,
        scouted_nodes: 0x2::vec_set::VecSet<address>,
        data_fragments: u64,
        owned_keys: 0x2::vec_set::VecSet<address>,
        attack_power: u64,
        faction_points: u64,
        purchases_today: u64,
        last_purchase_epoch: u64,
    }

    public entry fun buy_fragments(arg0: &mut PlayerState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg0.last_purchase_epoch) {
            arg0.purchases_today = 0;
            arg0.last_purchase_epoch = v0;
        };
        assert!(arg0.purchases_today < 3, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000 * 0x2::math::pow(2, (arg0.purchases_today as u8)), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb9791ede298875ba43fc1eb8703da6a5bd5ad8f5647d0e2ca36aa86f45935e0b);
        arg0.data_fragments = arg0.data_fragments + 100;
        arg0.purchases_today = arg0.purchases_today + 1;
    }

    public entry fun craft_daemon(arg0: &mut PlayerState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.data_fragments >= 50, 100);
        arg0.data_fragments = arg0.data_fragments - 50;
        let v0 = Daemon{
            id                : 0x2::object::new(arg1),
            level             : 1,
            hp                : 100,
            max_hp            : 100,
            last_charge_epoch : 0x2::tx_context::epoch(arg1),
            owner             : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<Daemon>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_player(arg0: u8, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerState{
            id                  : 0x2::object::new(arg2),
            current_node        : 0x1::option::some<address>(arg1),
            arrival_time        : 0,
            last_hack           : 0,
            faction             : arg0,
            scouted_nodes       : 0x2::vec_set::empty<address>(),
            data_fragments      : 100,
            owned_keys          : 0x2::vec_set::empty<address>(),
            attack_power        : 0,
            faction_points      : 0,
            purchases_today     : 0,
            last_purchase_epoch : 0,
        };
        0x2::transfer::transfer<PlayerState>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun debug_set_attack_power(arg0: &mut PlayerState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.attack_power = arg1;
    }

    public entry fun debug_set_faction(arg0: &mut PlayerState, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.faction = arg1;
    }

    public entry fun debug_set_fragments(arg0: &mut PlayerState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.data_fragments = arg1;
    }

    public fun deploy(arg0: &mut PlayerState, arg1: &mut ValidatorNode, arg2: Daemon, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_node == 0x1::option::some<address>(arg1.validator_address), 0);
        assert!(0x1::vector::length<Daemon>(&arg1.daemons) < 6, 4);
        if (arg1.faction == 0) {
            arg1.faction = arg0.faction;
        } else {
            assert!(arg1.faction == arg0.faction, 7);
        };
        0x1::vector::push_back<Daemon>(&mut arg1.daemons, arg2);
        arg0.faction_points = arg0.faction_points + 10;
        let v0 = ScoreUpdated{
            player    : 0x2::tx_context::sender(arg3),
            new_score : arg0.faction_points,
            faction   : arg0.faction,
            reason    : 0x1::string::utf8(b"DEPLOY"),
        };
        0x2::event::emit<ScoreUpdated>(v0);
    }

    public entry fun hack(arg0: &mut PlayerState, arg1: &mut ValidatorNode, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.current_node == 0x1::option::some<address>(arg1.validator_address), 0);
        assert!(v0 >= arg0.arrival_time, 2);
        assert!(arg1.faction != arg0.faction, 6);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = 0x1::vector::length<Daemon>(&arg1.daemons);
        let v3 = 0x1::string::utf8(b"UNDEFENDED");
        let v4 = 0;
        let v5 = true;
        let v6 = 0;
        let v7 = 0x1::option::none<0x2::object::ID>();
        if (v2 > 0) {
            if (0x2::random::generate_u8_in_range(&mut v1, 0, 100) < 75) {
                v3 = 0x1::string::utf8(b"WIN");
                arg0.faction_points = arg0.faction_points + 5;
                let v8 = ScoreUpdated{
                    player    : 0x2::tx_context::sender(arg5),
                    new_score : arg0.faction_points,
                    faction   : arg0.faction,
                    reason    : 0x1::string::utf8(b"COMBAT_WIN"),
                };
                0x2::event::emit<ScoreUpdated>(v8);
                let v9 = 0;
                let v10 = false;
                assert!(0x1::option::is_some<0x2::object::ID>(&arg2), 12);
                let v11 = 0;
                while (v11 < v2) {
                    if (0x2::object::id<Daemon>(0x1::vector::borrow<Daemon>(&arg1.daemons, v11)) == *0x1::option::borrow<0x2::object::ID>(&arg2)) {
                        v9 = v11;
                        v10 = true;
                        break
                    };
                    v11 = v11 + 1;
                };
                if (!v10) {
                    abort 12
                };
                let v12 = 0x1::vector::borrow_mut<Daemon>(&mut arg1.daemons, v9);
                v7 = 0x1::option::some<0x2::object::ID>(0x2::object::id<Daemon>(v12));
                let v13 = if (arg0.attack_power > 0) {
                    arg0.attack_power
                } else {
                    0x2::random::generate_u64_in_range(&mut v1, 10, 21)
                };
                v6 = v13;
                let v14 = if (v12.hp > v13) {
                    v12.hp = v12.hp - v13;
                    false
                } else {
                    v12.hp = 0;
                    true
                };
                if (v14) {
                    let Daemon {
                        id                : v15,
                        level             : _,
                        hp                : _,
                        max_hp            : _,
                        last_charge_epoch : _,
                        owner             : _,
                    } = 0x1::vector::swap_remove<Daemon>(&mut arg1.daemons, v9);
                    0x2::object::delete(v15);
                };
                if (0x1::vector::is_empty<Daemon>(&arg1.daemons)) {
                    arg1.faction = 0;
                };
                if (0x2::random::generate_u8_in_range(&mut v1, 0, 100) < 30 && !0x2::vec_set::contains<address>(&arg0.owned_keys, &arg1.validator_address)) {
                    let v21 = NodeKey{
                        id                : 0x2::object::new(arg5),
                        validator_address : arg1.validator_address,
                    };
                    0x2::transfer::transfer<NodeKey>(v21, 0x2::tx_context::sender(arg5));
                    0x2::vec_set::insert<address>(&mut arg0.owned_keys, arg1.validator_address);
                };
            } else {
                v3 = 0x1::string::utf8(b"LOSS");
                v5 = false;
                let v22 = 0x2::random::generate_u64_in_range(&mut v1, 1, 5);
                v4 = v22;
                if (arg0.data_fragments >= v22) {
                    arg0.data_fragments = arg0.data_fragments - v22;
                } else {
                    arg0.data_fragments = 0;
                };
            };
        } else {
            arg0.faction_points = arg0.faction_points + 5;
            let v23 = ScoreUpdated{
                player    : 0x2::tx_context::sender(arg5),
                new_score : arg0.faction_points,
                faction   : arg0.faction,
                reason    : 0x1::string::utf8(b"HACK_SUCCESS"),
            };
            0x2::event::emit<ScoreUpdated>(v23);
            if (0x2::random::generate_u8_in_range(&mut v1, 0, 100) < 30 && !0x2::vec_set::contains<address>(&arg0.owned_keys, &arg1.validator_address)) {
                let v24 = NodeKey{
                    id                : 0x2::object::new(arg5),
                    validator_address : arg1.validator_address,
                };
                0x2::transfer::transfer<NodeKey>(v24, 0x2::tx_context::sender(arg5));
                0x2::vec_set::insert<address>(&mut arg0.owned_keys, arg1.validator_address);
            };
            let v25 = 0x2::random::generate_u64_in_range(&mut v1, 5, 11);
            arg0.data_fragments = arg0.data_fragments + v25;
            v4 = v25;
        };
        arg0.last_hack = v0;
        let v26 = CombatLog{
            attacker         : 0x2::tx_context::sender(arg5),
            node_address     : arg1.validator_address,
            outcome          : v3,
            fragments_change : v4,
            fragments_gained : v5,
            damage_dealt     : v6,
            target_daemon    : v7,
        };
        0x2::event::emit<CombatLog>(v26);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameWorld{
            id    : 0x2::object::new(arg0),
            nodes : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<GameWorld>(v0);
    }

    public fun jump(arg0: &mut PlayerState, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.arrival_time + 300000, 2);
        assert!(arg0.data_fragments >= arg2, 100);
        arg0.data_fragments = arg0.data_fragments - arg2;
        arg0.current_node = 0x1::option::some<address>(arg1);
        arg0.arrival_time = v0 + 20000;
    }

    public fun link(arg0: &mut PlayerState, arg1: &mut ValidatorNode, arg2: &mut ValidatorNode, arg3: NodeKey, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_node == 0x1::option::some<address>(arg1.validator_address), 0);
        assert!(arg3.validator_address == arg2.validator_address, 9);
        assert!(arg1.faction == arg0.faction, 3);
        assert!(arg2.faction == arg0.faction, 3);
        0x2::vec_set::insert<address>(&mut arg1.links, arg2.validator_address);
        let NodeKey {
            id                : v0,
            validator_address : _,
        } = arg3;
        0x2::object::delete(v0);
    }

    public fun prune_dead_daemon(arg0: &mut ValidatorNode, arg1: 0x2::object::ID) {
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Daemon>(&arg0.daemons)) {
            if (0x2::object::id<Daemon>(0x1::vector::borrow<Daemon>(&arg0.daemons, v1)) == arg1) {
                v0 = 0x1::option::some<u64>(v1);
                break
            };
            v1 = v1 + 1;
        };
        if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::option::destroy_some<u64>(v0);
            if (0x1::vector::borrow<Daemon>(&arg0.daemons, v2).hp == 0) {
                let Daemon {
                    id                : v3,
                    level             : _,
                    hp                : _,
                    max_hp            : _,
                    last_charge_epoch : _,
                    owner             : _,
                } = 0x1::vector::remove<Daemon>(&mut arg0.daemons, v2);
                0x2::object::delete(v3);
            };
        };
    }

    public fun recharge(arg0: &mut PlayerState, arg1: &mut ValidatorNode, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_node == 0x1::option::some<address>(arg1.validator_address), 0);
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Daemon>(&arg1.daemons)) {
            if (0x2::object::id<Daemon>(0x1::vector::borrow<Daemon>(&arg1.daemons, v1)) == arg2) {
                v0 = 0x1::option::some<u64>(v1);
                break
            };
            v1 = v1 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v0), 8);
        let v2 = 0x1::vector::borrow_mut<Daemon>(&mut arg1.daemons, 0x1::option::destroy_some<u64>(v0));
        let v3 = 0x2::tx_context::epoch(arg3);
        let v4 = v3 - v2.last_charge_epoch;
        if (v4 > 0) {
            let v5 = v2.max_hp * 15 * v4 / 100;
            if (v2.hp <= v5) {
                v2.hp = 0;
            } else {
                v2.hp = v2.hp - v5;
            };
            v2.last_charge_epoch = v3;
        };
        if (v2.hp > 0) {
            v2.hp = v2.max_hp;
        };
    }

    public entry fun reinforce(arg0: &mut PlayerState, arg1: &mut ValidatorNode, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.current_node == 0x1::option::some<address>(arg1.validator_address), 0);
        assert!(v0 >= arg0.arrival_time, 2);
        assert!(arg1.faction == arg0.faction, 3);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 1, 3);
        arg0.data_fragments = arg0.data_fragments + v2;
        arg0.faction_points = arg0.faction_points + 1;
        arg0.last_hack = v0;
        let v3 = ScoreUpdated{
            player    : 0x2::tx_context::sender(arg4),
            new_score : arg0.faction_points,
            faction   : arg0.faction,
            reason    : 0x1::string::utf8(b"REINFORCE"),
        };
        0x2::event::emit<ScoreUpdated>(v3);
        let v4 = CombatLog{
            attacker         : 0x2::tx_context::sender(arg4),
            node_address     : arg1.validator_address,
            outcome          : 0x1::string::utf8(b"REINFORCE"),
            fragments_change : v2,
            fragments_gained : true,
            damage_dealt     : 0,
            target_daemon    : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<CombatLog>(v4);
    }

    public entry fun scout(arg0: &mut PlayerState, arg1: &mut GameWorld, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_set::contains<address>(&arg0.scouted_nodes, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.scouted_nodes, arg2);
            arg0.faction_points = arg0.faction_points + 1;
            let v0 = ScoreUpdated{
                player    : 0x2::tx_context::sender(arg3),
                new_score : arg0.faction_points,
                faction   : arg0.faction,
                reason    : 0x1::string::utf8(b"SCOUT"),
            };
            0x2::event::emit<ScoreUpdated>(v0);
        };
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg1.nodes, arg2)) {
            let v1 = ValidatorNode{
                id                : 0x2::object::new(arg3),
                validator_address : arg2,
                faction           : 0,
                daemons           : 0x1::vector::empty<Daemon>(),
                links             : 0x2::vec_set::empty<address>(),
            };
            0x2::table::add<address, 0x2::object::ID>(&mut arg1.nodes, arg2, 0x2::object::id<ValidatorNode>(&v1));
            0x2::transfer::share_object<ValidatorNode>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

