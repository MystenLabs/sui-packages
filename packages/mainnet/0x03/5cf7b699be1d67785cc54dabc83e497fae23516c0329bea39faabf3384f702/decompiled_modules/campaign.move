module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign {
    struct PayoutPolicy has copy, drop, store {
        platform_bps: u16,
        platform_address: address,
        recipient_address: address,
    }

    struct Campaign has key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        name: 0x1::string::String,
        short_description: 0x1::string::String,
        subdomain_name: 0x1::string::String,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        funding_goal_usd_micro: u64,
        payout_policy: PayoutPolicy,
        stats_id: 0x2::object::ID,
        start_date: u64,
        end_date: u64,
        created_at_ms: u64,
        is_verified: bool,
        is_active: bool,
        is_deleted: bool,
        parameters_locked: bool,
        deleted_at_ms: 0x1::option::Option<u64>,
        next_update_seq: u64,
    }

    struct CampaignUpdate has store, key {
        id: 0x2::object::UID,
        parent_id: 0x2::object::ID,
        sequence: u64,
        author: address,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at_ms: u64,
    }

    struct UpdateKey has copy, drop, store {
        sequence: u64,
    }

    struct CampaignOwnerCap has key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
    }

    struct CampaignUpdateAdded has copy, drop {
        campaign_id: 0x2::object::ID,
        update_id: 0x2::object::ID,
        sequence: u64,
        author: address,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at_ms: u64,
    }

    struct CampaignBasicsUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
        editor: address,
        timestamp_ms: u64,
        name_updated: bool,
        description_updated: bool,
    }

    struct CampaignMetadataUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
        editor: address,
        timestamp_ms: u64,
        keys_updated: vector<0x1::string::String>,
    }

    struct CampaignStatusChanged has copy, drop {
        campaign_id: 0x2::object::ID,
        editor: address,
        timestamp_ms: u64,
        new_status: bool,
    }

    struct CampaignUnverified has copy, drop {
        campaign_id: 0x2::object::ID,
        unverifier: address,
    }

    struct CampaignParametersLocked has copy, drop {
        campaign_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: u64, arg7: PayoutPolicy, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (Campaign, CampaignOwnerCap) {
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg8 < arg9, 5);
        assert!(arg8 >= v0, 6);
        assert_valid_payout_policy(&arg7);
        assert_valid_metadata(&arg5);
        let v1 = Campaign{
            id                     : 0x2::object::new(arg11),
            admin_id               : arg1,
            name                   : arg2,
            short_description      : arg3,
            subdomain_name         : arg4,
            metadata               : arg5,
            funding_goal_usd_micro : arg6,
            payout_policy          : arg7,
            stats_id               : 0x2::object::id_from_address(@0x0),
            start_date             : arg8,
            end_date               : arg9,
            created_at_ms          : v0,
            is_verified            : false,
            is_active              : true,
            is_deleted             : false,
            parameters_locked      : false,
            deleted_at_ms          : 0x1::option::none<u64>(),
            next_update_seq        : 0,
        };
        let v2 = CampaignOwnerCap{
            id          : 0x2::object::new(arg11),
            campaign_id : 0x2::object::id<Campaign>(&v1),
        };
        let v3 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut v1.id, v3, true);
        (v1, v2)
    }

    entry fun add_update(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        let v0 = arg0.next_update_seq;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v3)) {
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&v3, v6);
            0x1::vector::push_back<0x1::string::String>(&mut v4, *v7);
            0x1::vector::push_back<0x1::string::String>(&mut v5, *v8);
            v6 = v6 + 1;
        };
        let v9 = CampaignUpdate{
            id            : 0x2::object::new(arg5),
            parent_id     : 0x2::object::id<Campaign>(arg0),
            sequence      : v0,
            author        : v2,
            metadata      : v3,
            created_at_ms : v1,
        };
        let v10 = 0x2::object::id<CampaignUpdate>(&v9);
        let v11 = UpdateKey{sequence: v0};
        0x2::dynamic_field::add<UpdateKey, 0x2::object::ID>(&mut arg0.id, v11, v10);
        arg0.next_update_seq = v0 + 1;
        let v12 = CampaignUpdateAdded{
            campaign_id   : 0x2::object::id<Campaign>(arg0),
            update_id     : v10,
            sequence      : v0,
            author        : v2,
            metadata      : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(v4, v5),
            created_at_ms : v1,
        };
        0x2::event::emit<CampaignUpdateAdded>(v12);
        0x2::transfer::freeze_object<CampaignUpdate>(v9);
    }

    public fun admin_id(arg0: &Campaign) : 0x2::object::ID {
        arg0.admin_id
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &Campaign) {
        assert!(is_app_authorized<T0>(arg0), 1);
    }

    public fun assert_not_deleted(arg0: &Campaign) {
        assert!(!arg0.is_deleted, 11);
    }

    public fun assert_owner(arg0: &Campaign, arg1: &CampaignOwnerCap) {
        assert!(arg1.campaign_id == 0x2::object::id<Campaign>(arg0), 1);
    }

    public fun assert_parameters_unlocked(arg0: &Campaign) {
        assert!(!arg0.parameters_locked, 15);
    }

    fun assert_valid_metadata(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        let v0 = 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(arg0);
        assert!(v0 <= 100, 20);
        let v1 = 0;
        while (v1 < v0) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(arg0, v1);
            let v4 = 0x1::string::length(v2);
            let v5 = 0x1::string::length(v3);
            assert!(v4 > 0, 16);
            assert!(v5 > 0, 17);
            assert!(v4 <= 64, 18);
            assert!(v5 <= 2048, 19);
            v1 = v1 + 1;
        };
    }

    fun assert_valid_metadata_entry(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        let v0 = 0x1::string::length(arg1);
        let v1 = 0x1::string::length(arg2);
        assert!(v0 > 0, 16);
        assert!(v1 > 0, 17);
        assert!(v0 <= 64, 18);
        assert!(v1 <= 2048, 19);
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, arg1)) {
            assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(arg0) < 100, 20);
        };
    }

    fun assert_valid_payout_policy(arg0: &PayoutPolicy) {
        assert_valid_payout_policy_fields(arg0.platform_bps, arg0.platform_address, arg0.recipient_address);
    }

    fun assert_valid_payout_policy_fields(arg0: u16, arg1: address, arg2: address) {
        assert!(arg0 <= 10000, 12);
        assert!(arg1 != @0x0, 13);
        assert!(arg2 != @0x0, 13);
    }

    public fun authorize_app<T0: drop>(arg0: &mut Campaign, arg1: &CampaignOwnerCap) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg0.id, v0, true);
    }

    public fun campaign_id(arg0: &CampaignOwnerCap) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun created_at_ms(arg0: &Campaign) : u64 {
        arg0.created_at_ms
    }

    public fun deauthorize_app<T0: drop>(arg0: &mut Campaign, arg1: &CampaignOwnerCap) : bool {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg0.id, v0)
    }

    public(friend) fun delete_owner_cap(arg0: CampaignOwnerCap) {
        let CampaignOwnerCap {
            id          : v0,
            campaign_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun deleted_at_ms(arg0: &Campaign) : 0x1::option::Option<u64> {
        arg0.deleted_at_ms
    }

    public fun e_campaign_deleted() : u64 {
        11
    }

    public fun e_empty_key() : u64 {
        16
    }

    public fun e_empty_value() : u64 {
        17
    }

    public fun e_invalid_bps() : u64 {
        12
    }

    public fun e_key_too_long() : u64 {
        18
    }

    public fun e_parameters_locked() : u64 {
        15
    }

    public fun e_recipient_address_invalid() : u64 {
        9
    }

    public fun e_start_date_in_past() : u64 {
        6
    }

    public fun e_too_many_metadata_entries() : u64 {
        20
    }

    public fun e_value_too_long() : u64 {
        19
    }

    public fun e_zero_address() : u64 {
        13
    }

    public(friend) fun emit_campaign_unverified(arg0: &Campaign, arg1: address) {
        let v0 = CampaignUnverified{
            campaign_id : 0x2::object::id<Campaign>(arg0),
            unverifier  : arg1,
        };
        0x2::event::emit<CampaignUnverified>(v0);
    }

    public fun end_date(arg0: &Campaign) : u64 {
        arg0.end_date
    }

    public fun funding_goal_usd_micro(arg0: &Campaign) : u64 {
        arg0.funding_goal_usd_micro
    }

    public fun get_update_id(arg0: &Campaign, arg1: u64) : 0x2::object::ID {
        let v0 = UpdateKey{sequence: arg1};
        *0x2::dynamic_field::borrow<UpdateKey, 0x2::object::ID>(&arg0.id, v0)
    }

    public fun has_update(arg0: &Campaign, arg1: u64) : bool {
        let v0 = UpdateKey{sequence: arg1};
        0x2::dynamic_field::exists_<UpdateKey>(&arg0.id, v0)
    }

    public fun is_active(arg0: &Campaign) : bool {
        arg0.is_active
    }

    public fun is_app_authorized<T0: drop>(arg0: &Campaign) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0)
    }

    public fun is_deleted(arg0: &Campaign) : bool {
        arg0.is_deleted
    }

    public fun is_verified(arg0: &Campaign) : bool {
        arg0.is_verified
    }

    public(friend) fun lock_parameters_if_unlocked(arg0: &mut Campaign, arg1: &0x2::clock::Clock) : bool {
        if (arg0.parameters_locked) {
            return false
        };
        arg0.parameters_locked = true;
        let v0 = CampaignParametersLocked{
            campaign_id  : 0x2::object::id<Campaign>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CampaignParametersLocked>(v0);
        true
    }

    public(friend) fun mark_deleted(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        arg0.is_active = false;
        arg0.is_verified = false;
        arg0.is_deleted = true;
        arg0.deleted_at_ms = 0x1::option::some<u64>(arg2);
    }

    public fun metadata(arg0: &Campaign) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.metadata
    }

    public fun new_payout_policy(arg0: u16, arg1: address, arg2: address) : PayoutPolicy {
        assert_valid_payout_policy_fields(arg0, arg1, arg2);
        PayoutPolicy{
            platform_bps      : arg0,
            platform_address  : arg1,
            recipient_address : arg2,
        }
    }

    public fun parameters_locked(arg0: &Campaign) : bool {
        arg0.parameters_locked
    }

    public fun payout_platform_address(arg0: &Campaign) : address {
        arg0.payout_policy.platform_address
    }

    public fun payout_platform_bps(arg0: &Campaign) : u16 {
        arg0.payout_policy.platform_bps
    }

    public fun payout_policy(arg0: &Campaign) : &PayoutPolicy {
        &arg0.payout_policy
    }

    public fun payout_policy_platform_address(arg0: &PayoutPolicy) : address {
        arg0.platform_address
    }

    public fun payout_policy_platform_bps(arg0: &PayoutPolicy) : u16 {
        arg0.platform_bps
    }

    public fun payout_policy_recipient_address(arg0: &PayoutPolicy) : address {
        arg0.recipient_address
    }

    public fun payout_recipient_address(arg0: &Campaign) : address {
        arg0.payout_policy.recipient_address
    }

    public fun set_is_active(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: bool) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        arg0.is_active = arg2;
    }

    public(friend) fun set_stats_id(arg0: &mut Campaign, arg1: 0x2::object::ID) {
        assert!(0x2::object::id_to_address(&arg0.stats_id) == @0x0, 14);
        arg0.stats_id = arg1;
    }

    public fun set_verified<T0: drop>(arg0: &mut Campaign, arg1: &T0, arg2: bool) {
        assert_app_is_authorized<T0>(arg0);
        assert_not_deleted(arg0);
        arg0.is_verified = arg2;
    }

    public(friend) fun share(arg0: Campaign) {
        0x2::transfer::share_object<Campaign>(arg0);
    }

    public fun start_date(arg0: &Campaign) : u64 {
        arg0.start_date
    }

    public fun stats_id(arg0: &Campaign) : 0x2::object::ID {
        arg0.stats_id
    }

    public fun subdomain_name(arg0: &Campaign) : 0x1::string::String {
        arg0.subdomain_name
    }

    public(friend) fun transfer_owner_cap(arg0: CampaignOwnerCap, arg1: address) {
        0x2::transfer::transfer<CampaignOwnerCap>(arg0, arg1);
    }

    public fun try_get_update_id(arg0: &Campaign, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        if (has_update(arg0, arg1)) {
            let v1 = UpdateKey{sequence: arg1};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<UpdateKey, 0x2::object::ID>(&arg0.id, v1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun unpack_parameters_locked_event(arg0: &CampaignParametersLocked) : (0x2::object::ID, u64) {
        (arg0.campaign_id, arg0.timestamp_ms)
    }

    entry fun update_active_status(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        if (arg0.is_active != arg2) {
            arg0.is_active = arg2;
            let v0 = CampaignStatusChanged{
                campaign_id  : 0x2::object::id<Campaign>(arg0),
                editor       : 0x2::tx_context::sender(arg4),
                timestamp_ms : 0x2::clock::timestamp_ms(arg3),
                new_status   : arg2,
            };
            0x2::event::emit<CampaignStatusChanged>(v0);
        };
    }

    public fun update_author(arg0: &CampaignUpdate) : address {
        arg0.author
    }

    entry fun update_campaign_basics(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        let v0 = arg0.is_verified;
        let v1 = false;
        let v2 = false;
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v3 = 0x1::option::destroy_some<0x1::string::String>(arg2);
            if (arg0.name != v3) {
                arg0.name = v3;
                v1 = true;
            };
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            let v4 = 0x1::option::destroy_some<0x1::string::String>(arg3);
            if (arg0.short_description != v4) {
                arg0.short_description = v4;
                v2 = true;
            };
        };
        if (v1 || v2) {
            if (v0) {
                arg0.is_verified = false;
            };
        };
        let v5 = CampaignBasicsUpdated{
            campaign_id         : 0x2::object::id<Campaign>(arg0),
            editor              : 0x2::tx_context::sender(arg5),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg4),
            name_updated        : v1,
            description_updated : v2,
        };
        0x2::event::emit<CampaignBasicsUpdated>(v5);
        if (v0 && !arg0.is_verified) {
            emit_campaign_unverified(arg0, 0x2::tx_context::sender(arg5));
        };
    }

    entry fun update_campaign_metadata(arg0: &mut Campaign, arg1: &CampaignOwnerCap, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_not_deleted(arg0);
        let v0 = arg0.is_verified;
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg3, v1);
            assert_valid_metadata_entry(&arg0.metadata, &v3, &v4);
            assert!(v3 != 0x1::string::utf8(b"funding_goal"), 8);
            assert!(v3 != 0x1::string::utf8(b"recipient_address"), 10);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &v3)) {
                let v5 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &v3);
                if (*v5 != v4) {
                    *v5 = v4;
                    v2 = true;
                };
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, v3, v4);
                v2 = true;
            };
            v1 = v1 + 1;
        };
        if (v2) {
            if (v0) {
                arg0.is_verified = false;
            };
        };
        let v6 = CampaignMetadataUpdated{
            campaign_id  : 0x2::object::id<Campaign>(arg0),
            editor       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            keys_updated : arg2,
        };
        0x2::event::emit<CampaignMetadataUpdated>(v6);
        if (v0 && !arg0.is_verified) {
            emit_campaign_unverified(arg0, 0x2::tx_context::sender(arg5));
        };
    }

    public fun update_count(arg0: &Campaign) : u64 {
        arg0.next_update_seq
    }

    public fun update_created_at_ms(arg0: &CampaignUpdate) : u64 {
        arg0.created_at_ms
    }

    public fun update_metadata(arg0: &CampaignUpdate) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.metadata
    }

    public fun update_parent_id(arg0: &CampaignUpdate) : 0x2::object::ID {
        arg0.parent_id
    }

    public fun update_sequence(arg0: &CampaignUpdate) : u64 {
        arg0.sequence
    }

    // decompiled from Move bytecode v6
}

