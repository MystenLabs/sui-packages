module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account {
    struct Account has key {
        id: 0x2::object::UID,
        handle: 0x1::string::String,
        owner_address: address,
        authorized_addresses: 0x2::vec_set::VecSet<address>,
        platform_binding_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        sponsor_vault_id: 0x1::option::Option<0x2::object::ID>,
        subscription_id: 0x1::option::Option<0x2::object::ID>,
        suins_subdomain: 0x1::option::Option<0x1::string::String>,
        image_url: 0x1::option::Option<0x1::string::String>,
        purchased_credits: u64,
        bonus_credits: u64,
        total_purchased: u64,
        total_spent: u64,
        total_won: u64,
        total_bonus_received: u64,
        total_bonus_spent: u64,
        challenges_entered: u64,
        challenges_won: u64,
        challenges_lost: u64,
        tournaments_entered: u64,
        tournaments_won: u64,
        tournaments_first_place: u64,
        tournaments_left: u64,
        reputation_positive: u64,
        reputation_negative: u64,
        last_redemption_at: u64,
        redemption_cooldown_until: u64,
        created_at: u64,
        nonce: u64,
    }

    struct AccountAuth {
        account_id: 0x2::object::ID,
        authorized_address: address,
    }

    struct GameStatsKey has copy, drop, store {
        game_type: 0x1::string::String,
    }

    struct GameStats has store {
        mmr: u64,
        games_played: u64,
        challenges_entered: u64,
        challenges_won: u64,
        challenges_lost: u64,
        tournaments_entered: u64,
        tournaments_won: u64,
        tournaments_left: u64,
        last_updated: u64,
    }

    struct AdminDataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminData has store {
        is_flagged: bool,
        is_banned: bool,
        is_trusted: bool,
        trust_score: u64,
        risk_score: u64,
        notes: 0x1::string::String,
        last_reviewed: u64,
        verified_max_multiplier: u64,
        universal_mmr: u64,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        handle: 0x1::string::String,
        owner_address: address,
    }

    struct AccountDeleted has copy, drop {
        account_id: 0x2::object::ID,
        handle: 0x1::string::String,
        owner_address: address,
    }

    struct AddressAuthorized has copy, drop {
        account_id: 0x2::object::ID,
        new_address: address,
        authorized_by: address,
    }

    struct AddressRevoked has copy, drop {
        account_id: 0x2::object::ID,
        revoked_address: address,
        revoked_by: address,
    }

    struct PlatformBindingAdded has copy, drop {
        account_id: 0x2::object::ID,
        binding_id: 0x2::object::ID,
    }

    struct PlatformBindingRemoved has copy, drop {
        account_id: 0x2::object::ID,
        binding_id: 0x2::object::ID,
    }

    struct SponsorVaultLinked has copy, drop {
        account_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct SponsorVaultUnlinked has copy, drop {
        account_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    struct ZenkoPassLinked has copy, drop {
        account_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
    }

    struct ZenkoPassUnlinked has copy, drop {
        account_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
    }

    struct CreditsPurchased has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct PurchasedCreditsGranted has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        reason: 0x1::string::String,
        granted_by: address,
        new_balance: u64,
    }

    struct CreditsSpent has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        bonus_used: u64,
        regular_used: u64,
        purpose: 0x1::string::String,
        new_bonus_balance: u64,
        new_regular_balance: u64,
    }

    struct CreditsRefunded has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        bonus_refunded: u64,
        regular_refunded: u64,
        reason: 0x1::string::String,
        new_bonus_balance: u64,
        new_regular_balance: u64,
    }

    struct CreditsWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct BonusCreditsReceived has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        source: 0x1::string::String,
        new_balance: u64,
    }

    struct ChallengeStatsUpdated has copy, drop {
        account_id: 0x2::object::ID,
        challenges_entered: u64,
        challenges_won: u64,
        challenges_lost: u64,
        total_won: u64,
    }

    struct TournamentStatsUpdated has copy, drop {
        account_id: 0x2::object::ID,
        tournaments_entered: u64,
        tournaments_won: u64,
        tournaments_first_place: u64,
        tournaments_left: u64,
        total_won: u64,
    }

    struct TournamentLeftRecorded has copy, drop {
        account_id: 0x2::object::ID,
        tournaments_entered: u64,
        tournaments_left: u64,
    }

    struct ReputationChanged has copy, drop {
        account_id: 0x2::object::ID,
        reputation_positive: u64,
        reputation_negative: u64,
        net_reputation: u64,
        net_is_positive: bool,
        delta: u64,
        is_reward: bool,
        reason: 0x1::string::String,
    }

    struct GameStatsUpdated has copy, drop {
        account_id: 0x2::object::ID,
        game_type: 0x1::string::String,
        mmr: u64,
        games_played: u64,
        challenges_won: u64,
        challenges_lost: u64,
        tournaments_won: u64,
        tournaments_left: u64,
    }

    struct AdminDataUpdated has copy, drop {
        account_id: 0x2::object::ID,
        is_flagged: bool,
        is_banned: bool,
        is_trusted: bool,
        trust_score: u64,
        risk_score: u64,
        updated_by: address,
    }

    public fun id(arg0: &Account) : 0x2::object::ID {
        0x2::object::id<Account>(arg0)
    }

    public(friend) fun add_bonus_credits(arg0: &mut Account, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        arg0.bonus_credits = arg0.bonus_credits + arg1;
        arg0.total_bonus_received = arg0.total_bonus_received + arg1;
        let v0 = BonusCreditsReceived{
            account_id  : 0x2::object::id<Account>(arg0),
            amount      : arg1,
            source      : arg2,
            new_balance : arg0.bonus_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<BonusCreditsReceived>(v0);
    }

    public(friend) fun add_platform_binding(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.platform_binding_ids, &arg1), 5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.platform_binding_ids, arg1);
        let v0 = PlatformBindingAdded{
            account_id : 0x2::object::id<Account>(arg0),
            binding_id : arg1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformBindingAdded>(v0);
    }

    public(friend) fun add_purchased_credits(arg0: &mut Account, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        arg0.purchased_credits = arg0.purchased_credits + arg1;
        arg0.total_purchased = arg0.total_purchased + arg1;
        let v0 = CreditsPurchased{
            account_id  : 0x2::object::id<Account>(arg0),
            amount      : arg1,
            new_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsPurchased>(v0);
    }

    public fun adjust_reputation(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: u64, arg3: bool, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg5);
        adjust_reputation_(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun adjust_reputation_(arg0: &mut Account, arg1: u64, arg2: bool, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        if (arg2) {
            arg0.reputation_positive = arg0.reputation_positive + arg1;
        } else {
            arg0.reputation_negative = arg0.reputation_negative + arg1;
        };
        let (v0, v1) = if (arg0.reputation_positive >= arg0.reputation_negative) {
            (arg0.reputation_positive - arg0.reputation_negative, true)
        } else {
            (arg0.reputation_negative - arg0.reputation_positive, false)
        };
        let v2 = ReputationChanged{
            account_id          : 0x2::object::id<Account>(arg0),
            reputation_positive : arg0.reputation_positive,
            reputation_negative : arg0.reputation_negative,
            net_reputation      : v0,
            net_is_positive     : v1,
            delta               : arg1,
            is_reward           : arg2,
            reason              : arg3,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ReputationChanged>(v2);
    }

    public fun auth_account_id(arg0: &AccountAuth) : 0x2::object::ID {
        arg0.account_id
    }

    public fun authorize_address(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &mut Account, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner_address, 75);
        0x2::vec_set::insert<address>(&mut arg1.authorized_addresses, arg2);
        let v1 = AddressAuthorized{
            account_id    : 0x2::object::id<Account>(arg1),
            new_address   : arg2,
            authorized_by : v0,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AddressAuthorized>(v1);
    }

    public fun authorize_for_transaction(arg0: &Account, arg1: &0x2::tx_context::TxContext) : AccountAuth {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_authorized(arg0, v0), 0);
        AccountAuth{
            account_id         : 0x2::object::id<Account>(arg0),
            authorized_address : v0,
        }
    }

    fun build_account_creation_message(arg0: &address, arg1: &0x1::string::String, arg2: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"5a4e4b3a4143433a4352454154453a563100");
        0x1::vector::push_back<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::network_id());
        0x1::vector::append<u8>(&mut v0, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::original_package_id_bytes());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public(friend) fun clear_sponsor_vault(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.sponsor_vault_id)) {
            let v0 = SponsorVaultUnlinked{
                account_id : 0x2::object::id<Account>(arg0),
                vault_id   : 0x1::option::extract<0x2::object::ID>(&mut arg0.sponsor_vault_id),
            };
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SponsorVaultUnlinked>(v0);
        };
    }

    public(friend) fun clear_subscription(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.subscription_id)) {
            let v0 = ZenkoPassUnlinked{
                account_id : 0x2::object::id<Account>(arg0),
                pass_id    : 0x1::option::extract<0x2::object::ID>(&mut arg0.subscription_id),
            };
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ZenkoPassUnlinked>(v0);
        };
    }

    public fun consume_authorization(arg0: AccountAuth) {
        let AccountAuth {
            account_id         : _,
            authorized_address : _,
        } = arg0;
    }

    public(friend) fun consume_nonce(arg0: &mut Account, arg1: u64) {
        assert!(arg0.nonce == arg1, 23);
        arg0.nonce = arg0.nonce + 1;
    }

    public fun create_account(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 17);
        assert!(0x1::vector::length<u8>(&arg5) == 33, 18);
        assert!(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::is_oracle_authorized(arg0, arg5), 16);
        assert!(arg3 <= v1, 20);
        assert!(v1 - arg3 <= 600000, 19);
        let v2 = build_account_creation_message(&v0, &arg2, arg3);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg4, &arg5, &v2, 1), 15);
        validate_handle(&arg2);
        assert!(!0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::is_handle_taken(arg0, arg2), 2);
        let v3 = Account{
            id                        : 0x2::object::new(arg6),
            handle                    : arg2,
            owner_address             : v0,
            authorized_addresses      : 0x2::vec_set::singleton<address>(v0),
            platform_binding_ids      : 0x2::vec_set::empty<0x2::object::ID>(),
            sponsor_vault_id          : 0x1::option::none<0x2::object::ID>(),
            subscription_id           : 0x1::option::none<0x2::object::ID>(),
            suins_subdomain           : 0x1::option::none<0x1::string::String>(),
            image_url                 : 0x1::option::none<0x1::string::String>(),
            purchased_credits         : 0,
            bonus_credits             : 0,
            total_purchased           : 0,
            total_spent               : 0,
            total_won                 : 0,
            total_bonus_received      : 0,
            total_bonus_spent         : 0,
            challenges_entered        : 0,
            challenges_won            : 0,
            challenges_lost           : 0,
            tournaments_entered       : 0,
            tournaments_won           : 0,
            tournaments_first_place   : 0,
            tournaments_left          : 0,
            reputation_positive       : 0,
            reputation_negative       : 0,
            last_redemption_at        : 0,
            redemption_cooldown_until : 0,
            created_at                : v1,
            nonce                     : 0,
        };
        let v4 = 0x2::object::id<Account>(&v3);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::register_handle(arg0, arg2, v4, arg6);
        let v5 = &mut v3;
        adjust_reputation_(v5, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_set_username(), true, 0x1::string::utf8(b"set_username"), arg6);
        let v6 = AccountCreated{
            account_id    : v4,
            handle        : v3.handle,
            owner_address : v0,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AccountCreated>(v6);
        0x2::transfer::share_object<Account>(v3);
    }

    public fun delete_account(arg0: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: Account, arg2: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::assert_version(arg0);
        assert!(is_authorized(&arg1, 0x2::tx_context::sender(arg2)), 0);
        assert!(arg1.purchased_credits == 0 && arg1.bonus_credits == 0, 21);
        assert!(0x2::vec_set::is_empty<0x2::object::ID>(&arg1.platform_binding_ids), 22);
        let v0 = arg1.handle;
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::unregister_handle(arg0, v0);
        let Account {
            id                        : v1,
            handle                    : _,
            owner_address             : _,
            authorized_addresses      : _,
            platform_binding_ids      : _,
            sponsor_vault_id          : _,
            subscription_id           : _,
            suins_subdomain           : _,
            image_url                 : _,
            purchased_credits         : _,
            bonus_credits             : _,
            total_purchased           : _,
            total_spent               : _,
            total_won                 : _,
            total_bonus_received      : _,
            total_bonus_spent         : _,
            challenges_entered        : _,
            challenges_won            : _,
            challenges_lost           : _,
            tournaments_entered       : _,
            tournaments_won           : _,
            tournaments_first_place   : _,
            tournaments_left          : _,
            reputation_positive       : _,
            reputation_negative       : _,
            last_redemption_at        : _,
            redemption_cooldown_until : _,
            created_at                : _,
            nonce                     : _,
        } = arg1;
        0x2::object::delete(v1);
        let v30 = AccountDeleted{
            account_id    : 0x2::object::id<Account>(&arg1),
            handle        : v0,
            owner_address : arg1.owner_address,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AccountDeleted>(v30);
    }

    fun ensure_admin_data_exists(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        let v0 = AdminDataKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AdminDataKey>(&arg0.id, v0)) {
            let v1 = AdminData{
                is_flagged              : false,
                is_banned               : false,
                is_trusted              : false,
                trust_score             : 5000,
                risk_score              : 0,
                notes                   : 0x1::string::utf8(b""),
                last_reviewed           : 0,
                verified_max_multiplier : 0,
                universal_mmr           : 1500,
            };
            0x2::dynamic_field::add<AdminDataKey, AdminData>(&mut arg0.id, v0, v1);
        };
    }

    public fun get_admin_data(arg0: &Account) : (bool, bool, bool, u64, u64, u64, u64) {
        let v0 = AdminDataKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AdminDataKey>(&arg0.id, v0)) {
            let v8 = 0x2::dynamic_field::borrow<AdminDataKey, AdminData>(&arg0.id, v0);
            (v8.is_flagged, v8.is_banned, v8.is_trusted, v8.trust_score, v8.risk_score, v8.verified_max_multiplier, v8.universal_mmr)
        } else {
            (false, false, false, 5000, 0, 0, 1500)
        }
    }

    public fun get_game_stats(arg0: &Account, arg1: 0x1::string::String) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = GameStatsKey{game_type: arg1};
        if (0x2::dynamic_field::exists<GameStatsKey>(&arg0.id, v0)) {
            let v9 = 0x2::dynamic_field::borrow<GameStatsKey, GameStats>(&arg0.id, v0);
            (v9.mmr, v9.games_played, v9.challenges_entered, v9.challenges_won, v9.challenges_lost, v9.tournaments_entered, v9.tournaments_won, v9.tournaments_left)
        } else {
            (0, 0, 0, 0, 0, 0, 0, 0)
        }
    }

    public(friend) fun get_or_create_game_stats(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) : &mut GameStats {
        let v0 = GameStatsKey{game_type: arg1};
        if (!0x2::dynamic_field::exists<GameStatsKey>(&arg0.id, v0)) {
            let v1 = GameStats{
                mmr                 : 1500,
                games_played        : 0,
                challenges_entered  : 0,
                challenges_won      : 0,
                challenges_lost     : 0,
                tournaments_entered : 0,
                tournaments_won     : 0,
                tournaments_left    : 0,
                last_updated        : 0,
            };
            0x2::dynamic_field::add<GameStatsKey, GameStats>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_field::borrow_mut<GameStatsKey, GameStats>(&mut arg0.id, v0)
    }

    public fun grant_purchased_credits(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg0, arg4);
        assert!(arg2 > 0, 8);
        arg1.purchased_credits = arg1.purchased_credits + arg2;
        arg1.total_purchased = arg1.total_purchased + arg2;
        let v0 = PurchasedCreditsGranted{
            account_id  : 0x2::object::id<Account>(arg1),
            amount      : arg2,
            reason      : arg3,
            granted_by  : 0x2::tx_context::sender(arg4),
            new_balance : arg1.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PurchasedCreditsGranted>(v0);
    }

    public fun is_authorized(arg0: &Account, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized_addresses, &arg1)
    }

    public fun last_redemption_at(arg0: &Account) : u64 {
        arg0.last_redemption_at
    }

    public fun owner_address(arg0: &Account) : address {
        arg0.owner_address
    }

    public fun purchased_credits(arg0: &Account) : u64 {
        arg0.purchased_credits
    }

    public(friend) fun record_challenge_entered(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        arg0.challenges_entered = arg0.challenges_entered + 1;
    }

    public(friend) fun record_game_challenge_entered(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_game_stats(arg0, arg1, arg2);
        v0.challenges_entered = v0.challenges_entered + 1;
    }

    public(friend) fun record_game_challenge_lost(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = get_or_create_game_stats(arg0, arg1, arg2);
        v1.challenges_lost = v1.challenges_lost + 1;
        let v2 = GameStatsUpdated{
            account_id       : v0,
            game_type        : arg1,
            mmr              : v1.mmr,
            games_played     : v1.games_played,
            challenges_won   : v1.challenges_won,
            challenges_lost  : v1.challenges_lost,
            tournaments_won  : v1.tournaments_won,
            tournaments_left : v1.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameStatsUpdated>(v2);
    }

    public(friend) fun record_game_challenge_won(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = get_or_create_game_stats(arg0, arg1, arg2);
        v1.challenges_won = v1.challenges_won + 1;
        let v2 = GameStatsUpdated{
            account_id       : v0,
            game_type        : arg1,
            mmr              : v1.mmr,
            games_played     : v1.games_played,
            challenges_won   : v1.challenges_won,
            challenges_lost  : v1.challenges_lost,
            tournaments_won  : v1.tournaments_won,
            tournaments_left : v1.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameStatsUpdated>(v2);
    }

    public(friend) fun record_game_played(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_game_stats(arg0, arg1, arg2);
        v0.games_played = v0.games_played + 1;
    }

    public(friend) fun record_game_tournament_entered(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_game_stats(arg0, arg1, arg2);
        v0.tournaments_entered = v0.tournaments_entered + 1;
    }

    public(friend) fun record_game_tournament_left(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = get_or_create_game_stats(arg0, arg1, arg2);
        v1.tournaments_left = v1.tournaments_left + 1;
        let v2 = GameStatsUpdated{
            account_id       : v0,
            game_type        : arg1,
            mmr              : v1.mmr,
            games_played     : v1.games_played,
            challenges_won   : v1.challenges_won,
            challenges_lost  : v1.challenges_lost,
            tournaments_won  : v1.tournaments_won,
            tournaments_left : v1.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameStatsUpdated>(v2);
    }

    public(friend) fun record_game_tournament_won(arg0: &mut Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Account>(arg0);
        let v1 = get_or_create_game_stats(arg0, arg1, arg2);
        v1.tournaments_won = v1.tournaments_won + 1;
        let v2 = GameStatsUpdated{
            account_id       : v0,
            game_type        : arg1,
            mmr              : v1.mmr,
            games_played     : v1.games_played,
            challenges_won   : v1.challenges_won,
            challenges_lost  : v1.challenges_lost,
            tournaments_won  : v1.tournaments_won,
            tournaments_left : v1.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameStatsUpdated>(v2);
    }

    public(friend) fun record_tournament_entered(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        arg0.tournaments_entered = arg0.tournaments_entered + 1;
    }

    public(friend) fun record_tournament_left(arg0: &mut Account, arg1: &0x2::tx_context::TxContext) {
        arg0.tournaments_left = arg0.tournaments_left + 1;
        let v0 = TournamentLeftRecorded{
            account_id          : 0x2::object::id<Account>(arg0),
            tournaments_entered : arg0.tournaments_entered,
            tournaments_left    : arg0.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<TournamentLeftRecorded>(v0);
    }

    public fun redemption_cooldown_until(arg0: &Account) : u64 {
        arg0.redemption_cooldown_until
    }

    public(friend) fun refund_credits_with_breakdown(arg0: &mut Account, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg1 + arg2;
        assert!(v0 > 0, 8);
        arg0.bonus_credits = arg0.bonus_credits + arg1;
        arg0.purchased_credits = arg0.purchased_credits + arg2;
        let v1 = CreditsRefunded{
            account_id          : 0x2::object::id<Account>(arg0),
            amount              : v0,
            bonus_refunded      : arg1,
            regular_refunded    : arg2,
            reason              : arg3,
            new_bonus_balance   : arg0.bonus_credits,
            new_regular_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsRefunded>(v1);
    }

    public(friend) fun remove_platform_binding(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.platform_binding_ids, &arg1), 6);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.platform_binding_ids, &arg1);
        let v0 = PlatformBindingRemoved{
            account_id : 0x2::object::id<Account>(arg0),
            binding_id : arg1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PlatformBindingRemoved>(v0);
    }

    public(friend) fun return_purchased_credits(arg0: &mut Account, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        arg0.purchased_credits = arg0.purchased_credits + arg1;
        let v0 = CreditsRefunded{
            account_id          : 0x2::object::id<Account>(arg0),
            amount              : arg1,
            bonus_refunded      : 0,
            regular_refunded    : arg1,
            reason              : arg2,
            new_bonus_balance   : arg0.bonus_credits,
            new_regular_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsRefunded>(v0);
    }

    public fun revoke_address(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::ZenkoRegistry, arg1: &mut Account, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::zenko::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner_address, 3);
        assert!(arg2 != arg1.owner_address, 4);
        0x2::vec_set::remove<address>(&mut arg1.authorized_addresses, &arg2);
        let v1 = AddressRevoked{
            account_id      : 0x2::object::id<Account>(arg1),
            revoked_address : arg2,
            revoked_by      : v0,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AddressRevoked>(v1);
    }

    public fun set_banned(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: bool, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg0, arg5);
        let v0 = 0x2::object::id<Account>(arg1);
        ensure_admin_data_exists(arg1, arg5);
        let v1 = AdminDataKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v1);
        v2.is_banned = arg2;
        v2.notes = arg3;
        v2.last_reviewed = 0x2::clock::timestamp_ms(arg4);
        let v3 = AdminDataUpdated{
            account_id  : v0,
            is_flagged  : v2.is_flagged,
            is_banned   : v2.is_banned,
            is_trusted  : v2.is_trusted,
            trust_score : v2.trust_score,
            risk_score  : v2.risk_score,
            updated_by  : 0x2::tx_context::sender(arg5),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AdminDataUpdated>(v3);
    }

    public fun set_flagged(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: bool, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg5);
        let v0 = 0x2::object::id<Account>(arg1);
        ensure_admin_data_exists(arg1, arg5);
        let v1 = AdminDataKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v1);
        v2.is_flagged = arg2;
        v2.notes = arg3;
        v2.last_reviewed = 0x2::clock::timestamp_ms(arg4);
        let v3 = AdminDataUpdated{
            account_id  : v0,
            is_flagged  : v2.is_flagged,
            is_banned   : v2.is_banned,
            is_trusted  : v2.is_trusted,
            trust_score : v2.trust_score,
            risk_score  : v2.risk_score,
            updated_by  : 0x2::tx_context::sender(arg5),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AdminDataUpdated>(v3);
    }

    public fun set_profile_image(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg3);
        if (0x1::string::is_empty(&arg2)) {
            arg1.image_url = 0x1::option::none<0x1::string::String>();
        } else {
            arg1.image_url = 0x1::option::some<0x1::string::String>(arg2);
        };
    }

    public(friend) fun set_sponsor_vault(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        arg0.sponsor_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = SponsorVaultLinked{
            account_id : 0x2::object::id<Account>(arg0),
            vault_id   : arg1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SponsorVaultLinked>(v0);
    }

    public(friend) fun set_subscription(arg0: &mut Account, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        arg0.subscription_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v0 = ZenkoPassLinked{
            account_id : 0x2::object::id<Account>(arg0),
            pass_id    : arg1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ZenkoPassLinked>(v0);
    }

    public fun set_suins_name(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg3);
        if (0x1::string::is_empty(&arg2)) {
            arg1.suins_subdomain = 0x1::option::none<0x1::string::String>();
        } else {
            arg1.suins_subdomain = 0x1::option::some<0x1::string::String>(arg2);
        };
    }

    public fun set_trusted(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg0, arg4);
        let v0 = 0x2::object::id<Account>(arg1);
        ensure_admin_data_exists(arg1, arg4);
        let v1 = AdminDataKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v1);
        v2.is_trusted = arg2;
        v2.last_reviewed = 0x2::clock::timestamp_ms(arg3);
        let v3 = AdminDataUpdated{
            account_id  : v0,
            is_flagged  : v2.is_flagged,
            is_banned   : v2.is_banned,
            is_trusted  : v2.is_trusted,
            trust_score : v2.trust_score,
            risk_score  : v2.risk_score,
            updated_by  : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AdminDataUpdated>(v3);
    }

    public fun set_verified_multiplier(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg4);
        let v0 = 0x2::object::id<Account>(arg1);
        ensure_admin_data_exists(arg1, arg4);
        let v1 = if (arg2 > 10000000) {
            10000000
        } else {
            arg2
        };
        let v2 = AdminDataKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v2);
        v3.verified_max_multiplier = v1;
        v3.last_reviewed = 0x2::clock::timestamp_ms(arg3);
        let v4 = AdminDataUpdated{
            account_id  : v0,
            is_flagged  : v3.is_flagged,
            is_banned   : v3.is_banned,
            is_trusted  : v3.is_trusted,
            trust_score : v3.trust_score,
            risk_score  : v3.risk_score,
            updated_by  : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AdminDataUpdated>(v4);
    }

    public(friend) fun spend_credits_with_breakdown(arg0: &mut Account, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1 > 0, 8);
        assert!(arg0.bonus_credits + arg0.purchased_credits >= arg1, 7);
        let v0 = if (arg0.bonus_credits >= arg1) {
            arg1
        } else {
            arg0.bonus_credits
        };
        let v1 = arg1 - v0;
        arg0.bonus_credits = arg0.bonus_credits - v0;
        arg0.purchased_credits = arg0.purchased_credits - v1;
        arg0.total_spent = arg0.total_spent + v1;
        arg0.total_bonus_spent = arg0.total_bonus_spent + v0;
        let v2 = CreditsSpent{
            account_id          : 0x2::object::id<Account>(arg0),
            amount              : arg1,
            bonus_used          : v0,
            regular_used        : v1,
            purpose             : arg2,
            new_bonus_balance   : arg0.bonus_credits,
            new_regular_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsSpent>(v2);
        (v0, v1)
    }

    public(friend) fun spend_purchased_credits_only(arg0: &mut Account, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        assert!(arg0.purchased_credits >= arg1, 7);
        arg0.purchased_credits = arg0.purchased_credits - arg1;
        arg0.total_spent = arg0.total_spent + arg1;
        let v0 = CreditsSpent{
            account_id          : 0x2::object::id<Account>(arg0),
            amount              : arg1,
            bonus_used          : 0,
            regular_used        : arg1,
            purpose             : arg2,
            new_bonus_balance   : arg0.bonus_credits,
            new_regular_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsSpent>(v0);
    }

    public fun sponsor_vault_id(arg0: &Account) : 0x1::option::Option<0x2::object::ID> {
        arg0.sponsor_vault_id
    }

    public fun subscription_id(arg0: &Account) : 0x1::option::Option<0x2::object::ID> {
        arg0.subscription_id
    }

    public fun transfer_account_ownership(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg0, arg3);
        let v0 = 0x2::object::id<Account>(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::vec_set::into_keys<address>(arg1.authorized_addresses);
        0x1::vector::reverse<address>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            let v4 = AddressRevoked{
                account_id      : v0,
                revoked_address : 0x1::vector::pop_back<address>(&mut v2),
                revoked_by      : v1,
            };
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AddressRevoked>(v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(v2);
        arg1.owner_address = arg2;
        arg1.authorized_addresses = 0x2::vec_set::singleton<address>(arg2);
        let v5 = AddressAuthorized{
            account_id    : v0,
            new_address   : arg2,
            authorized_by : v1,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AddressAuthorized>(v5);
    }

    public(friend) fun uid_mut(arg0: &mut Account) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_challenge_stats(arg0: &mut Account, arg1: bool, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        if (arg1) {
            arg0.challenges_won = arg0.challenges_won + 1;
            arg0.total_won = arg0.total_won + arg2;
        } else {
            arg0.challenges_lost = arg0.challenges_lost + 1;
        };
        let v0 = ChallengeStatsUpdated{
            account_id         : 0x2::object::id<Account>(arg0),
            challenges_entered : arg0.challenges_entered,
            challenges_won     : arg0.challenges_won,
            challenges_lost    : arg0.challenges_lost,
            total_won          : arg0.total_won,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ChallengeStatsUpdated>(v0);
    }

    public fun update_game_mmr(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &0x2::clock::Clock, arg2: &mut Account, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg5);
        update_game_mmr_(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_game_mmr_(arg0: &0x2::clock::Clock, arg1: &mut Account, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Account>(arg1);
        let v1 = get_or_create_game_stats(arg1, arg2, arg4);
        v1.mmr = arg3;
        v1.last_updated = 0x2::clock::timestamp_ms(arg0);
        let v2 = GameStatsUpdated{
            account_id       : v0,
            game_type        : arg2,
            mmr              : v1.mmr,
            games_played     : v1.games_played,
            challenges_won   : v1.challenges_won,
            challenges_lost  : v1.challenges_lost,
            tournaments_won  : v1.tournaments_won,
            tournaments_left : v1.tournaments_left,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameStatsUpdated>(v2);
    }

    public(friend) fun update_redemption_state(arg0: &mut Account, arg1: u64, arg2: u64) {
        arg0.last_redemption_at = arg1;
        arg0.redemption_cooldown_until = arg2;
    }

    public fun update_scores(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg5);
        let v0 = 0x2::object::id<Account>(arg1);
        ensure_admin_data_exists(arg1, arg5);
        let v1 = if (arg2 > 10000) {
            10000
        } else {
            arg2
        };
        let v2 = if (arg3 > 10000) {
            10000
        } else {
            arg3
        };
        let v3 = AdminDataKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v3);
        v4.trust_score = v1;
        v4.risk_score = v2;
        v4.last_reviewed = 0x2::clock::timestamp_ms(arg4);
        let v5 = AdminDataUpdated{
            account_id  : v0,
            is_flagged  : v4.is_flagged,
            is_banned   : v4.is_banned,
            is_trusted  : v4.is_trusted,
            trust_score : v4.trust_score,
            risk_score  : v4.risk_score,
            updated_by  : 0x2::tx_context::sender(arg5),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<AdminDataUpdated>(v5);
    }

    public(friend) fun update_tournament_stats(arg0: &mut Account, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        if (arg1 > 0 && arg1 <= arg2) {
            arg0.tournaments_won = arg0.tournaments_won + 1;
            arg0.total_won = arg0.total_won + arg3;
            if (arg1 == 1) {
                arg0.tournaments_first_place = arg0.tournaments_first_place + 1;
            };
        };
        let v0 = TournamentStatsUpdated{
            account_id              : 0x2::object::id<Account>(arg0),
            tournaments_entered     : arg0.tournaments_entered,
            tournaments_won         : arg0.tournaments_won,
            tournaments_first_place : arg0.tournaments_first_place,
            tournaments_left        : arg0.tournaments_left,
            total_won               : arg0.total_won,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<TournamentStatsUpdated>(v0);
    }

    public fun update_universal_mmr(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg1: &mut Account, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg0, arg3);
        ensure_admin_data_exists(arg1, arg3);
        let v0 = AdminDataKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AdminDataKey, AdminData>(&mut arg1.id, v0).universal_mmr = arg2;
    }

    fun validate_handle(arg0: &0x1::string::String) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 >= 3, 9);
        assert!(v0 <= 20, 10);
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0x1::vector::length<u8>(v1);
        assert!(*0x1::vector::borrow<u8>(v1, 0) != 45, 12);
        assert!(*0x1::vector::borrow<u8>(v1, v2 - 1) != 45, 13);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(v1, v3);
            let v5 = v4 >= 97 && v4 <= 122;
            let v6 = v4 >= 48 && v4 <= 57;
            let v7 = if (v5) {
                true
            } else if (v6) {
                true
            } else {
                v4 == 45
            };
            assert!(v7, 11);
            v3 = v3 + 1;
        };
        let v8 = 0x1::string::utf8(b"zenko");
        assert!(arg0 != &v8, 14);
        let v9 = 0x1::string::utf8(b"admin");
        assert!(arg0 != &v9, 14);
        let v10 = 0x1::string::utf8(b"sui");
        assert!(arg0 != &v10, 14);
        let v11 = 0x1::string::utf8(b"test");
        assert!(arg0 != &v11, 14);
        let v12 = 0x1::string::utf8(b"mod");
        assert!(arg0 != &v12, 14);
        let v13 = 0x1::string::utf8(b"moderator");
        assert!(arg0 != &v13, 14);
        let v14 = 0x1::string::utf8(b"support");
        assert!(arg0 != &v14, 14);
        let v15 = 0x1::string::utf8(b"official");
        assert!(arg0 != &v15, 14);
    }

    public fun verify_auth(arg0: &Account, arg1: &AccountAuth) {
        assert!(arg1.account_id == 0x2::object::id<Account>(arg0), 1);
    }

    public(friend) fun withdraw_purchased_credits(arg0: &mut Account, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 8);
        assert!(arg0.purchased_credits >= arg1, 7);
        arg0.purchased_credits = arg0.purchased_credits - arg1;
        let v0 = CreditsWithdrawn{
            account_id  : 0x2::object::id<Account>(arg0),
            amount      : arg1,
            new_balance : arg0.purchased_credits,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<CreditsWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

