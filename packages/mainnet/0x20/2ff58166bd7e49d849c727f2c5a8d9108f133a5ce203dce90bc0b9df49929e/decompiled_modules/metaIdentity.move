module 0x81028857c94206813c541ba305da607f1d7be2896392d9ea1e65f753e9e67687::metaIdentity {
    struct MetaIdentity has key {
        id: 0x2::object::UID,
        metaId: u64,
        name: 0x1::string::String,
        wallet_addr: address,
        invited_claimed_num: u64,
        level: u64,
        exp: u64,
        total_arena_win: u64,
        total_arena_lose: u64,
        avatar_name: 0x1::string::String,
        best_rank_map: 0x2::table::Table<u64, u64>,
        init_gold: u64,
        ability1: 0x1::string::String,
        ability2: 0x1::string::String,
        ability3: 0x1::string::String,
        ability4: 0x1::string::String,
        ability5: 0x1::string::String,
        inviterMetaId: u64,
    }

    struct RewardsGlobal has key {
        id: 0x2::object::UID,
        creator: address,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        claimed_rewards_num_map: 0x2::table::Table<u64, u64>,
        rebate_level: 0x2::table::Table<u64, u64>,
        version: u64,
        manager: address,
    }

    struct MetaInfoGlobal has key {
        id: 0x2::object::UID,
        creator: address,
        total_players: u64,
        wallet_meta_map: 0x2::table::Table<address, address>,
        invited_meta_map: 0x2::linked_table::LinkedTable<u64, vector<address>>,
        version: u64,
        manager: address,
    }

    fun add_exp(arg0: &mut MetaIdentity, arg1: u64) {
        let v0 = arg0.level;
        let v1 = arg0.exp + arg1;
        if (v0 == 0 && v1 >= 20) {
            level_up(arg0);
            arg0.exp = v1 - 20;
        } else if (v0 == 1 && v1 >= 40) {
            level_up(arg0);
            arg0.exp = v1 - 40;
        } else if (v0 == 2 && v1 >= 80) {
            level_up(arg0);
            arg0.exp = v1 - 80;
        } else if (v0 == 3 && v1 >= 100) {
            level_up(arg0);
            arg0.exp = v1 - 100;
        } else if (v0 == 4 && v1 >= 200) {
            level_up(arg0);
            arg0.exp = v1 - 200;
        } else if (v0 == 5 && v1 >= 300) {
            level_up(arg0);
            arg0.exp = v1 - 300;
        } else if (v0 == 6 && v1 >= 400) {
            level_up(arg0);
            arg0.exp = v1 - 400;
        } else if (v0 == 7 && v1 >= 500) {
            level_up(arg0);
            arg0.exp = v1 - 500;
        } else if (v0 == 8 && v1 >= 600) {
            level_up(arg0);
            arg0.exp = v1 - 600;
        } else if (v0 == 9 && v1 >= 1000) {
            level_up(arg0);
            arg0.exp = v1 - 1000;
        } else {
            arg0.exp = v1;
        };
    }

    public fun airdrop_split(arg0: u64, arg1: &mut RewardsGlobal, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.manager, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_SUI, arg0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun burn_meta(arg0: MetaIdentity) {
        let MetaIdentity {
            id                  : v0,
            metaId              : _,
            name                : _,
            wallet_addr         : _,
            invited_claimed_num : _,
            level               : _,
            exp                 : _,
            total_arena_win     : _,
            total_arena_lose    : _,
            avatar_name         : _,
            best_rank_map       : v10,
            init_gold           : _,
            ability1            : _,
            ability2            : _,
            ability3            : _,
            ability4            : _,
            ability5            : _,
            inviterMetaId       : _,
        } = arg0;
        0x2::table::drop<u64, u64>(v10);
        0x2::object::delete(v0);
    }

    public fun changeMetaInfo(arg0: &mut MetaIdentity, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.name = arg1;
        arg0.avatar_name = arg2;
    }

    public fun change_manager(arg0: &mut MetaInfoGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.manager = arg1;
    }

    public fun change_manager2(arg0: &mut RewardsGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.manager = arg1;
    }

    public fun claim_invite_exp(arg0: &MetaInfoGlobal, arg1: &mut MetaIdentity) {
        assert!(arg0.version == 1, 3);
        let v0 = query_invited_num(arg0, arg1.metaId);
        let v1 = arg1.invited_claimed_num;
        assert!(v0 > v1, 4);
        add_exp(arg1, (v0 - v1) * 20);
        arg1.invited_claimed_num = arg1.invited_claimed_num + 1;
    }

    public fun claim_invite_rewards(arg0: &MetaInfoGlobal, arg1: &mut RewardsGlobal, arg2: &mut MetaIdentity, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        assert!(arg1.version == 1, 3);
        let v0 = arg2.metaId;
        let v1 = query_invited_num(arg0, v0);
        let v2 = if (!0x2::table::contains<u64, u64>(&arg1.claimed_rewards_num_map, v0)) {
            0
        } else {
            *0x2::table::borrow<u64, u64>(&arg1.claimed_rewards_num_map, v0)
        };
        assert!(v1 > v2, 4);
        let v3 = if (0x2::table::contains<u64, u64>(&arg1.rebate_level, v0)) {
            let v4 = *0x2::table::borrow<u64, u64>(&arg1.rebate_level, v0);
            if (v4 == 1) {
                (v1 - v2) * 1000000000 / 33
            } else if (v4 == 2) {
                (v1 - v2) * 1000000000 / 25
            } else if (v4 == 3) {
                (v1 - v2) * 1000000000 / 20
            } else {
                (v1 - v2) * 1000000000 / 50
            }
        } else {
            (v1 - v2) * 1000000000 / 50
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_SUI, v3), arg3), 0x2::tx_context::sender(arg3));
        if (!0x2::table::contains<u64, u64>(&arg1.claimed_rewards_num_map, v0)) {
            0x2::table::add<u64, u64>(&mut arg1.claimed_rewards_num_map, v0, v1);
        } else {
            0x2::table::remove<u64, u64>(&mut arg1.claimed_rewards_num_map, v0);
            0x2::table::add<u64, u64>(&mut arg1.claimed_rewards_num_map, v0, v1);
        };
    }

    public fun get_arena_lose(arg0: &MetaIdentity) : u64 {
        arg0.total_arena_lose
    }

    public fun get_arena_win(arg0: &MetaIdentity) : u64 {
        arg0.total_arena_win
    }

    public fun get_exp(arg0: &MetaIdentity) : u64 {
        arg0.exp
    }

    public fun get_invited_metaId(arg0: &MetaIdentity) : u64 {
        arg0.inviterMetaId
    }

    public fun get_is_registered(arg0: &MetaInfoGlobal, arg1: address) : u64 {
        if (0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg1)) {
            1
        } else {
            0
        }
    }

    public fun get_level(arg0: &MetaIdentity) : u64 {
        arg0.level
    }

    public fun get_metaId(arg0: &MetaIdentity) : u64 {
        arg0.metaId
    }

    public fun get_name(arg0: &MetaIdentity) : 0x1::string::String {
        arg0.name
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaInfoGlobal{
            id               : 0x2::object::new(arg0),
            creator          : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
            total_players    : 0,
            wallet_meta_map  : 0x2::table::new<address, address>(arg0),
            invited_meta_map : 0x2::linked_table::new<u64, vector<address>>(arg0),
            version          : 1,
            manager          : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
        };
        0x2::transfer::share_object<MetaInfoGlobal>(v0);
    }

    public fun init_rewards_global(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardsGlobal{
            id                      : 0x2::object::new(arg0),
            creator                 : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
            balance_SUI             : 0x2::balance::zero<0x2::sui::SUI>(),
            claimed_rewards_num_map : 0x2::table::new<u64, u64>(arg0),
            rebate_level            : 0x2::table::new<u64, u64>(arg0),
            version                 : 1,
            manager                 : @0xb2a79beac8a092b336f560ba27f278382bcab2da831c64e546d7e0e087acc4fe,
        };
        0x2::transfer::share_object<RewardsGlobal>(v0);
    }

    public fun is_registered(arg0: &MetaInfoGlobal, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg1)
    }

    fun level_up(arg0: &mut MetaIdentity) {
        arg0.level = arg0.level + 1;
    }

    public entry fun mint_meta(arg0: &mut MetaInfoGlobal, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, v0), 1);
        let v1 = 0x2::object::new(arg3);
        0x2::table::add<address, address>(&mut arg0.wallet_meta_map, v0, 0x2::object::uid_to_address(&v1));
        let v2 = MetaIdentity{
            id                  : v1,
            metaId              : 10000 + arg0.total_players,
            name                : arg1,
            wallet_addr         : v0,
            invited_claimed_num : 0,
            level               : 0,
            exp                 : 0,
            total_arena_win     : 0,
            total_arena_lose    : 0,
            avatar_name         : arg2,
            best_rank_map       : 0x2::table::new<u64, u64>(arg3),
            init_gold           : 0,
            ability1            : 0x1::string::utf8(b""),
            ability2            : 0x1::string::utf8(b""),
            ability3            : 0x1::string::utf8(b""),
            ability4            : 0x1::string::utf8(b""),
            ability5            : 0x1::string::utf8(b""),
            inviterMetaId       : 0,
        };
        arg0.total_players = arg0.total_players + 1;
        0x2::transfer::transfer<MetaIdentity>(v2, v0);
    }

    public fun query_best_rank_by_season(arg0: &mut MetaIdentity, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.best_rank_map, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.best_rank_map, arg1)
        } else {
            21
        }
    }

    public fun query_invited_num(arg0: &MetaInfoGlobal, arg1: u64) : u64 {
        if (0x2::linked_table::contains<u64, vector<address>>(&arg0.invited_meta_map, arg1)) {
            0x1::vector::length<address>(0x2::linked_table::borrow<u64, vector<address>>(&arg0.invited_meta_map, arg1))
        } else {
            0
        }
    }

    public fun query_rebate_level(arg0: &mut RewardsGlobal, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.rebate_level, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.rebate_level, arg1)
        } else {
            0
        }
    }

    public(friend) fun record_add_lose(arg0: &mut MetaIdentity) {
        arg0.total_arena_lose = arg0.total_arena_lose + 1;
        add_exp(arg0, 1);
    }

    public(friend) fun record_add_win(arg0: &mut MetaIdentity) {
        arg0.total_arena_win = arg0.total_arena_win + 1;
        add_exp(arg0, 4);
    }

    public(friend) fun record_invited_success(arg0: &mut MetaInfoGlobal, arg1: &MetaIdentity) {
        if (arg1.inviterMetaId == arg1.metaId) {
            return
        };
        let v0 = arg1.inviterMetaId;
        let v1 = arg1.wallet_addr;
        if (!0x2::linked_table::contains<u64, vector<address>>(&arg0.invited_meta_map, v0)) {
            let v2 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v2, v1);
            0x2::linked_table::push_back<u64, vector<address>>(&mut arg0.invited_meta_map, v0, v2);
        } else {
            let v3 = 0x2::linked_table::borrow_mut<u64, vector<address>>(&mut arg0.invited_meta_map, v0);
            if (!0x1::vector::contains<address>(v3, &v1)) {
                0x1::vector::push_back<address>(v3, v1);
            };
        };
    }

    public(friend) fun record_update_best_rank(arg0: &mut MetaIdentity, arg1: u64) {
        let v0 = 1;
        if (0x2::table::contains<u64, u64>(&arg0.best_rank_map, v0)) {
            if (arg1 < *0x2::table::borrow<u64, u64>(&arg0.best_rank_map, v0)) {
                0x2::table::remove<u64, u64>(&mut arg0.best_rank_map, v0);
                0x2::table::add<u64, u64>(&mut arg0.best_rank_map, v0, arg1);
            };
        } else {
            0x2::table::add<u64, u64>(&mut arg0.best_rank_map, v0, arg1);
        };
    }

    public fun register_invited_meta(arg0: &mut MetaInfoGlobal, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, v0), 1);
        let v1 = 0x2::object::new(arg4);
        0x2::table::add<address, address>(&mut arg0.wallet_meta_map, v0, 0x2::object::uid_to_address(&v1));
        let v2 = MetaIdentity{
            id                  : v1,
            metaId              : 10000 + arg0.total_players,
            name                : arg2,
            wallet_addr         : v0,
            invited_claimed_num : 0,
            level               : 0,
            exp                 : 0,
            total_arena_win     : 0,
            total_arena_lose    : 0,
            avatar_name         : arg3,
            best_rank_map       : 0x2::table::new<u64, u64>(arg4),
            init_gold           : 0,
            ability1            : 0x1::string::utf8(b""),
            ability2            : 0x1::string::utf8(b""),
            ability3            : 0x1::string::utf8(b""),
            ability4            : 0x1::string::utf8(b""),
            ability5            : 0x1::string::utf8(b""),
            inviterMetaId       : arg1,
        };
        arg0.total_players = arg0.total_players + 1;
        0x2::transfer::transfer<MetaIdentity>(v2, v0);
    }

    public fun set_rebate_level(arg0: &mut RewardsGlobal, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 1);
        0x2::table::add<u64, u64>(&mut arg0.rebate_level, arg1, arg2);
    }

    public fun top_up_rewards_pool(arg0: &mut RewardsGlobal, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1);
    }

    public fun upgradeVersion(arg0: &mut MetaInfoGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.version = arg1;
    }

    public fun upgradeVersion2(arg0: &mut RewardsGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 2);
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

