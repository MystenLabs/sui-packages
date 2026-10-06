module 0x6f279e417396f0c1a2e003f2508f2da38bed7e1bfd275f2a897ca0edd671929e::claimable_link {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GiftKey has copy, drop, store {
        pubkey: vector<u8>,
    }

    struct ClaimableLinkConfig has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        managers: 0x2::vec_set::VecSet<address>,
        paused: bool,
        controller: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        creator_gifts: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Gift<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        creator_account_id: 0x2::object::ID,
        source_position_id: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        total_spend: u64,
        spend_per_share: u64,
        locked_odds_cents: u64,
        pubkey: vector<u8>,
        share_count: u64,
        claimed_count: u64,
        claimed_addresses: 0x2::vec_set::VecSet<address>,
        base_share_amount: u64,
        extra_share_links: u64,
        total_shares: u64,
        remaining_shares: u64,
        referral_code: 0x1::option::Option<0x1::string::String>,
        created_at_ms: u64,
        expires_at_ms: u64,
    }

    struct ConfigPaused has copy, drop {
        by: address,
    }

    struct ConfigUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct ManagerAdded has copy, drop {
        manager: address,
    }

    struct ManagerRemoved has copy, drop {
        manager: address,
    }

    struct VersionAllowed has copy, drop {
        version: u16,
    }

    struct VersionDisallowed has copy, drop {
        version: u16,
    }

    struct GiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        creator_account_id: 0x2::object::ID,
        source_position_id: u64,
        market_id: vector<u8>,
        selection: 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection,
        pubkey: vector<u8>,
        total_spend: u64,
        spend_per_share: u64,
        locked_odds_cents: u64,
        share_count: u64,
        total_shares: u64,
        base_share_amount: u64,
        extra_share_links: u64,
        referral_code: 0x1::option::Option<0x1::string::String>,
        expires_at_ms: u64,
        event_ts: u64,
    }

    struct ShareClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        claimer: address,
        recipient_account_id: 0x2::object::ID,
        position_id: u64,
        share_amount: u64,
        claimed_count: u64,
        remaining_shares: u64,
        event_ts: u64,
    }

    struct GiftDeleted has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        leftover_shares: u64,
        event_ts: u64,
    }

    public fun add_manager(arg0: &mut ClaimableLinkConfig, arg1: &AdminCap, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg0.managers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
            let v0 = ManagerAdded{manager: arg2};
            0x2::event::emit<ManagerAdded>(v0);
        };
    }

    public fun allow_version(arg0: &mut ClaimableLinkConfig, arg1: &AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
            let v0 = VersionAllowed{version: arg2};
            0x2::event::emit<VersionAllowed>(v0);
        };
    }

    public fun allowed_versions(arg0: &ClaimableLinkConfig) : vector<u16> {
        *0x2::vec_set::keys<u16>(&arg0.versions)
    }

    fun assert_active(arg0: &ClaimableLinkConfig) {
        assert_valid_package_version(arg0);
        if (arg0.paused) {
            abort 13906837606022971404
        };
    }

    fun assert_valid_package_version(arg0: &ClaimableLinkConfig) {
        let v0 = 3;
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            abort 13906837627497545736
        };
    }

    public fun base_share_amount<T0>(arg0: &Gift<T0>) : u64 {
        arg0.base_share_amount
    }

    public fun claim_share<T0>(arg0: &ClaimableLinkConfig, arg1: &mut Gift<T0>, arg2: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg3: &mut 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg4: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg5: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table::ReferralTable, arg6: 0x1::option::Option<0x2::object::ID>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::length<u8>(&arg7) == 64, 13906836420612522004);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        let v2 = b"";
        0x1::vector::append<u8>(&mut v2, b"waterx_prediction_gift/claim");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg1.pubkey, &v2), 13906836450677424150);
        claim_share_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9)
    }

    fun claim_share_internal<T0>(arg0: &ClaimableLinkConfig, arg1: &mut Gift<T0>, arg2: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::global_config::GlobalConfig, arg3: &mut 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg4: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg5: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table::ReferralTable, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_active(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(v1 < arg1.expires_at_ms, 13906836596707229732);
        assert!(arg1.claimed_count < arg1.share_count, 13906836601002328102);
        assert!(!0x2::vec_set::contains<address>(&arg1.claimed_addresses, &v0), 13906836605297426472);
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request(arg8);
        let v3 = if (0x1::option::is_some<0x2::object::ID>(&arg6)) {
            let v4 = *0x1::option::borrow<0x2::object::ID>(&arg6);
            assert!(0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::has_account(arg4, v4), 13906836643952263210);
            v4
        } else {
            resolve_or_create_main_account(arg4, &v2, v0, arg8)
        };
        let v5 = if (arg1.claimed_count < arg1.extra_share_links) {
            arg1.base_share_amount + 1
        } else {
            arg1.base_share_amount
        };
        let v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.controller);
        let v7 = if (arg1.claimed_count + 1 == arg1.share_count) {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::transfer_position<T0>(arg2, arg3, arg4, &v6, arg1.source_position_id, v3, arg7, arg8);
            arg1.source_position_id
        } else {
            0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::split_position<T0>(arg2, arg3, arg4, &v6, arg1.source_position_id, v3, v5, arg7, arg8)
        };
        if (0x1::option::is_some<0x1::string::String>(&arg1.referral_code)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table::use_referral_code(arg5, &v2, *0x1::option::borrow<0x1::string::String>(&arg1.referral_code));
        };
        arg1.claimed_count = arg1.claimed_count + 1;
        arg1.remaining_shares = arg1.remaining_shares - v5;
        0x2::vec_set::insert<address>(&mut arg1.claimed_addresses, v0);
        let v8 = ShareClaimed{
            gift_id              : 0x2::object::uid_to_inner(&arg1.id),
            claimer              : v0,
            recipient_account_id : v3,
            position_id          : v7,
            share_amount         : v5,
            claimed_count        : arg1.claimed_count,
            remaining_shares     : arg1.remaining_shares,
            event_ts             : v1,
        };
        0x2::event::emit<ShareClaimed>(v8);
        v7
    }

    public fun claimed_addresses<T0>(arg0: &Gift<T0>) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.claimed_addresses)
    }

    public fun claimed_count<T0>(arg0: &Gift<T0>) : u64 {
        arg0.claimed_count
    }

    public fun config_id(arg0: &ClaimableLinkConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun controller_address(arg0: &ClaimableLinkConfig) : address {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg0.controller)
    }

    public fun create_gift<T0>(arg0: &mut ClaimableLinkConfig, arg1: &0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::MarketRegistry<T0>, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table::ReferralTable, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg5: 0x2::object::ID, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: 0x1::option::Option<0x1::string::String>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_active(arg0);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 13906835677583048722);
        assert!(arg9 > 0x2::clock::timestamp_ms(arg11), 13906835681878409240);
        assert!(arg8 > 0 && arg8 <= 500, 13906835686173507610);
        if (0x1::option::is_some<0x1::string::String>(&arg10)) {
            assert!(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::referral_table::referral_code_exists(arg3, *0x1::option::borrow<0x1::string::String>(&arg10)), 13906835711944491052);
        };
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_account_id<T0>(arg1, arg6) == arg5, 13906835750598279198);
        assert!(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::status_is_open(0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_status<T0>(arg1, arg6)), 13906835776368214048);
        let v0 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_market_id<T0>(arg1, arg6);
        assert!(!0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::is_market_resolved<T0>(arg1, v0), 13906835797843181602);
        let (v1, v2) = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_filled<T0>(arg1, arg6);
        let v3 = 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::waterx_prediction::position_selection<T0>(arg1, arg6);
        assert!(v1 >= arg8, 13906835832202526748);
        let v4 = v1 / arg8;
        let v5 = v1 % arg8;
        let v6 = v2 / arg8;
        let v7 = v2 * 100 / v1;
        let v8 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg4);
        let v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(&arg0.controller);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::add_delegate(arg2, arg4, arg5, v9, 0x1::string::utf8(b"waterx_gift_controller"), 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::perm_none(), 0x1::option::none<u64>(), arg11);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::set_delegate_protocol_permission<0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::WaterXPrediction>(arg2, arg4, arg5, v9, 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::account_data::perm_transfer_position(), arg11);
        let v10 = GiftKey{pubkey: arg7};
        let v11 = 0x2::derived_object::claim<GiftKey>(&mut arg0.id, v10);
        let v12 = 0x2::object::uid_to_inner(&v11);
        let v13 = 0x2::clock::timestamp_ms(arg11);
        let v14 = Gift<T0>{
            id                 : v11,
            creator            : v8,
            creator_account_id : arg5,
            source_position_id : arg6,
            market_id          : v0,
            selection          : v3,
            total_spend        : v2,
            spend_per_share    : v6,
            locked_odds_cents  : v7,
            pubkey             : arg7,
            share_count        : arg8,
            claimed_count      : 0,
            claimed_addresses  : 0x2::vec_set::empty<address>(),
            base_share_amount  : v4,
            extra_share_links  : v5,
            total_shares       : v1,
            remaining_shares   : v1,
            referral_code      : arg10,
            created_at_ms      : v13,
            expires_at_ms      : arg9,
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_gifts, v8)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.creator_gifts, v8), v12);
        } else {
            let v15 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v12);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.creator_gifts, v8, v15);
        };
        let v16 = GiftCreated{
            gift_id            : v12,
            creator            : v8,
            creator_account_id : arg5,
            source_position_id : arg6,
            market_id          : v0,
            selection          : v3,
            pubkey             : arg7,
            total_spend        : v2,
            spend_per_share    : v6,
            locked_odds_cents  : v7,
            share_count        : arg8,
            total_shares       : v1,
            base_share_amount  : v4,
            extra_share_links  : v5,
            referral_code      : v14.referral_code,
            expires_at_ms      : arg9,
            event_ts           : v13,
        };
        0x2::event::emit<GiftCreated>(v16);
        0x2::transfer::share_object<Gift<T0>>(v14);
        v12
    }

    public fun created_at_ms<T0>(arg0: &Gift<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Gift<T0>) : address {
        arg0.creator
    }

    public fun creator_account_id<T0>(arg0: &Gift<T0>) : 0x2::object::ID {
        arg0.creator_account_id
    }

    public fun creator_gift_count(arg0: &ClaimableLinkConfig, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_gifts, arg1)) {
            0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.creator_gifts, arg1))
        } else {
            0
        }
    }

    public fun creator_gift_ids(arg0: &ClaimableLinkConfig, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_gifts, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.creator_gifts, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun delete_gift<T0>(arg0: &mut ClaimableLinkConfig, arg1: Gift<T0>, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: &0x2::clock::Clock) {
        assert_valid_package_version(arg0);
        assert!(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2) == arg1.creator, 13906837009022386186);
        let Gift {
            id                 : v0,
            creator            : v1,
            creator_account_id : _,
            source_position_id : _,
            market_id          : _,
            selection          : _,
            total_spend        : _,
            spend_per_share    : _,
            locked_odds_cents  : _,
            pubkey             : _,
            share_count        : _,
            claimed_count      : _,
            claimed_addresses  : _,
            base_share_amount  : _,
            extra_share_links  : _,
            total_shares       : _,
            remaining_shares   : v16,
            referral_code      : _,
            created_at_ms      : _,
            expires_at_ms      : _,
        } = arg1;
        let v20 = v0;
        let v21 = 0x2::object::uid_to_inner(&v20);
        0x2::object::delete(v20);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.creator_gifts, v1)) {
            let v22 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.creator_gifts, v1);
            let v23 = 0;
            while (v23 < 0x1::vector::length<0x2::object::ID>(v22)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v22, v23) == v21) {
                    0x1::vector::swap_remove<0x2::object::ID>(v22, v23);
                    break
                };
                v23 = v23 + 1;
            };
        };
        let v24 = GiftDeleted{
            gift_id         : v21,
            creator         : v1,
            leftover_shares : v16,
            event_ts        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GiftDeleted>(v24);
    }

    public fun derive_gift_address(arg0: &ClaimableLinkConfig, arg1: vector<u8>) : address {
        let v0 = GiftKey{pubkey: arg1};
        0x2::derived_object::derive_address<GiftKey>(0x2::object::id<ClaimableLinkConfig>(arg0), v0)
    }

    public fun disallow_version(arg0: &mut ClaimableLinkConfig, arg1: &AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
            let v0 = VersionDisallowed{version: arg2};
            0x2::event::emit<VersionDisallowed>(v0);
        };
    }

    public fun expires_at_ms<T0>(arg0: &Gift<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun extra_share_links<T0>(arg0: &Gift<T0>) : u64 {
        arg0.extra_share_links
    }

    public fun gift_id<T0>(arg0: &Gift<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun has_claimed<T0>(arg0: &Gift<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.claimed_addresses, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimableLinkConfig{
            id            : 0x2::object::new(arg0),
            versions      : 0x2::vec_set::singleton<u16>(3),
            managers      : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            paused        : false,
            controller    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg0),
            creator_gifts : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<ClaimableLinkConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &ClaimableLinkConfig) : bool {
        arg0.paused
    }

    public fun locked_odds_cents<T0>(arg0: &Gift<T0>) : u64 {
        arg0.locked_odds_cents
    }

    public fun manager_addresses(arg0: &ClaimableLinkConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.managers)
    }

    public fun market_id<T0>(arg0: &Gift<T0>) : vector<u8> {
        arg0.market_id
    }

    public fun package_version() : u16 {
        3
    }

    public fun pause(arg0: &mut ClaimableLinkConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            abort 13906835492898930698
        };
        if (arg0.paused) {
            abort 13906835497194160142
        };
        arg0.paused = true;
        let v1 = ConfigPaused{by: v0};
        0x2::event::emit<ConfigPaused>(v1);
    }

    public fun pubkey<T0>(arg0: &Gift<T0>) : vector<u8> {
        arg0.pubkey
    }

    public fun referral_code<T0>(arg0: &Gift<T0>) : 0x1::option::Option<0x1::string::String> {
        arg0.referral_code
    }

    public fun remaining_shares<T0>(arg0: &Gift<T0>) : u64 {
        arg0.remaining_shares
    }

    public fun remove_manager(arg0: &mut ClaimableLinkConfig, arg1: &AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.managers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
            let v0 = ManagerRemoved{manager: arg2};
            0x2::event::emit<ManagerRemoved>(v0);
        };
    }

    fun resolve_or_create_main_account(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::account_ids(arg0, arg2);
        if (0x1::vector::length<0x2::object::ID>(&v0) > 0) {
            *0x1::vector::borrow<0x2::object::ID>(&v0, 0)
        } else {
            0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::create_account(arg0, arg1, 0x1::string::utf8(b"main"), arg3)
        }
    }

    public fun selection<T0>(arg0: &Gift<T0>) : 0xa5cfafe6660a8bf37eedf1a09dba633048da374c30b835668473689668f9ef57::position::Selection {
        arg0.selection
    }

    public fun share_count<T0>(arg0: &Gift<T0>) : u64 {
        arg0.share_count
    }

    public fun source_position_id<T0>(arg0: &Gift<T0>) : u64 {
        arg0.source_position_id
    }

    public fun spend_per_share<T0>(arg0: &Gift<T0>) : u64 {
        arg0.spend_per_share
    }

    public fun total_shares<T0>(arg0: &Gift<T0>) : u64 {
        arg0.total_shares
    }

    public fun total_spend<T0>(arg0: &Gift<T0>) : u64 {
        arg0.total_spend
    }

    public fun unpause(arg0: &mut ClaimableLinkConfig, arg1: &AdminCap) {
        if (!arg0.paused) {
            abort 13906835522964094992
        };
        arg0.paused = false;
        let v0 = ConfigUnpaused{dummy_field: false};
        0x2::event::emit<ConfigUnpaused>(v0);
    }

    // decompiled from Move bytecode v7
}

