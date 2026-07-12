module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::player {
    struct ActiveAction has copy, drop, store {
        kind: u8,
        params: vector<u64>,
        started_at_ms: u64,
    }

    struct Player has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        coins: u64,
        inventory: 0x2::vec_map::VecMap<u16, u64>,
        xp: 0x2::vec_map::VecMap<u8, u64>,
        location: u16,
        action: 0x1::option::Option<ActiveAction>,
        enemy_pool: 0x2::vec_map::VecMap<u16, u64>,
        armory_seq: u64,
        session_addr: address,
        session_expires_ms: u64,
        version: u64,
    }

    struct PlayerCreated has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct SessionStarted has copy, drop {
        player_id: 0x2::object::ID,
        session_address: address,
        expires_at_ms: u64,
    }

    struct SessionEnded has copy, drop {
        player_id: 0x2::object::ID,
        session_address: address,
    }

    public fun action_kind(arg0: &ActiveAction) : u8 {
        arg0.kind
    }

    public fun action_params(arg0: &ActiveAction) : vector<u64> {
        arg0.params
    }

    public fun action_started_at_ms(arg0: &ActiveAction) : u64 {
        arg0.started_at_ms
    }

    public(friend) fun assert_can_play(arg0: &Player, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834784229654543);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.owner) {
            return
        };
        assert!(v0 == arg0.session_addr && 0x2::clock::timestamp_ms(arg1) < arg0.session_expires_ms, 13906834809998540801);
    }

    public(friend) fun assert_idle(arg0: &Player) {
        assert!(0x1::option::is_none<ActiveAction>(&arg0.action), 13906835355460042763);
    }

    public fun coins(arg0: &Player) : u64 {
        arg0.coins
    }

    public fun create_player(arg0: &0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::Registry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::assert_version(arg0);
        let v0 = 0x2::vec_map::empty<u8, u64>();
        let v1 = 0;
        while (v1 < 12) {
            0x2::vec_map::insert<u8, u64>(&mut v0, v1, 0);
            v1 = v1 + 1;
        };
        let v2 = Player{
            id                 : 0x2::object::new(arg2),
            owner              : 0x2::tx_context::sender(arg2),
            name               : arg1,
            coins              : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::start_coins(arg0),
            inventory          : 0x2::vec_map::empty<u16, u64>(),
            xp                 : v0,
            location           : 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry::start_location(arg0),
            action             : 0x1::option::none<ActiveAction>(),
            enemy_pool         : 0x2::vec_map::empty<u16, u64>(),
            armory_seq         : 0,
            session_addr       : @0x0,
            session_expires_ms : 0,
            version            : 1,
        };
        let v3 = PlayerCreated{
            player_id : 0x2::object::uid_to_inner(&v2.id),
            owner     : v2.owner,
            name      : v2.name,
        };
        0x2::event::emit<PlayerCreated>(v3);
        0x2::transfer::share_object<Player>(v2);
    }

    public(friend) fun credit_coins(arg0: &mut Player, arg1: u64) {
        arg0.coins = arg0.coins + arg1;
    }

    public(friend) fun credit_enemies(arg0: &mut Player, arg1: u16, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<u16, u64>(&arg0.enemy_pool, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u16, u64>(&mut arg0.enemy_pool, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<u16, u64>(&mut arg0.enemy_pool, arg1, arg2);
        };
    }

    public(friend) fun credit_item(arg0: &mut Player, arg1: u16, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<u16, u64>(&arg0.inventory, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u16, u64>(&mut arg0.inventory, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<u16, u64>(&mut arg0.inventory, arg1, arg2);
        };
    }

    public(friend) fun credit_xp(arg0: &mut Player, arg1: u8, arg2: u64) {
        let v0 = 0x2::vec_map::get_mut<u8, u64>(&mut arg0.xp, &arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun debit_coins(arg0: &mut Player, arg1: u64) {
        assert!(arg0.coins >= arg1, 13906835157891284999);
        arg0.coins = arg0.coins - arg1;
    }

    public(friend) fun debit_enemies(arg0: &mut Player, arg1: u16, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert!(enemy_count(arg0, arg1) >= arg2, 13906835248085729289);
        let v0 = 0x2::vec_map::get_mut<u16, u64>(&mut arg0.enemy_pool, &arg1);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            let (_, _) = 0x2::vec_map::remove<u16, u64>(&mut arg0.enemy_pool, &arg1);
        };
    }

    public(friend) fun debit_item(arg0: &mut Player, arg1: u16, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert!(item_qty(arg0, arg1) >= arg2, 13906835102056579077);
        let v0 = 0x2::vec_map::get_mut<u16, u64>(&mut arg0.inventory, &arg1);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            let (_, _) = 0x2::vec_map::remove<u16, u64>(&mut arg0.inventory, &arg1);
        };
    }

    public fun end_session(arg0: &mut Player, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.session_addr, 13906835003272069121);
        let v1 = SessionEnded{
            player_id       : 0x2::object::uid_to_inner(&arg0.id),
            session_address : arg0.session_addr,
        };
        0x2::event::emit<SessionEnded>(v1);
        arg0.session_addr = @0x0;
        arg0.session_expires_ms = 0;
    }

    public fun enemy_count(arg0: &Player, arg1: u16) : u64 {
        if (0x2::vec_map::contains<u16, u64>(&arg0.enemy_pool, &arg1)) {
            *0x2::vec_map::get<u16, u64>(&arg0.enemy_pool, &arg1)
        } else {
            0
        }
    }

    public fun id(arg0: &Player) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_busy(arg0: &Player) : bool {
        0x1::option::is_some<ActiveAction>(&arg0.action)
    }

    public fun item_qty(arg0: &Player, arg1: u16) : u64 {
        if (0x2::vec_map::contains<u16, u64>(&arg0.inventory, &arg1)) {
            *0x2::vec_map::get<u16, u64>(&arg0.inventory, &arg1)
        } else {
            0
        }
    }

    public fun kind_battle() : u8 {
        3
    }

    public fun kind_craft() : u8 {
        1
    }

    public fun kind_gather() : u8 {
        0
    }

    public fun kind_hunt() : u8 {
        2
    }

    public fun kind_travel() : u8 {
        4
    }

    public fun location(arg0: &Player) : u16 {
        arg0.location
    }

    public fun migrate(arg0: &mut Player) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public(friend) fun next_armory_seq(arg0: &mut Player) : u64 {
        let v0 = arg0.armory_seq;
        arg0.armory_seq = v0 + 1;
        v0
    }

    public fun owner(arg0: &Player) : address {
        arg0.owner
    }

    public fun session_address(arg0: &Player) : address {
        arg0.session_addr
    }

    public fun session_expires_ms(arg0: &Player) : u64 {
        arg0.session_expires_ms
    }

    public(friend) fun set_location(arg0: &mut Player, arg1: u16) {
        arg0.location = arg1;
    }

    public fun skill_level(arg0: &Player, arg1: u8) : u8 {
        0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::xp::level_for_xp(skill_xp(arg0, arg1))
    }

    public fun skill_xp(arg0: &Player, arg1: u8) : u64 {
        *0x2::vec_map::get<u8, u64>(&arg0.xp, &arg1)
    }

    public(friend) fun start_action(arg0: &mut Player, arg1: u8, arg2: vector<u64>, arg3: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<ActiveAction>(&arg0.action), 13906835316805337099);
        let v0 = ActiveAction{
            kind          : arg1,
            params        : arg2,
            started_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::option::fill<ActiveAction>(&mut arg0.action, v0);
    }

    public fun start_session(arg0: &mut Player, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906834917373640719);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 13906834921667821571);
        arg0.session_addr = arg1;
        let v0 = if (arg2 == 0) {
            18446744073709551615
        } else {
            0x2::clock::timestamp_ms(arg3) + arg2
        };
        arg0.session_expires_ms = v0;
        let v1 = SessionStarted{
            player_id       : 0x2::object::uid_to_inner(&arg0.id),
            session_address : arg1,
            expires_at_ms   : arg0.session_expires_ms,
        };
        0x2::event::emit<SessionStarted>(v1);
    }

    public(friend) fun take_action(arg0: &mut Player) : ActiveAction {
        assert!(0x1::option::is_some<ActiveAction>(&arg0.action), 13906835372640043021);
        0x1::option::extract<ActiveAction>(&mut arg0.action)
    }

    public fun total_level(arg0: &Player) : u16 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 12) {
            v0 = v0 + (skill_level(arg0, v1) as u16);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun uid(arg0: &Player) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Player) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

