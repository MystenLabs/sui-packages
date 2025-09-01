module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty {
    struct LucaCap has key {
        id: 0x2::object::UID,
    }

    struct BulletStore has key {
        id: 0x2::object::UID,
        initial_price: u64,
        next_expire_at: u64,
        expiration_duration_ms: u64,
        bullet_purchase_cooldown_ms: u64,
        max_supply: u64,
        max_buy: u64,
        store: vector<u8>,
        recovery_coin_mist: u64,
        treasury: address,
        owner: address,
    }

    struct BattleSessionRegistry has store, key {
        id: 0x2::object::UID,
        total_battles: u64,
        max_idle_time: u64,
        hospitalization_time: u64,
        bounty_assign_to_target: 0x2::table::Table<0x2::object::ID, BattleBountySession>,
        min_bullet: u64,
        min_bounty: u128,
        active_bounty_session: vector<0x2::object::ID>,
        paused: bool,
    }

    struct BattleBountySession has copy, drop, store {
        target_player_id: 0x2::object::ID,
        bounty_assign_by: vector<0x2::object::ID>,
        count: u8,
        reward: 0x2::vec_map::VecMap<0x2::object::ID, u128>,
        total_reward: u128,
        winner_id: 0x2::object::ID,
        status: u8,
        created_at: u64,
        is_attack: bool,
        bounty_hunter_player_id: vector<0x2::object::ID>,
        attacker_id: 0x2::object::ID,
    }

    struct MagazineInfo has key {
        id: 0x2::object::UID,
        magazine: vector<u8>,
        player_id: 0x2::object::ID,
        allowlist: vector<0x2::object::ID>,
    }

    public(friend) fun add_additional_bounty(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg2);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u128>(&mut v0.reward, &arg1);
        *v1 = *v1 + arg3;
        v0.total_reward = v0.total_reward + arg3;
    }

    public fun borrow_bounty_amount(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : u128 {
        *0x2::vec_map::get<0x2::object::ID, u128>(&0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).reward, &arg2)
    }

    public fun borrow_bullet_purchase_cooldown(arg0: &BulletStore) : u64 {
        arg0.bullet_purchase_cooldown_ms
    }

    public fun borrow_hospitalization_ms(arg0: &BattleSessionRegistry) : u64 {
        arg0.hospitalization_time
    }

    public fun borrow_recover_coin_mist(arg0: &BulletStore) : u64 {
        arg0.recovery_coin_mist
    }

    public fun borrow_store_treasury(arg0: &BulletStore) : address {
        arg0.treasury
    }

    public(friend) fun borrow_winner_id(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).winner_id
    }

    public fun can_reset(arg0: &BulletStore, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiration_duration_ms
    }

    public(friend) fun claim_reward(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID) : u128 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_bounty_session, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.active_bounty_session, v1);
        };
        let BattleBountySession {
            target_player_id        : _,
            bounty_assign_by        : _,
            count                   : _,
            reward                  : _,
            total_reward            : v6,
            winner_id               : _,
            status                  : _,
            created_at              : _,
            is_attack               : _,
            bounty_hunter_player_id : _,
            attacker_id             : _,
        } = 0x2::table::remove<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1);
        v6
    }

    public(friend) fun close_bounty(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : u128 {
        remove_active_session(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg2);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&v0.bounty_assign_by, &arg1);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut v0.bounty_assign_by, v2);
        };
        v0.count = v0.count - 1;
        let (_, v4) = 0x2::vec_map::remove<0x2::object::ID, u128>(&mut v0.reward, &arg1);
        v0.total_reward = v0.total_reward - v4;
        v4
    }

    public(friend) fun create_bounty_session(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: &0x2::clock::Clock) {
        if (0x2::table::contains<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0.bounty_assign_by, arg1);
            0x2::vec_map::insert<0x2::object::ID, u128>(&mut v0.reward, arg1, arg3);
            v0.total_reward = v0.total_reward + arg3;
            v0.count = v0.count + 1;
        } else {
            let v1 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v1, arg1);
            let v2 = BattleBountySession{
                target_player_id        : arg2,
                bounty_assign_by        : v1,
                count                   : 1,
                reward                  : 0x2::vec_map::empty<0x2::object::ID, u128>(),
                total_reward            : arg3,
                winner_id               : 0x2::object::id_from_address(@0x0),
                status                  : 0,
                created_at              : 0x2::clock::timestamp_ms(arg4),
                is_attack               : false,
                bounty_hunter_player_id : 0x1::vector::empty<0x2::object::ID>(),
                attacker_id             : 0x2::object::id_from_address(@0x0),
            };
            0x2::vec_map::insert<0x2::object::ID, u128>(&mut v2.reward, arg1, arg3);
            0x2::table::add<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg2, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_bounty_session, arg2);
        };
        arg0.total_battles = arg0.total_battles + 1;
    }

    public(friend) fun evaluate_winner(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : u128 {
        let v0 = 0;
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1);
        if (arg2 == arg3) {
            v1.winner_id = v1.attacker_id;
            v1.status = 2;
            v0 = claim_reward(arg0, arg1);
        } else {
            v1.is_attack = false;
            v1.status = 0;
        };
        v0
    }

    public(friend) fun get_attacker_id(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).attacker_id
    }

    public fun get_bounty_session(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : BattleBountySession {
        *0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1)
    }

    public(friend) fun has_target_player(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1)
    }

    public(friend) fun initialize_and_transfer_luca_cap(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        let v0 = LucaCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<LucaCap>(v0, arg2);
    }

    public(friend) fun initialize_bullet_store(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: address, arg10: address, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = BulletStore{
            id                          : 0x2::object::new(arg13),
            initial_price               : arg0,
            next_expire_at              : 0x2::clock::timestamp_ms(arg12) + arg1,
            expiration_duration_ms      : arg1,
            bullet_purchase_cooldown_ms : arg2,
            max_supply                  : arg3,
            max_buy                     : arg5,
            store                       : arg6,
            recovery_coin_mist          : arg7,
            treasury                    : arg10,
            owner                       : arg9,
        };
        0x2::transfer::share_object<BulletStore>(v0);
        let v1 = BattleSessionRegistry{
            id                      : 0x2::object::new(arg13),
            total_battles           : 0,
            max_idle_time           : 300000,
            hospitalization_time    : arg8,
            bounty_assign_to_target : 0x2::table::new<0x2::object::ID, BattleBountySession>(arg13),
            min_bullet              : arg4,
            min_bounty              : arg11,
            active_bounty_session   : 0x1::vector::empty<0x2::object::ID>(),
            paused                  : false,
        };
        0x2::transfer::share_object<BattleSessionRegistry>(v1);
    }

    public(friend) fun initialize_magazine(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, arg0);
        0x1::vector::push_back<0x2::object::ID>(v1, arg1);
        let v2 = MagazineInfo{
            id        : 0x2::object::new(arg2),
            magazine  : 0x1::vector::empty<u8>(),
            player_id : arg0,
            allowlist : v0,
        };
        0x2::transfer::share_object<MagazineInfo>(v2);
        0x2::object::id<MagazineInfo>(&v2)
    }

    public fun is_allowlisted(arg0: &MagazineInfo, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.allowlist, &arg1)
    }

    public(friend) fun is_attack(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).is_attack
    }

    public(friend) fun is_bounty_assigner(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg2).bounty_assign_by, &arg1)
    }

    public(friend) fun is_bounty_paused(arg0: &BattleSessionRegistry) : bool {
        arg0.paused
    }

    public(friend) fun is_bounty_started(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).status == 1
    }

    public(friend) fun is_bounty_waiting(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).status == 0
    }

    public fun is_owner(arg0: &BulletStore, arg1: address) : bool {
        arg0.owner == arg1
    }

    public(friend) fun is_valid_player(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : bool {
        arg0 != arg1
    }

    public(friend) fun max_count(arg0: &BattleSessionRegistry, arg1: 0x2::object::ID) : u8 {
        0x2::table::borrow<0x2::object::ID, BattleBountySession>(&arg0.bounty_assign_to_target, arg1).count
    }

    public(friend) fun max_idle_time(arg0: &BattleSessionRegistry) : u64 {
        arg0.max_idle_time
    }

    public(friend) fun min_bounty(arg0: &BattleSessionRegistry) : u128 {
        arg0.min_bounty
    }

    public(friend) fun min_bullet(arg0: &BattleSessionRegistry) : u64 {
        arg0.min_bullet
    }

    public(friend) fun pay_off_bounty(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1);
        let (_, _) = 0x2::vec_map::remove_entry_by_idx<0x2::object::ID, u128>(&mut v0.reward, 0x2::vec_map::get_idx<0x2::object::ID, u128>(&v0.reward, &arg2));
    }

    fun remove_active_session(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID) {
        if (0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1).count == 1) {
            0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1);
            let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_bounty_session, &arg1);
            if (v0) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_bounty_session, v1);
                0x2::table::remove<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg1);
            };
        };
    }

    public(friend) fun reset_store(arg0: &mut BulletStore, arg1: &0x2::clock::Clock) {
        arg0.next_expire_at = 0x2::clock::timestamp_ms(arg1) + arg0.expiration_duration_ms;
    }

    public(friend) fun set_hospitalization_time(arg0: &mut BattleSessionRegistry, arg1: u64) {
        arg0.hospitalization_time = arg1;
    }

    public(friend) fun set_magazine(arg0: &mut MagazineInfo, arg1: vector<u8>) {
        arg0.magazine = arg1;
    }

    public(friend) fun set_max_idle_time(arg0: &mut BattleSessionRegistry, arg1: u64) {
        arg0.max_idle_time = arg1;
    }

    public(friend) fun set_min_bounty(arg0: &mut BattleSessionRegistry, arg1: u128) {
        arg0.min_bounty = arg1;
    }

    public(friend) fun set_min_bullet(arg0: &mut BattleSessionRegistry, arg1: u64) {
        arg0.min_bullet = arg1;
    }

    public(friend) fun set_store_id(arg0: &mut BulletStore, arg1: vector<u8>) {
        arg0.store = arg1;
    }

    public(friend) fun set_store_owner(arg0: &mut BulletStore, arg1: address) {
        arg0.owner = arg1;
    }

    public(friend) fun set_store_values(arg0: &mut BulletStore, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address) {
        arg0.initial_price = arg1;
        arg0.expiration_duration_ms = arg2;
        arg0.bullet_purchase_cooldown_ms = arg3;
        arg0.recovery_coin_mist = arg4;
        arg0.max_buy = arg6;
        arg0.max_supply = arg5;
        arg0.owner = arg7;
        arg0.treasury = arg8;
    }

    public(friend) fun shoot(arg0: &mut BattleSessionRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BattleBountySession>(&mut arg0.bounty_assign_to_target, arg2);
        v0.is_attack = true;
        0x1::vector::push_back<0x2::object::ID>(&mut v0.bounty_hunter_player_id, arg1);
        v0.attacker_id = arg1;
        v0.status = 1;
    }

    // decompiled from Move bytecode v6
}

