module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_boss_cave {
    struct BossCaves has store, key {
        id: 0x2::object::UID,
        boss_name: 0x1::string::String,
        total_hp: u256,
        left_hp: u256,
        total_residents_in_combat: u64,
        total_resident_rating: u256,
        start_time: u64,
        defeat_time: u64,
        boss_status: u8,
        combating_residents: 0x2::object_bag::ObjectBag,
        owner_combating_list: 0x2::table::Table<address, vector<0x2::object::ID>>,
        create_time: u64,
        last_hp_update_time: u64,
        ticket_price_dgg: u64,
        settle_reward_dgg: u64,
        consolation_dgg: u64,
        min_resident_rating: u64,
        base_probability: u64,
        amplifier_ratio: u64,
        version: u64,
    }

    struct BossCaveCombatingResident<T0> has store, key {
        id: 0x2::object::UID,
        resident: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>,
        start_time: u64,
        owner: address,
    }

    struct BossCaveTreasureChest has store, key {
        id: 0x2::object::UID,
        rv: u64,
        p: u64,
        boss_cave_id: 0x2::object::ID,
        gem_rarity_rv: u64,
        consolation_dgg: u64,
        version: u64,
    }

    struct ResidentEnterCaveEvent has copy, drop {
        user_address: address,
        resident_id: 0x2::object::ID,
        boss_cave_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct BossCaveSettledEvent has copy, drop {
        settled_by: address,
        boss_cave_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TreasureChestRevealEvent has copy, drop {
        revealed_by: address,
        boss_cave_id: 0x2::object::ID,
        reward_type: u8,
        probability: u64,
        gem_rarity: u64,
        consolation_dgg: u64,
        timestamp: u64,
    }

    struct DUNGEON_BOSS_CAVE has drop {
        dummy_field: bool,
    }

    entry fun claim_boss_cave_reward<T0: store>(arg0: &mut BossCaves, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg0.boss_status == 1, 101);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.defeat_time, 101);
        let v0 = 0x2::tx_context::sender(arg4);
        let BossCaveCombatingResident {
            id         : v1,
            resident   : v2,
            start_time : v3,
            owner      : v4,
        } = 0x2::object_bag::remove<0x2::object::ID, BossCaveCombatingResident<T0>>(&mut arg0.combating_residents, arg1);
        let v5 = v2;
        let v6 = v1;
        assert!(v0 == v4, 0);
        assert!(v3 <= arg0.defeat_time, 108);
        let v7 = arg0.base_probability + ((((arg0.defeat_time - v3) as u256) * (0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::resident_rating<T0>(&v5) as u256) / 1000 * 1000000 / arg0.total_hp * (arg0.amplifier_ratio as u256)) as u64);
        let v8 = v7;
        if (v7 > 1000000) {
            v8 = 1000000;
        };
        let v9 = 0x2::random::new_generator(arg3, arg4);
        let v10 = BossCaveTreasureChest{
            id              : 0x2::object::new(arg4),
            rv              : 0x2::random::generate_u64_in_range(&mut v9, 1, 1000000),
            p               : v8,
            boss_cave_id    : 0x2::object::id<BossCaves>(arg0),
            gem_rarity_rv   : 0x2::random::generate_u64_in_range(&mut v9, 1, 10000),
            consolation_dgg : arg0.consolation_dgg,
            version         : 1,
        };
        0x2::transfer::public_transfer<BossCaveTreasureChest>(v10, v0);
        let v11 = 0x2::object::uid_to_inner(&v6);
        let v12 = &mut arg0.owner_combating_list;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v12, v4)) {
            let v13 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v12, v4);
            let (v14, v15) = 0x1::vector::index_of<0x2::object::ID>(v13, &v11);
            if (v14) {
                0x1::vector::remove<0x2::object::ID>(v13, v15);
            };
        };
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>>(v5, v0);
    }

    public fun create_boss_cave(arg0: &0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::AdminCap, arg1: 0x1::string::String, arg2: u256, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100000000000, 107);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg10), 108);
        let v0 = BossCaves{
            id                        : 0x2::object::new(arg11),
            boss_name                 : arg1,
            total_hp                  : arg2,
            left_hp                   : arg2,
            total_residents_in_combat : 0,
            total_resident_rating     : 0,
            start_time                : arg3,
            defeat_time               : 0,
            boss_status               : 0,
            combating_residents       : 0x2::object_bag::new(arg11),
            owner_combating_list      : 0x2::table::new<address, vector<0x2::object::ID>>(arg11),
            create_time               : 0x2::clock::timestamp_ms(arg10),
            last_hp_update_time       : 0,
            ticket_price_dgg          : arg4,
            settle_reward_dgg         : arg5,
            consolation_dgg           : arg6,
            min_resident_rating       : arg7,
            base_probability          : arg8,
            amplifier_ratio           : arg9,
            version                   : 1,
        };
        0x2::transfer::share_object<BossCaves>(v0);
    }

    public fun enter_boss_cave<T0: store>(arg0: &mut BossCaves, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>, arg3: 0x2::coin::Coin<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DGG_TOKEN>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.start_time, 110);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::Resident<T0>>(&arg2);
        let v2 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident::resident_rating<T0>(&arg2);
        assert!(v2 >= arg0.min_resident_rating, 104);
        assert!(0x2::coin::value<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DGG_TOKEN>(&arg3) == arg0.ticket_price_dgg, 105);
        assert!(arg0.left_hp > 0, 102);
        assert!(arg0.boss_status == 0, 102);
        assert!(arg0.last_hp_update_time <= 0x2::clock::timestamp_ms(arg4), 103);
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_burn(arg1, arg3);
        if (arg0.total_residents_in_combat != 0) {
            assert!(0x2::clock::timestamp_ms(arg4) < arg0.defeat_time, 102);
            let v3 = ((0x2::clock::timestamp_ms(arg4) - arg0.last_hp_update_time) as u256) * arg0.total_resident_rating / 1000;
            if (v3 < arg0.left_hp) {
                arg0.left_hp = arg0.left_hp - v3;
                arg0.defeat_time = 0x2::clock::timestamp_ms(arg4) + ((arg0.left_hp * 1000 / (arg0.total_resident_rating + (v2 as u256))) as u64);
            } else {
                arg0.left_hp = 0;
            };
        } else {
            arg0.defeat_time = 0x2::clock::timestamp_ms(arg4) + ((arg0.left_hp * 1000 / (v2 as u256)) as u64);
        };
        arg0.last_hp_update_time = 0x2::clock::timestamp_ms(arg4);
        let v4 = BossCaveCombatingResident<T0>{
            id         : 0x2::object::new(arg5),
            resident   : arg2,
            start_time : 0x2::clock::timestamp_ms(arg4),
            owner      : v0,
        };
        0x2::object_bag::add<0x2::object::ID, BossCaveCombatingResident<T0>>(&mut arg0.combating_residents, v1, v4);
        let v5 = &mut arg0.owner_combating_list;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(v5, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v5, v0), 0x2::object::id<BossCaveCombatingResident<T0>>(&v4));
        } else {
            let v6 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<BossCaveCombatingResident<T0>>(&v4));
            0x2::table::add<address, vector<0x2::object::ID>>(v5, v0, v6);
        };
        arg0.total_residents_in_combat = arg0.total_residents_in_combat + 1;
        arg0.total_resident_rating = arg0.total_resident_rating + (v2 as u256);
        let v7 = ResidentEnterCaveEvent{
            user_address : v0,
            resident_id  : v1,
            boss_cave_id : 0x2::object::id<BossCaves>(arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ResidentEnterCaveEvent>(v7);
    }

    fun get_gem_rarity(arg0: u64) : (u64, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        assert!(arg0 > 0 && arg0 <= 10000, 109);
        if (arg0 <= 6000) {
            return (0, 0x1::string::utf8(b"N"), 0x1::string::utf8(b"FFFFFF"), 0x1::string::utf8(b"Lv+2"))
        };
        if (arg0 <= 9000) {
            return (1, 0x1::string::utf8(b"R"), 0x1::string::utf8(b"1A73E8"), 0x1::string::utf8(b"Lv+4"))
        };
        if (arg0 <= 9770) {
            return (2, 0x1::string::utf8(b"SR"), 0x1::string::utf8(b"F28800"), 0x1::string::utf8(b"Lv+6"))
        };
        if (arg0 <= 9970) {
            return (3, 0x1::string::utf8(b"SSR"), 0x1::string::utf8(b"6CD206"), 0x1::string::utf8(b"Lv+8"))
        };
        (4, 0x1::string::utf8(b"UR"), 0x1::string::utf8(b"E50C0C"), 0x1::string::utf8(b"Lv+10"))
    }

    public fun get_user_boss_cave_combating(arg0: &BossCaves, arg1: address) : vector<0x2::object::ID> {
        let v0 = &arg0.owner_combating_list;
        let v1 = if (0x2::table::contains<address, vector<0x2::object::ID>>(v0, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(v0, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::user_boss_cave_combating_event(v1);
        v1
    }

    public fun reveal_boss_cave_treasure_chest(arg0: BossCaveTreasureChest, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_gem::GemCirculation, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let BossCaveTreasureChest {
            id              : v1,
            rv              : v2,
            p               : v3,
            boss_cave_id    : v4,
            gem_rarity_rv   : v5,
            consolation_dgg : v6,
            version         : _,
        } = arg0;
        if (v2 <= v3) {
            let (v8, v9, v10, v11) = get_gem_rarity(v5);
            0x2::transfer::public_transfer<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_gem::Gem>(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_gem::create_gem(arg2, v8, v9, v10, v11, arg4), v0);
        } else {
            0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_mint(arg1, v6, v0, arg4);
        };
        0x2::object::delete(v1);
        let v12 = if (v2 <= v3) {
            0
        } else {
            1
        };
        let v13 = if (v2 <= v3) {
            v5
        } else {
            0
        };
        let v14 = TreasureChestRevealEvent{
            revealed_by     : v0,
            boss_cave_id    : v4,
            reward_type     : v12,
            probability     : v3,
            gem_rarity      : v13,
            consolation_dgg : v6,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasureChestRevealEvent>(v14);
    }

    entry fun settle_boss_cave(arg0: &mut BossCaves, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg0.boss_status == 0, 106);
        assert!(arg0.total_residents_in_combat > 0, 101);
        assert!(arg0.total_resident_rating > 0, 101);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.defeat_time, 101);
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.boss_status = 1;
        arg0.left_hp = 0;
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_mint(arg1, arg0.settle_reward_dgg, v0, arg3);
        let v1 = BossCaveSettledEvent{
            settled_by   : v0,
            boss_cave_id : 0x2::object::id<BossCaves>(arg0),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BossCaveSettledEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

