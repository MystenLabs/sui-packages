module 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        campaign_id: vector<u8>,
        name: vector<u8>,
        campaign_slug: vector<u8>,
        total_supply: u64,
        minted_count: u64,
        campaign_status: 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::CampaignStatus,
        is_paused: bool,
        nft_details: 0x2::table::Table<u64, NFTDetail>,
        shuffle_vector: vector<u64>,
        prizes: vector<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>,
        is_shuffled: bool,
        claimed_addresses: 0x2::table::Table<address, bool>,
        nonce_counter: 0x2::table::Table<address, u64>,
        creator: address,
        admins: 0x2::vec_set::VecSet<0x2::object::ID>,
        kiosk_settings: 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::KioskSettings,
        active_commitment_id: 0x1::option::Option<0x2::object::ID>,
        distribution_completed: bool,
        distribution_start_index: u64,
        distribution_offset: 0x1::option::Option<u64>,
    }

    struct NFTDetail has store {
        object_id: 0x1::option::Option<0x2::object::ID>,
        original_claim_address: address,
        prize: 0x1::option::Option<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>,
        claimed: bool,
    }

    struct CampaignCreated has copy, drop {
        registry_id: 0x2::object::ID,
        campaign_id: vector<u8>,
        name: vector<u8>,
        total_supply: u64,
    }

    struct PrizeRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        tier_level: u64,
        prize_type: vector<u8>,
        quantity: u64,
    }

    struct CampaignStatusUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        new_status: u8,
    }

    struct AdminAdded has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct AdminRemoved has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    public entry fun add_admin(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        assert!(!arg1.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.admins, arg2);
        let v0 = AdminAdded{
            registry_id  : 0x2::object::uid_to_inner(&arg1.id),
            admin_cap_id : arg2,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public(friend) fun assign_prize_and_decrement(arg0: &mut Registry, arg1: u64, arg2: u64) : bool {
        if (arg2 >= 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg0.prizes)) {
            return false
        };
        let v0 = 0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg0.prizes, arg2);
        if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_remaining(v0) > 0) {
            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::decrement_prize_remaining(0x1::vector::borrow_mut<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&mut arg0.prizes, arg2));
            set_nft_prize(arg0, arg1, *v0);
            return true
        };
        false
    }

    public fun check_admin(arg0: &Registry, arg1: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap) {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.admins, &v0), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::not_authorized());
    }

    public(friend) fun clear_active_commitment_id(arg0: &mut Registry) {
        arg0.active_commitment_id = 0x1::option::none<0x2::object::ID>();
    }

    public entry fun create_campaign_registry(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg0));
        let v2 = Registry{
            id                       : v0,
            campaign_id              : arg1,
            name                     : arg2,
            campaign_slug            : arg3,
            total_supply             : arg4,
            minted_count             : 0,
            campaign_status          : 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_draft(),
            is_paused                : false,
            nft_details              : 0x2::table::new<u64, NFTDetail>(arg5),
            shuffle_vector           : 0x1::vector::empty<u64>(),
            prizes                   : 0x1::vector::empty<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(),
            is_shuffled              : false,
            claimed_addresses        : 0x2::table::new<address, bool>(arg5),
            nonce_counter            : 0x2::table::new<address, u64>(arg5),
            creator                  : 0x2::tx_context::sender(arg5),
            admins                   : v1,
            kiosk_settings           : 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::default_kiosk_settings(),
            active_commitment_id     : 0x1::option::none<0x2::object::ID>(),
            distribution_completed   : false,
            distribution_start_index : 0,
            distribution_offset      : 0x1::option::none<u64>(),
        };
        let v3 = CampaignCreated{
            registry_id  : 0x2::object::uid_to_inner(&v0),
            campaign_id  : arg1,
            name         : arg2,
            total_supply : arg4,
        };
        0x2::event::emit<CampaignCreated>(v3);
        0x2::transfer::share_object<Registry>(v2);
    }

    public(friend) fun create_mint_record(arg0: &mut Registry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTDetail{
            object_id              : 0x1::option::none<0x2::object::ID>(),
            original_claim_address : arg2,
            prize                  : 0x1::option::none<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(),
            claimed                : false,
        };
        0x2::table::add<u64, NFTDetail>(&mut arg0.nft_details, arg1, v0);
        0x1::vector::push_back<u64>(&mut arg0.shuffle_vector, arg1);
        0x2::table::add<address, bool>(&mut arg0.claimed_addresses, arg2, true);
        arg0.minted_count = arg0.minted_count + 1;
    }

    public fun get_active_commitment_id(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        arg0.active_commitment_id
    }

    public fun get_all_prizes(arg0: &Registry) : vector<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize> {
        arg0.prizes
    }

    public fun get_campaign_status(arg0: &Registry) : 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::CampaignStatus {
        arg0.campaign_status
    }

    public fun get_distribution_offset(arg0: &Registry) : 0x1::option::Option<u64> {
        arg0.distribution_offset
    }

    public fun get_distribution_start_index(arg0: &Registry) : u64 {
        arg0.distribution_start_index
    }

    public fun get_nft_detail(arg0: &Registry, arg1: u64) : (0x1::option::Option<0x2::object::ID>, address, 0x1::option::Option<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>, bool) {
        let v0 = 0x2::table::borrow<u64, NFTDetail>(&arg0.nft_details, arg1);
        (v0.object_id, v0.original_claim_address, v0.prize, v0.claimed)
    }

    public fun get_prizes(arg0: &Registry) : &vector<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize> {
        &arg0.prizes
    }

    public(friend) fun get_prizes_mut(arg0: &mut Registry) : &mut vector<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize> {
        &mut arg0.prizes
    }

    public fun get_user_nonce(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.nonce_counter, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.nonce_counter, arg1)
        } else {
            0
        }
    }

    public fun has_claimed_address(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed_addresses, arg1)
    }

    public(friend) fun increment_user_nonce(arg0: &mut Registry, arg1: address) {
        if (0x2::table::contains<address, u64>(&arg0.nonce_counter, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonce_counter, arg1) = get_user_nonce(arg0, arg1) + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonce_counter, arg1, 1);
        };
    }

    public fun is_distribution_completed(arg0: &Registry) : bool {
        arg0.distribution_completed
    }

    public fun is_in_claim_phase(arg0: &Registry) : bool {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_claim();
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&arg0.campaign_status, &v0)
    }

    public fun is_in_finished_phase(arg0: &Registry) : bool {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_finished();
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&arg0.campaign_status, &v0)
    }

    public fun is_in_reveal_phase(arg0: &Registry) : bool {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_reveal();
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&arg0.campaign_status, &v0)
    }

    public fun is_in_shuffled_phase(arg0: &Registry) : bool {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_shuffled();
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&arg0.campaign_status, &v0)
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.is_paused
    }

    public fun is_shuffled(arg0: &Registry) : bool {
        arg0.is_shuffled
    }

    public fun kiosk_settings(arg0: &Registry) : 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::KioskSettings {
        arg0.kiosk_settings
    }

    public(friend) fun link_nft_object(arg0: &mut Registry, arg1: u64, arg2: 0x2::object::ID) {
        0x2::table::borrow_mut<u64, NFTDetail>(&mut arg0.nft_details, arg1).object_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public(friend) fun mark_distribution_completed(arg0: &mut Registry) {
        arg0.distribution_completed = true;
    }

    public(friend) fun mark_nft_claimed(arg0: &mut Registry, arg1: u64) {
        0x2::table::borrow_mut<u64, NFTDetail>(&mut arg0.nft_details, arg1).claimed = true;
    }

    public fun minted_count(arg0: &Registry) : u64 {
        arg0.minted_count
    }

    public fun pause_campaign(arg0: &mut Registry, arg1: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap) {
        check_admin(arg0, arg1);
        assert!(!arg0.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_finished();
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&arg0.campaign_status, &v0), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
        arg0.is_paused = true;
    }

    public entry fun register_prize(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        assert!(!arg1.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        assert!(!arg1.is_shuffled, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::already_shuffled());
        assert!(arg2 > 0, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_tier());
        let v0 = 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg1.prizes);
        if (v0 == 0) {
            assert!(arg2 == 1, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::non_sequential_tier());
        } else {
            let v1 = 0;
            let v2 = v1;
            let v3 = 0;
            while (v3 < v0) {
                let v4 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_tier_level(0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg1.prizes, v3));
                if (v4 > v1) {
                    v2 = v4;
                };
                v3 = v3 + 1;
            };
            assert!(arg2 == v2 + 1, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::non_sequential_tier());
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg1.prizes)) {
            v5 = v5 + 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_quantity(0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&arg1.prizes, v6));
            v6 = v6 + 1;
        };
        assert!(v5 + arg3 <= arg1.total_supply, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prizes_exceed_total_supply());
        assert!(0x1::vector::length<u8>(&arg4) > 0, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_prize_quantity());
        assert!(0x1::vector::length<u8>(&arg5) > 0, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_prize_quantity());
        0x1::vector::push_back<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&mut arg1.prizes, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::create_prize(arg2, arg3, arg4, arg5, arg6, arg7, arg8));
        let v7 = PrizeRegistered{
            registry_id : 0x2::object::uid_to_inner(&arg1.id),
            tier_level  : arg2,
            prize_type  : b"",
            quantity    : arg3,
        };
        0x2::event::emit<PrizeRegistered>(v7);
    }

    public fun registry_details(arg0: &Registry) : (0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, u64, u64, bool) {
        (0x2::object::uid_to_inner(&arg0.id), arg0.campaign_id, arg0.name, arg0.campaign_slug, arg0.total_supply, arg0.minted_count, arg0.is_shuffled)
    }

    public fun registry_extended_details(arg0: &Registry) : (0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, u64, u64, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::CampaignStatus, bool) {
        (0x2::object::uid_to_inner(&arg0.id), arg0.campaign_id, arg0.name, arg0.campaign_slug, arg0.total_supply, arg0.minted_count, arg0.campaign_status, arg0.is_shuffled)
    }

    public entry fun remove_admin(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut Registry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        assert!(!arg1.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        assert!(arg2 != 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::get_admin_cap_id(arg0), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::not_authorized());
        if (0x2::vec_set::contains<0x2::object::ID>(&arg1.admins, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg1.admins, &arg2);
            let v0 = AdminRemoved{
                registry_id  : 0x2::object::uid_to_inner(&arg1.id),
                admin_cap_id : arg2,
            };
            0x2::event::emit<AdminRemoved>(v0);
        };
    }

    public fun resume_campaign(arg0: &mut Registry, arg1: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap) {
        check_admin(arg0, arg1);
        assert!(arg0.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
        arg0.is_paused = false;
    }

    public(friend) fun set_active_commitment_id(arg0: &mut Registry, arg1: 0x2::object::ID) {
        arg0.active_commitment_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public(friend) fun set_distribution_offset(arg0: &mut Registry, arg1: u64) {
        arg0.distribution_offset = 0x1::option::some<u64>(arg1);
    }

    public(friend) fun set_nft_prize(arg0: &mut Registry, arg1: u64, arg2: 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize) {
        0x2::table::borrow_mut<u64, NFTDetail>(&mut arg0.nft_details, arg1).prize = 0x1::option::some<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(arg2);
    }

    public(friend) fun set_shuffled(arg0: &mut Registry) {
        arg0.is_shuffled = true;
    }

    public fun total_supply(arg0: &Registry) : u64 {
        arg0.total_supply
    }

    public entry fun update_campaign_status(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut Registry, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        assert!(!arg1.is_paused, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::create_campaign_status(arg2);
        validate_status_transition(arg1, &v0);
        arg1.campaign_status = v0;
        let v1 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_shuffled();
        if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(&v0, &v1) && !arg1.is_shuffled) {
            arg1.is_shuffled = true;
        };
        let v2 = CampaignStatusUpdated{
            registry_id : 0x2::object::uid_to_inner(&arg1.id),
            new_status  : arg2,
        };
        0x2::event::emit<CampaignStatusUpdated>(v2);
    }

    public(friend) fun update_campaign_status_internal(arg0: &mut Registry, arg1: 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::CampaignStatus) {
        arg0.campaign_status = arg1;
        let v0 = CampaignStatusUpdated{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            new_status  : 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::get_status_value(&arg1),
        };
        0x2::event::emit<CampaignStatusUpdated>(v0);
    }

    public(friend) fun update_distribution_start_index(arg0: &mut Registry, arg1: u64) {
        arg0.distribution_start_index = arg1;
    }

    public(friend) fun update_nft_detail_claim_address_record(arg0: &mut Registry, arg1: u64, arg2: address) {
        0x2::table::borrow_mut<u64, NFTDetail>(&mut arg0.nft_details, arg1).original_claim_address = arg2;
    }

    fun validate_status_transition(arg0: &Registry, arg1: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::CampaignStatus) {
        let v0 = &arg0.campaign_status;
        let v1 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_draft();
        if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(v0, &v1)) {
            let v2 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_claim();
            assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(arg1, &v2), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
        } else {
            let v3 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_claim();
            if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(v0, &v3)) {
                let v4 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_shuffled();
                assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(arg1, &v4), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
            } else {
                let v5 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_shuffled();
                if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(v0, &v5)) {
                    let v6 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_reveal();
                    assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(arg1, &v6), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
                } else {
                    let v7 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_reveal();
                    if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(v0, &v7)) {
                        let v8 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_finished();
                        assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(arg1, &v8), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition());
                    } else {
                        let v9 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_finished();
                        if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_equals(v0, &v9)) {
                            abort 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status_transition()
                        };
                    };
                };
            };
        };
    }

    // decompiled from Move bytecode v6
}

