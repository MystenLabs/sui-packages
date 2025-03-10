module 0x1c0ce7de75f8c0dbba275cf03fbe77081e82fe6146ab3a5f036df4528d712736::general {
    struct AdminRegistry has store, key {
        id: 0x2::object::UID,
        super_admin: address,
        admins: 0x2::table::Table<address, bool>,
    }

    struct Player has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::table::Table<0x1::string::String, Reward>,
        reward_count: u64,
        completed_challenges: 0x2::table::Table<0x1::string::String, Challenge>,
        completed_challenges_count: u64,
    }

    struct PlayerDirectory has store, key {
        id: 0x2::object::UID,
        counter: u64,
        players: 0x2::table::Table<address, Player>,
    }

    struct Challenge has store, key {
        id: 0x2::object::UID,
        external_id: 0x1::string::String,
        challenge_status: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        completed_timestamp: u64,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        external_id: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        roblox_compatible_link: 0x1::string::String,
        telegram_compatible_link: 0x1::string::String,
        reward_status: 0x1::string::String,
        claim_timestamp: u64,
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 8);
        assert!(!0x2::table::contains<address, bool>(&arg0.admins, arg1), 9);
        0x2::table::add<address, bool>(&mut arg0.admins, arg1, true);
    }

    fun add_challenge_if_not_exists(arg0: &mut Player, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x1::string::String, Challenge>(&arg0.completed_challenges, arg1)) {
            0x2::table::add<0x1::string::String, Challenge>(&mut arg0.completed_challenges, arg1, create_challenge(arg1, arg2, arg3, arg4));
        };
    }

    public entry fun add_completed_challenge(arg0: &AdminRegistry, arg1: address, arg2: &mut PlayerDirectory, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg12)), 8);
        validate_add_challenge_params(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        if (0x2::table::contains<address, Player>(&arg2.players, arg1)) {
            handle_existing_player(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        } else {
            create_new_player(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        };
    }

    fun add_reward_if_not_exists(arg0: &mut Player, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x1::string::String, Reward>(&arg0.rewards, arg1)) {
            0x2::table::add<0x1::string::String, Reward>(&mut arg0.rewards, arg1, create_reward(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
            arg0.reward_count = arg0.reward_count + 1;
        };
    }

    public fun admin_exists(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    fun create_challenge(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Challenge {
        Challenge{
            id                  : 0x2::object::new(arg3),
            external_id         : arg0,
            challenge_status    : 0x1::string::utf8(b"completed"),
            title               : arg1,
            description         : arg2,
            completed_timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        }
    }

    fun create_new_player(arg0: &mut PlayerDirectory, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = create_player(arg11);
        let v1 = create_challenge(arg2, arg3, arg4, arg11);
        0x2::table::add<0x1::string::String, Challenge>(&mut v0.completed_challenges, arg2, v1);
        0x2::table::add<0x1::string::String, Reward>(&mut v0.rewards, arg5, create_reward(arg5, arg6, arg7, arg8, arg9, arg10, arg11));
        0x2::table::add<address, Player>(&mut arg0.players, arg1, v0);
        arg0.counter = arg0.counter + 1;
    }

    fun create_player(arg0: &mut 0x2::tx_context::TxContext) : Player {
        Player{
            id                         : 0x2::object::new(arg0),
            rewards                    : 0x2::table::new<0x1::string::String, Reward>(arg0),
            reward_count               : 1,
            completed_challenges       : 0x2::table::new<0x1::string::String, Challenge>(arg0),
            completed_challenges_count : 1,
        }
    }

    fun create_reward(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Reward {
        Reward{
            id                       : 0x2::object::new(arg6),
            external_id              : arg0,
            description              : arg1,
            image_url                : arg2,
            name                     : arg3,
            roblox_compatible_link   : arg4,
            telegram_compatible_link : arg5,
            reward_status            : 0x1::string::utf8(b"unclaimed"),
            claim_timestamp          : 0,
        }
    }

    public fun get_admin_registry_id(arg0: &AdminRegistry) : 0x2::object::ID {
        0x2::object::id<AdminRegistry>(arg0)
    }

    public fun get_challenge_details(arg0: &PlayerDirectory, arg1: address, arg2: 0x1::string::String) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64) {
        validate_string(&arg2);
        validate_player_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<address, Player>(&arg0.players, arg1);
        validate_challenge_exists(v0, &arg2);
        let v1 = 0x2::table::borrow<0x1::string::String, Challenge>(&v0.completed_challenges, arg2);
        (v1.title, v1.description, v1.challenge_status, v1.completed_timestamp)
    }

    public fun get_player(arg0: &PlayerDirectory, arg1: address) : &Player {
        validate_player_exists(arg0, arg1);
        0x2::table::borrow<address, Player>(&arg0.players, arg1)
    }

    public fun get_player_completed_challenges(arg0: &PlayerDirectory, arg1: address) : (0x2::object::ID, u64) {
        validate_player_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<address, Player>(&arg0.players, arg1);
        (0x2::object::id<0x2::table::Table<0x1::string::String, Challenge>>(&v0.completed_challenges), v0.completed_challenges_count)
    }

    public fun get_player_details(arg0: &PlayerDirectory, arg1: address) : (u64, u64) {
        validate_player_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<address, Player>(&arg0.players, arg1);
        (v0.reward_count, v0.completed_challenges_count)
    }

    public fun get_player_directory(arg0: &PlayerDirectory) : (0x2::object::ID, u64) {
        (0x2::object::id<0x2::table::Table<address, Player>>(&arg0.players), arg0.counter)
    }

    public fun get_player_rewards(arg0: &PlayerDirectory, arg1: address) : (0x2::object::ID, u64) {
        validate_player_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<address, Player>(&arg0.players, arg1);
        (0x2::object::id<0x2::table::Table<0x1::string::String, Reward>>(&v0.rewards), v0.reward_count)
    }

    public fun get_reward_details(arg0: &PlayerDirectory, arg1: address, arg2: 0x1::string::String) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        validate_string(&arg2);
        validate_player_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<address, Player>(&arg0.players, arg1);
        validate_reward_exists(v0, &arg2);
        let v1 = 0x2::table::borrow<0x1::string::String, Reward>(&v0.rewards, arg2);
        (v1.name, v1.description, v1.image_url, v1.reward_status)
    }

    public fun get_super_admin(arg0: &AdminRegistry) : address {
        arg0.super_admin
    }

    fun handle_existing_player(arg0: &mut PlayerDirectory, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<address, Player>(&mut arg0.players, arg1);
        v0.completed_challenges_count = v0.completed_challenges_count + 1;
        add_challenge_if_not_exists(v0, arg2, arg3, arg4, arg11);
        add_reward_if_not_exists(v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerDirectory{
            id      : 0x2::object::new(arg0),
            counter : 0,
            players : 0x2::table::new<address, Player>(arg0),
        };
        0x2::transfer::share_object<PlayerDirectory>(v0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = AdminRegistry{
            id          : 0x2::object::new(arg0),
            super_admin : v1,
            admins      : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v2.admins, v1, true);
        0x2::transfer::share_object<AdminRegistry>(v2);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun is_super_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg1 == arg0.super_admin
    }

    fun mint_reward(arg0: &Reward, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x1c0ce7de75f8c0dbba275cf03fbe77081e82fe6146ab3a5f036df4528d712736::playnet_nft::mint_to_recipient(arg0.external_id, arg0.name, arg0.description, arg0.image_url, arg0.telegram_compatible_link, arg0.roblox_compatible_link, arg1, arg2);
        true
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 8);
        assert!(arg1 != arg0.super_admin, 8);
        assert!(0x2::table::contains<address, bool>(&arg0.admins, arg1), 10);
        0x2::table::remove<address, bool>(&mut arg0.admins, arg1);
    }

    public entry fun update_claimed_rewards(arg0: &AdminRegistry, arg1: address, arg2: &mut PlayerDirectory, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 8);
        validate_string(&arg3);
        validate_player_exists(arg2, arg1);
        let v0 = 0x2::table::borrow_mut<address, Player>(&mut arg2.players, arg1);
        validate_reward_exists(v0, &arg3);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Reward>(&mut v0.rewards, arg3);
        assert!(v1.reward_status != 0x1::string::utf8(b"claimed"), 2);
        assert!(mint_reward(v1, arg1, arg4), 4);
        v1.reward_status = 0x1::string::utf8(b"claimed");
        v1.claim_timestamp = 0x2::tx_context::epoch_timestamp_ms(arg4);
    }

    fun validate_add_challenge_params(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String) {
        assert!(arg0 != @0x0, 3);
        validate_string(&arg1);
        validate_string(&arg2);
        validate_string(&arg3);
        validate_string(&arg4);
        validate_string(&arg5);
        validate_string(&arg6);
        validate_string(&arg7);
        validate_string(&arg8);
        validate_string(&arg9);
    }

    fun validate_challenge_exists(arg0: &Player, arg1: &0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, Challenge>(&arg0.completed_challenges, *arg1), 7);
    }

    fun validate_player_exists(arg0: &PlayerDirectory, arg1: address) {
        assert!(0x2::table::contains<address, Player>(&arg0.players, arg1), 0);
    }

    fun validate_reward_exists(arg0: &Player, arg1: &0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, Reward>(&arg0.rewards, *arg1), 1);
    }

    fun validate_string(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 5);
        assert!(0x1::string::length(arg0) <= 256, 6);
    }

    // decompiled from Move bytecode v6
}

