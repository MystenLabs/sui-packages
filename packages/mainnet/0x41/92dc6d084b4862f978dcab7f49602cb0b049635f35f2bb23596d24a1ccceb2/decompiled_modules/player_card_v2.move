module 0x4192dc6d084b4862f978dcab7f49602cb0b049635f35f2bb23596d24a1ccceb2::player_card_v2 {
    struct PLAYER_CARD_V2 has drop {
        dummy_field: bool,
    }

    struct CustodyRule has drop {
        dummy_field: bool,
    }

    struct CustodyRuleConfig has drop, store {
        version: u64,
    }

    struct MarketplaceSettlementRule has drop {
        dummy_field: bool,
    }

    struct MarketplaceSettlementConfig has drop, store {
        athlete_bps: u64,
        platform_bps: u64,
        minimum_gross_mist: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        generation: u64,
    }

    struct EntitlementCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        generation: u64,
    }

    struct SeasonUpdateCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        generation: u64,
    }

    struct RoyaltyAdminCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        generation: u64,
    }

    struct PlatformConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        mint_generation: u64,
        entitlement_generation: u64,
        update_generation: u64,
        royalty_generation: u64,
        policy_id: 0x1::option::Option<0x2::object::ID>,
        season_count: u64,
    }

    struct RoyaltyRegistry has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        payout_count: u64,
    }

    struct Payout has drop, store {
        athlete: u64,
        address: address,
        revision: u64,
    }

    struct SeasonEdition has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        athlete_id: u64,
        sport: vector<u8>,
        season_label: vector<u8>,
        starts_at_ms: u64,
        ends_at_ms: u64,
        hard_cap: u64,
        peak_authorized_cap: u64,
        active_distribution_limit: u64,
        issued_count: u64,
        next_serial: u64,
        distribution_enabled: bool,
        finalized: bool,
        live_revision: u64,
        live_snapshot_uri: vector<u8>,
        live_snapshot_hash: vector<u8>,
        nonce_count: u64,
    }

    struct ClaimPermit has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        edition: 0x2::object::ID,
        generation: u64,
        claim_nonce_hash: vector<u8>,
        recipient: address,
        expires_at_ms: u64,
        original_snapshot_revision: u64,
        original_snapshot_uri: vector<u8>,
        original_snapshot_hash: vector<u8>,
    }

    struct PlayerCardV2 has store, key {
        id: 0x2::object::UID,
        season_id: 0x2::object::ID,
        athlete_id: u64,
        sport: vector<u8>,
        season_label: vector<u8>,
        serial_number: u64,
        issued_at_ms: u64,
        original_recipient: address,
        original_snapshot_revision: u64,
        original_snapshot_uri: vector<u8>,
        original_snapshot_hash: vector<u8>,
    }

    struct PlayerCardKioskCap has key {
        id: 0x2::object::UID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        native_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct PolicyGovernanceVault has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<PlayerCardV2>,
    }

    struct SeasonKey has copy, drop, store {
        digest: address,
    }

    struct NonceKey has copy, drop, store {
        digest: address,
    }

    struct NonceRecord has drop, store {
        state: u8,
        expires_at_ms: u64,
    }

    struct MarketplaceListing has key {
        id: 0x2::object::UID,
        card_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        gross_price: u64,
        seller_amount: u64,
        athlete_amount: u64,
        platform_amount: u64,
        athlete_id: u64,
        season_id: 0x2::object::ID,
        serial_number: u64,
        created_at_ms: u64,
    }

    struct PlatformInitialized has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        entitlement_cap_id: 0x2::object::ID,
        season_update_cap_id: 0x2::object::ID,
        royalty_admin_cap_id: 0x2::object::ID,
        policy_vault_id: 0x2::object::ID,
    }

    struct SeasonCreated has copy, drop {
        schema_version: u16,
        season_id: 0x2::object::ID,
        athlete_id: u64,
        starts_at_ms: u64,
        ends_at_ms: u64,
        initial_limit: u64,
        live_revision: u64,
    }

    struct EntitlementChanged has copy, drop {
        schema_version: u16,
        season_id: 0x2::object::ID,
        active: u64,
        peak: u64,
        issued: u64,
        next_serial: u64,
    }

    struct ClaimPermitIssued has copy, drop {
        schema_version: u16,
        permit_id: 0x2::object::ID,
        season_id: 0x2::object::ID,
        claim_nonce_hash: vector<u8>,
        recipient: address,
        expires_at_ms: u64,
        snapshot_revision: u64,
    }

    struct CardIssued has copy, drop {
        schema_version: u16,
        card_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        season_id: 0x2::object::ID,
        athlete_id: u64,
        sport: vector<u8>,
        serial_number: u64,
        recipient: address,
        claim_nonce_hash: vector<u8>,
        original_snapshot_revision: u64,
        issued_at_ms: u64,
    }

    struct SeasonLiveDataUpdated has copy, drop {
        schema_version: u16,
        season_id: 0x2::object::ID,
        revision: u64,
        snapshot_hash: vector<u8>,
    }

    struct SeasonFinalized has copy, drop {
        schema_version: u16,
        season_id: 0x2::object::ID,
        issued: u64,
        peak: u64,
        final_revision: u64,
        finalized_at_ms: u64,
    }

    struct AthletePayoutUpdated has copy, drop {
        schema_version: u16,
        athlete: u64,
        payout: address,
        revision: u64,
    }

    struct OperationalCapRotated has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        cap_kind: vector<u8>,
        generation: u64,
        recipient: address,
    }

    struct TreasuryUpdated has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        previous_treasury: address,
        new_treasury: address,
    }

    struct PolicyGovernanceSealed has copy, drop {
        schema_version: u16,
        policy_id: 0x2::object::ID,
        policy_vault_id: 0x2::object::ID,
    }

    struct CardListed has copy, drop {
        schema_version: u16,
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        season_id: 0x2::object::ID,
        athlete_id: u64,
        serial_number: u64,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        gross_price: u64,
        seller_amount: u64,
        athlete_amount: u64,
        platform_amount: u64,
        created_at_ms: u64,
    }

    struct CardListingCancelled has copy, drop {
        schema_version: u16,
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        cancelled_at_ms: u64,
    }

    struct CardSold has copy, drop {
        schema_version: u16,
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        season_id: 0x2::object::ID,
        athlete_id: u64,
        serial_number: u64,
        seller: address,
        buyer: address,
        seller_kiosk_id: 0x2::object::ID,
        buyer_kiosk_id: 0x2::object::ID,
        gross_price: u64,
        seller_amount: u64,
        athlete_amount: u64,
        platform_amount: u64,
        athlete_payout: address,
        platform_treasury: address,
        sold_at_ms: u64,
    }

    public entry fun claim(arg0: &PlatformConfig, arg1: &mut SeasonEdition, arg2: ClaimPermit, arg3: &mut 0x2::kiosk::Kiosk, arg4: &PlayerCardKioskCap, arg5: &0x2::transfer_policy::TransferPolicy<PlayerCardV2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.recipient;
        assert!(0x2::tx_context::sender(arg7) == v0 && arg4.owner == v0, 6);
        let v1 = if (0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg4.kiosk_id) {
            if (0x2::kiosk::has_access(arg3, &arg4.native_cap)) {
                0x2::kiosk::owner(arg3) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 14);
        let v2 = if (0x1::option::is_some<0x2::object::ID>(&arg0.policy_id)) {
            let v3 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg5);
            0x1::option::borrow<0x2::object::ID>(&arg0.policy_id) == &v3
        } else {
            false
        };
        assert!(v2, 13);
        let v4 = claim_internal(arg0, arg1, arg2, arg6, arg7);
        0x2::kiosk::lock<PlayerCardV2>(arg3, &arg4.native_cap, arg5, v4);
        let v5 = CardIssued{
            schema_version             : 1,
            card_id                    : 0x2::object::id<PlayerCardV2>(&v4),
            kiosk_id                   : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            policy_id                  : 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg5),
            season_id                  : 0x2::object::id<SeasonEdition>(arg1),
            athlete_id                 : arg1.athlete_id,
            sport                      : arg1.sport,
            serial_number              : arg1.next_serial - 1,
            recipient                  : v0,
            claim_nonce_hash           : arg2.claim_nonce_hash,
            original_snapshot_revision : arg2.original_snapshot_revision,
            issued_at_ms               : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CardIssued>(v5);
    }

    fun authority(arg0: &PlatformConfig, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        assert!(arg1 == 0x2::object::id<PlatformConfig>(arg0) && arg2 == arg3, 1);
    }

    public entry fun cancel_listing(arg0: &PlatformConfig, arg1: MarketplaceListing, arg2: &mut 0x2::kiosk::Kiosk, arg3: &PlayerCardKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<PlayerCardV2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        validate_policy(arg0, arg4);
        assert!(0x2::tx_context::sender(arg6) == arg1.seller && arg3.owner == arg1.seller, 6);
        let v0 = if (arg1.seller_kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg2)) {
            if (arg3.kiosk_id == arg1.seller_kiosk_id) {
                0x2::kiosk::has_access(arg2, &arg3.native_cap)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 14);
        assert!(arg1.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg4) && 0x2::kiosk::is_listed(arg2, arg1.card_id), 17);
        0x2::kiosk::delist<PlayerCardV2>(arg2, &arg3.native_cap, arg1.card_id);
        let MarketplaceListing {
            id              : v1,
            card_id         : v2,
            seller          : v3,
            seller_kiosk_id : v4,
            policy_id       : _,
            gross_price     : _,
            seller_amount   : _,
            athlete_amount  : _,
            platform_amount : _,
            athlete_id      : _,
            season_id       : _,
            serial_number   : _,
            created_at_ms   : _,
        } = arg1;
        let v14 = v1;
        let v15 = CardListingCancelled{
            schema_version  : 1,
            listing_id      : 0x2::object::uid_to_inner(&v14),
            card_id         : v2,
            seller          : v3,
            seller_kiosk_id : v4,
            cancelled_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CardListingCancelled>(v15);
        0x2::object::delete(v14);
    }

    fun claim_internal(arg0: &PlatformConfig, arg1: &mut SeasonEdition, arg2: ClaimPermit, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : PlayerCardV2 {
        authority(arg0, arg2.config, arg2.generation, arg0.mint_generation);
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2.edition == 0x2::object::id<SeasonEdition>(arg1), 1);
        open(arg1, arg3);
        assert!(arg1.distribution_enabled, 4);
        assert!(0x2::tx_context::sender(arg4) == arg2.recipient, 6);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.expires_at_ms, 7);
        assert!(arg1.issued_count < arg1.active_distribution_limit && arg1.issued_count < arg1.hard_cap, 4);
        let v0 = NonceKey{digest: digest_key(&arg2.claim_nonce_hash)};
        assert!(0x2::dynamic_field::exists_<NonceKey>(&arg1.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<NonceKey, NonceRecord>(&mut arg1.id, v0);
        assert!(v1.state == 0 && v1.expires_at_ms == arg2.expires_at_ms, 5);
        v1.state = 1;
        let ClaimPermit {
            id                         : v2,
            config                     : _,
            edition                    : _,
            generation                 : _,
            claim_nonce_hash           : _,
            recipient                  : v7,
            expires_at_ms              : _,
            original_snapshot_revision : v9,
            original_snapshot_uri      : v10,
            original_snapshot_hash     : v11,
        } = arg2;
        0x2::object::delete(v2);
        arg1.issued_count = arg1.issued_count + 1;
        arg1.next_serial = arg1.next_serial + 1;
        PlayerCardV2{
            id                         : 0x2::object::new(arg4),
            season_id                  : 0x2::object::id<SeasonEdition>(arg1),
            athlete_id                 : arg1.athlete_id,
            sport                      : arg1.sport,
            season_label               : arg1.season_label,
            serial_number              : arg1.next_serial,
            issued_at_ms               : 0x2::clock::timestamp_ms(arg3),
            original_recipient         : v7,
            original_snapshot_revision : v9,
            original_snapshot_uri      : v10,
            original_snapshot_hash     : v11,
        }
    }

    public entry fun close_expired_nonce(arg0: &mut SeasonEdition, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 8);
        let v0 = NonceKey{digest: digest_key(&arg1)};
        assert!(0x2::dynamic_field::exists_<NonceKey>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<NonceKey, NonceRecord>(&mut arg0.id, v0);
        assert!(v1.state == 0 && 0x2::clock::timestamp_ms(arg2) >= v1.expires_at_ms, 15);
        v1.state = 2;
    }

    public entry fun create_player_card_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = 0x2::kiosk::new(arg0);
        let v3 = v1;
        let v4 = PlayerCardKioskCap{
            id         : 0x2::object::new(arg0),
            owner      : v0,
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            native_cap : v2,
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::transfer<PlayerCardKioskCap>(v4, v0);
    }

    public entry fun create_season(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SeasonEdition>(new_season(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    fun digest_key(arg0: &vector<u8>) : address {
        let v0 = 0x2::bcs::new(0x2::hash::blake2b256(arg0));
        0x2::bcs::peel_address(&mut v0)
    }

    public entry fun finalize_season(arg0: &PlatformConfig, arg1: &AdminCap, arg2: &mut SeasonEdition, arg3: &0x2::clock::Clock) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2.config == 0x2::object::id<PlatformConfig>(arg0), 1);
        assert!(!arg2.finalized, 3);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.ends_at_ms, 12);
        arg2.finalized = true;
        arg2.distribution_enabled = false;
        arg2.active_distribution_limit = 0;
        let v0 = SeasonFinalized{
            schema_version  : 1,
            season_id       : 0x2::object::id<SeasonEdition>(arg2),
            issued          : arg2.issued_count,
            peak            : arg2.peak_authorized_cap,
            final_revision  : arg2.live_revision,
            finalized_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SeasonFinalized>(v0);
    }

    fun has_season(arg0: &PlatformConfig, arg1: u64, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg1);
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::append<u8>(&mut v0, *arg3);
        let v1 = SeasonKey{digest: digest_key(&v0)};
        0x2::dynamic_field::exists_<SeasonKey>(&arg0.id, v1)
    }

    fun init(arg0: PLAYER_CARD_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<PLAYER_CARD_V2>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<PlayerCardV2>(&v1, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = CustodyRule{dummy_field: false};
        let v7 = CustodyRuleConfig{version: 1};
        0x2::transfer_policy::add_rule<PlayerCardV2, CustodyRule, CustodyRuleConfig>(v6, &mut v5, &v4, v7);
        let v8 = MarketplaceSettlementRule{dummy_field: false};
        let v9 = MarketplaceSettlementConfig{
            athlete_bps        : 250,
            platform_bps       : 250,
            minimum_gross_mist : 40,
        };
        0x2::transfer_policy::add_rule<PlayerCardV2, MarketplaceSettlementRule, MarketplaceSettlementConfig>(v8, &mut v5, &v4, v9);
        let v10 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(&v5);
        let v11 = PolicyGovernanceVault{
            id         : 0x2::object::new(arg1),
            policy_id  : v10,
            policy_cap : v4,
        };
        let v12 = PlatformConfig{
            id                     : 0x2::object::new(arg1),
            treasury               : v0,
            mint_generation        : 1,
            entitlement_generation : 1,
            update_generation      : 1,
            royalty_generation     : 1,
            policy_id              : 0x1::option::some<0x2::object::ID>(v10),
            season_count           : 0,
        };
        let v13 = 0x2::object::id<PlatformConfig>(&v12);
        let v14 = RoyaltyRegistry{
            id           : 0x2::object::new(arg1),
            config       : v13,
            payout_count : 0,
        };
        let v15 = AdminCap{
            id     : 0x2::object::new(arg1),
            config : v13,
        };
        let v16 = MintCap{
            id         : 0x2::object::new(arg1),
            config     : v13,
            generation : 1,
        };
        let v17 = EntitlementCap{
            id         : 0x2::object::new(arg1),
            config     : v13,
            generation : 1,
        };
        let v18 = SeasonUpdateCap{
            id         : 0x2::object::new(arg1),
            config     : v13,
            generation : 1,
        };
        let v19 = RoyaltyAdminCap{
            id         : 0x2::object::new(arg1),
            config     : v13,
            generation : 1,
        };
        let v20 = PlatformInitialized{
            schema_version       : 1,
            config_id            : v13,
            registry_id          : 0x2::object::id<RoyaltyRegistry>(&v14),
            admin_cap_id         : 0x2::object::id<AdminCap>(&v15),
            mint_cap_id          : 0x2::object::id<MintCap>(&v16),
            entitlement_cap_id   : 0x2::object::id<EntitlementCap>(&v17),
            season_update_cap_id : 0x2::object::id<SeasonUpdateCap>(&v18),
            royalty_admin_cap_id : 0x2::object::id<RoyaltyAdminCap>(&v19),
            policy_vault_id      : 0x2::object::id<PolicyGovernanceVault>(&v11),
        };
        0x2::event::emit<PlatformInitialized>(v20);
        let v21 = PolicyGovernanceSealed{
            schema_version  : 1,
            policy_id       : v10,
            policy_vault_id : 0x2::object::id<PolicyGovernanceVault>(&v11),
        };
        0x2::event::emit<PolicyGovernanceSealed>(v21);
        0x2::transfer::share_object<PlatformConfig>(v12);
        0x2::transfer::share_object<RoyaltyRegistry>(v14);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(v5);
        0x2::transfer::share_object<PolicyGovernanceVault>(v11);
        0x2::transfer::transfer<AdminCap>(v15, v0);
        0x2::transfer::transfer<MintCap>(v16, v0);
        0x2::transfer::transfer<EntitlementCap>(v17, v0);
        0x2::transfer::transfer<SeasonUpdateCap>(v18, v0);
        0x2::transfer::transfer<RoyaltyAdminCap>(v19, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun issue_permit(arg0: &PlatformConfig, arg1: &MintCap, arg2: &mut SeasonEdition, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ClaimPermit>(new_permit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), arg3);
    }

    public entry fun list_card(arg0: &PlatformConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &PlayerCardKioskCap, arg3: &0x2::transfer_policy::TransferPolicy<PlayerCardV2>, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg2.owner == v0 && 0x2::kiosk::owner(arg1) == v0, 6);
        assert!(arg2.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1) && 0x2::kiosk::has_access(arg1, &arg2.native_cap), 14);
        validate_policy(arg0, arg3);
        let v1 = if (0x2::kiosk::has_item_with_type<PlayerCardV2>(arg1, arg4)) {
            if (0x2::kiosk::is_locked(arg1, arg4)) {
                !0x2::kiosk::is_listed(arg1, arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 17);
        let (v2, v3, v4) = split_amounts(arg5);
        let v5 = 0x2::kiosk::borrow<PlayerCardV2>(arg1, &arg2.native_cap, arg4);
        let v6 = v5.athlete_id;
        let v7 = v5.season_id;
        let v8 = v5.serial_number;
        let v9 = MarketplaceListing{
            id              : 0x2::object::new(arg7),
            card_id         : arg4,
            seller          : v0,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg3),
            gross_price     : arg5,
            seller_amount   : v2,
            athlete_amount  : v3,
            platform_amount : v4,
            athlete_id      : v6,
            season_id       : v7,
            serial_number   : v8,
            created_at_ms   : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::kiosk::list<PlayerCardV2>(arg1, &arg2.native_cap, arg4, v2);
        let v10 = CardListed{
            schema_version  : 1,
            listing_id      : 0x2::object::id<MarketplaceListing>(&v9),
            card_id         : arg4,
            season_id       : v7,
            athlete_id      : v6,
            serial_number   : v8,
            seller          : v0,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg3),
            gross_price     : arg5,
            seller_amount   : v2,
            athlete_amount  : v3,
            platform_amount : v4,
            created_at_ms   : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CardListed>(v10);
        0x2::transfer::share_object<MarketplaceListing>(v9);
    }

    fun metadata(arg0: &vector<u8>, arg1: &vector<u8>) {
        let v0 = if (!0x1::vector::is_empty<u8>(arg0)) {
            if (0x1::vector::length<u8>(arg0) <= 2048) {
                0x1::vector::length<u8>(arg1) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
    }

    fun new_permit(arg0: &PlatformConfig, arg1: &MintCap, arg2: &mut SeasonEdition, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ClaimPermit {
        authority(arg0, arg1.config, arg1.generation, arg0.mint_generation);
        assert!(arg2.config == 0x2::object::id<PlatformConfig>(arg0), 1);
        open(arg2, arg7);
        let v0 = if (arg2.distribution_enabled) {
            if (arg2.issued_count < arg2.active_distribution_limit) {
                arg2.issued_count < arg2.hard_cap
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(arg3 != @0x0, 6);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 8);
        assert!(arg5 > 0x2::clock::timestamp_ms(arg7) && arg5 <= arg2.ends_at_ms, 7);
        assert!(arg6 == arg2.live_revision, 9);
        let v1 = NonceKey{digest: digest_key(&arg4)};
        assert!(!0x2::dynamic_field::exists_<NonceKey>(&arg2.id, v1), 5);
        let v2 = NonceRecord{
            state         : 0,
            expires_at_ms : arg5,
        };
        0x2::dynamic_field::add<NonceKey, NonceRecord>(&mut arg2.id, v1, v2);
        arg2.nonce_count = arg2.nonce_count + 1;
        let v3 = ClaimPermit{
            id                         : 0x2::object::new(arg8),
            config                     : 0x2::object::id<PlatformConfig>(arg0),
            edition                    : 0x2::object::id<SeasonEdition>(arg2),
            generation                 : arg0.mint_generation,
            claim_nonce_hash           : arg4,
            recipient                  : arg3,
            expires_at_ms              : arg5,
            original_snapshot_revision : arg2.live_revision,
            original_snapshot_uri      : arg2.live_snapshot_uri,
            original_snapshot_hash     : arg2.live_snapshot_hash,
        };
        let v4 = ClaimPermitIssued{
            schema_version    : 1,
            permit_id         : 0x2::object::id<ClaimPermit>(&v3),
            season_id         : 0x2::object::id<SeasonEdition>(arg2),
            claim_nonce_hash  : arg4,
            recipient         : arg3,
            expires_at_ms     : arg5,
            snapshot_revision : arg2.live_revision,
        };
        0x2::event::emit<ClaimPermitIssued>(v4);
        v3
    }

    fun new_season(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) : SeasonEdition {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0), 1);
        let v0 = if (arg2 > 0) {
            if (!0x1::vector::is_empty<u8>(&arg3)) {
                !0x1::vector::is_empty<u8>(&arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        assert!(arg5 < arg6, 10);
        tier(arg7);
        metadata(&arg8, &arg9);
        assert!(!has_season(arg0, arg2, &arg3, &arg4), 11);
        let v1 = 0x1::bcs::to_bytes<u64>(&arg2);
        0x1::vector::append<u8>(&mut v1, arg3);
        0x1::vector::append<u8>(&mut v1, arg4);
        let v2 = SeasonKey{digest: digest_key(&v1)};
        0x2::dynamic_field::add<SeasonKey, bool>(&mut arg0.id, v2, true);
        arg0.season_count = arg0.season_count + 1;
        let v3 = SeasonEdition{
            id                        : 0x2::object::new(arg10),
            config                    : 0x2::object::id<PlatformConfig>(arg0),
            athlete_id                : arg2,
            sport                     : arg3,
            season_label              : arg4,
            starts_at_ms              : arg5,
            ends_at_ms                : arg6,
            hard_cap                  : 100,
            peak_authorized_cap       : arg7,
            active_distribution_limit : arg7,
            issued_count              : 0,
            next_serial               : 1,
            distribution_enabled      : arg7 > 0,
            finalized                 : false,
            live_revision             : 1,
            live_snapshot_uri         : arg8,
            live_snapshot_hash        : arg9,
            nonce_count               : 0,
        };
        let v4 = SeasonCreated{
            schema_version : 1,
            season_id      : 0x2::object::id<SeasonEdition>(&v3),
            athlete_id     : arg2,
            starts_at_ms   : arg5,
            ends_at_ms     : arg6,
            initial_limit  : arg7,
            live_revision  : 1,
        };
        0x2::event::emit<SeasonCreated>(v4);
        v3
    }

    fun open(arg0: &SeasonEdition, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (!arg0.finalized) {
            if (v0 >= arg0.starts_at_ms) {
                v0 < arg0.ends_at_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
    }

    public entry fun purchase_and_relock(arg0: &PlatformConfig, arg1: &RoyaltyRegistry, arg2: MarketplaceListing, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &PlayerCardKioskCap, arg6: &0x2::transfer_policy::TransferPolicy<PlayerCardV2>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        validate_policy(arg0, arg6);
        assert!(arg5.owner == v0 && 0x2::kiosk::owner(arg4) == v0, 6);
        assert!(arg5.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg4) && 0x2::kiosk::has_access(arg4, &arg5.native_cap), 14);
        assert!(v0 != arg2.seller, 19);
        let v1 = if (arg2.seller_kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg3)) {
            if (arg2.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg6)) {
                0x2::kiosk::is_listed(arg3, arg2.card_id)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 17);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == arg2.gross_price, 16);
        let (v2, v3, v4) = split_amounts(arg2.gross_price);
        let v5 = if (v2 == arg2.seller_amount) {
            if (v3 == arg2.athlete_amount) {
                v4 == arg2.platform_amount
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 16);
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && 0x2::dynamic_field::exists_<u64>(&arg1.id, arg2.athlete_id), 18);
        let v6 = 0x2::dynamic_field::borrow<u64, Payout>(&arg1.id, arg2.athlete_id).address;
        assert!(v6 != @0x0 && arg0.treasury != @0x0, 18);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == v2, 16);
        let (v7, v8) = 0x2::kiosk::purchase<PlayerCardV2>(arg3, arg2.card_id, arg7);
        let v9 = v8;
        let v10 = v7;
        let v11 = if (0x2::transfer_policy::item<PlayerCardV2>(&v9) == arg2.card_id) {
            if (0x2::transfer_policy::paid<PlayerCardV2>(&v9) == v2) {
                0x2::transfer_policy::from<PlayerCardV2>(&v9) == arg2.seller_kiosk_id
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 17);
        let v12 = if (v10.athlete_id == arg2.athlete_id) {
            if (v10.season_id == arg2.season_id) {
                v10.serial_number == arg2.serial_number
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 17);
        0x2::kiosk::lock<PlayerCardV2>(arg4, &arg5.native_cap, arg6, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v3, arg9), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v4, arg9), arg0.treasury);
        let v13 = CustodyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<PlayerCardV2, CustodyRule>(v13, &mut v9);
        let v14 = MarketplaceSettlementRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<PlayerCardV2, MarketplaceSettlementRule>(v14, &mut v9);
        let (v15, v16, v17) = 0x2::transfer_policy::confirm_request<PlayerCardV2>(arg6, v9);
        let v18 = if (v15 == arg2.card_id) {
            if (v16 == v2) {
                v17 == arg2.seller_kiosk_id
            } else {
                false
            }
        } else {
            false
        };
        assert!(v18, 17);
        let MarketplaceListing {
            id              : v19,
            card_id         : v20,
            seller          : v21,
            seller_kiosk_id : v22,
            policy_id       : _,
            gross_price     : v24,
            seller_amount   : v25,
            athlete_amount  : v26,
            platform_amount : v27,
            athlete_id      : v28,
            season_id       : v29,
            serial_number   : v30,
            created_at_ms   : _,
        } = arg2;
        let v32 = v19;
        let v33 = CardSold{
            schema_version    : 1,
            listing_id        : 0x2::object::uid_to_inner(&v32),
            card_id           : v20,
            season_id         : v29,
            athlete_id        : v28,
            serial_number     : v30,
            seller            : v21,
            buyer             : v0,
            seller_kiosk_id   : v22,
            buyer_kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            gross_price       : v24,
            seller_amount     : v25,
            athlete_amount    : v26,
            platform_amount   : v27,
            athlete_payout    : v6,
            platform_treasury : arg0.treasury,
            sold_at_ms        : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<CardSold>(v33);
        0x2::object::delete(v32);
    }

    public entry fun rotate_entitlement_cap(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2 != @0x0, 1);
        arg0.entitlement_generation = arg0.entitlement_generation + 1;
        let v0 = OperationalCapRotated{
            schema_version : 1,
            config_id      : 0x2::object::id<PlatformConfig>(arg0),
            cap_kind       : b"entitlement",
            generation     : arg0.entitlement_generation,
            recipient      : arg2,
        };
        0x2::event::emit<OperationalCapRotated>(v0);
        let v1 = EntitlementCap{
            id         : 0x2::object::new(arg3),
            config     : 0x2::object::id<PlatformConfig>(arg0),
            generation : arg0.entitlement_generation,
        };
        0x2::transfer::transfer<EntitlementCap>(v1, arg2);
    }

    public entry fun rotate_mint_cap(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2 != @0x0, 1);
        arg0.mint_generation = arg0.mint_generation + 1;
        let v0 = OperationalCapRotated{
            schema_version : 1,
            config_id      : 0x2::object::id<PlatformConfig>(arg0),
            cap_kind       : b"mint",
            generation     : arg0.mint_generation,
            recipient      : arg2,
        };
        0x2::event::emit<OperationalCapRotated>(v0);
        let v1 = MintCap{
            id         : 0x2::object::new(arg3),
            config     : 0x2::object::id<PlatformConfig>(arg0),
            generation : arg0.mint_generation,
        };
        0x2::transfer::transfer<MintCap>(v1, arg2);
    }

    public entry fun rotate_royalty_admin_cap(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2 != @0x0, 1);
        arg0.royalty_generation = arg0.royalty_generation + 1;
        let v0 = OperationalCapRotated{
            schema_version : 1,
            config_id      : 0x2::object::id<PlatformConfig>(arg0),
            cap_kind       : b"royalty_admin",
            generation     : arg0.royalty_generation,
            recipient      : arg2,
        };
        0x2::event::emit<OperationalCapRotated>(v0);
        let v1 = RoyaltyAdminCap{
            id         : 0x2::object::new(arg3),
            config     : 0x2::object::id<PlatformConfig>(arg0),
            generation : arg0.royalty_generation,
        };
        0x2::transfer::transfer<RoyaltyAdminCap>(v1, arg2);
    }

    public entry fun rotate_season_update_cap(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2 != @0x0, 1);
        arg0.update_generation = arg0.update_generation + 1;
        let v0 = OperationalCapRotated{
            schema_version : 1,
            config_id      : 0x2::object::id<PlatformConfig>(arg0),
            cap_kind       : b"season_update",
            generation     : arg0.update_generation,
            recipient      : arg2,
        };
        0x2::event::emit<OperationalCapRotated>(v0);
        let v1 = SeasonUpdateCap{
            id         : 0x2::object::new(arg3),
            config     : 0x2::object::id<PlatformConfig>(arg0),
            generation : arg0.update_generation,
        };
        0x2::transfer::transfer<SeasonUpdateCap>(v1, arg2);
    }

    public entry fun set_entitlement(arg0: &PlatformConfig, arg1: &EntitlementCap, arg2: &mut SeasonEdition, arg3: u64, arg4: &0x2::clock::Clock) {
        authority(arg0, arg1.config, arg1.generation, arg0.entitlement_generation);
        assert!(arg2.config == 0x2::object::id<PlatformConfig>(arg0), 1);
        open(arg2, arg4);
        tier(arg3);
        arg2.active_distribution_limit = arg3;
        arg2.distribution_enabled = arg3 > 0;
        if (arg3 > arg2.peak_authorized_cap) {
            arg2.peak_authorized_cap = arg3;
        };
        let v0 = EntitlementChanged{
            schema_version : 1,
            season_id      : 0x2::object::id<SeasonEdition>(arg2),
            active         : arg3,
            peak           : arg2.peak_authorized_cap,
            issued         : arg2.issued_count,
            next_serial    : arg2.next_serial,
        };
        0x2::event::emit<EntitlementChanged>(v0);
    }

    public entry fun set_payout(arg0: &PlatformConfig, arg1: &RoyaltyAdminCap, arg2: &mut RoyaltyRegistry, arg3: u64, arg4: address) {
        authority(arg0, arg1.config, arg1.generation, arg0.royalty_generation);
        let v0 = if (arg2.config == 0x2::object::id<PlatformConfig>(arg0)) {
            if (arg3 > 0) {
                arg4 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (0x2::dynamic_field::exists_<u64>(&arg2.id, arg3)) {
            let v1 = 0x2::dynamic_field::borrow_mut<u64, Payout>(&mut arg2.id, arg3);
            v1.address = arg4;
            v1.revision = v1.revision + 1;
            let v2 = AthletePayoutUpdated{
                schema_version : 1,
                athlete        : arg3,
                payout         : arg4,
                revision       : v1.revision,
            };
            0x2::event::emit<AthletePayoutUpdated>(v2);
        } else {
            let v3 = Payout{
                athlete  : arg3,
                address  : arg4,
                revision : 1,
            };
            0x2::dynamic_field::add<u64, Payout>(&mut arg2.id, arg3, v3);
            arg2.payout_count = arg2.payout_count + 1;
            let v4 = AthletePayoutUpdated{
                schema_version : 1,
                athlete        : arg3,
                payout         : arg4,
                revision       : 1,
            };
            0x2::event::emit<AthletePayoutUpdated>(v4);
        };
    }

    public entry fun set_treasury(arg0: &mut PlatformConfig, arg1: &AdminCap, arg2: address) {
        assert!(arg1.config == 0x2::object::id<PlatformConfig>(arg0) && arg2 != @0x0, 1);
        arg0.treasury = arg2;
        let v0 = TreasuryUpdated{
            schema_version    : 1,
            config_id         : 0x2::object::id<PlatformConfig>(arg0),
            previous_treasury : arg0.treasury,
            new_treasury      : arg2,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    fun split_amounts(arg0: u64) : (u64, u64, u64) {
        assert!(arg0 >= 40, 16);
        let v0 = (((arg0 as u128) * 250 / 10000) as u64);
        let v1 = (((arg0 as u128) * 250 / 10000) as u64);
        assert!(v0 > 0 && v1 > 0, 16);
        let v2 = arg0 - v0 - v1;
        assert!(v2 + v0 + v1 == arg0, 16);
        (v2, v0, v1)
    }

    fun tier(arg0: u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 50) {
            true
        } else {
            arg0 == 100
        };
        assert!(v0, 2);
    }

    public entry fun update_live(arg0: &PlatformConfig, arg1: &SeasonUpdateCap, arg2: &mut SeasonEdition, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        authority(arg0, arg1.config, arg1.generation, arg0.update_generation);
        assert!(arg2.config == 0x2::object::id<PlatformConfig>(arg0), 1);
        open(arg2, arg6);
        metadata(&arg4, &arg5);
        assert!(arg3 == arg2.live_revision, 9);
        arg2.live_revision = arg2.live_revision + 1;
        arg2.live_snapshot_uri = arg4;
        arg2.live_snapshot_hash = arg5;
        let v0 = SeasonLiveDataUpdated{
            schema_version : 1,
            season_id      : 0x2::object::id<SeasonEdition>(arg2),
            revision       : arg2.live_revision,
            snapshot_hash  : arg5,
        };
        0x2::event::emit<SeasonLiveDataUpdated>(v0);
    }

    fun validate_policy(arg0: &PlatformConfig, arg1: &0x2::transfer_policy::TransferPolicy<PlayerCardV2>) {
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg0.policy_id)) {
            let v1 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<PlayerCardV2>>(arg1);
            0x1::option::borrow<0x2::object::ID>(&arg0.policy_id) == &v1
        } else {
            false
        };
        assert!(v0, 13);
        assert!(0x2::transfer_policy::has_rule<PlayerCardV2, CustodyRule>(arg1) && 0x2::transfer_policy::has_rule<PlayerCardV2, MarketplaceSettlementRule>(arg1), 13);
        let v2 = CustodyRule{dummy_field: false};
        let v3 = MarketplaceSettlementRule{dummy_field: false};
        let v4 = 0x2::transfer_policy::get_rule<PlayerCardV2, MarketplaceSettlementRule, MarketplaceSettlementConfig>(v3, arg1);
        let v5 = if (0x2::transfer_policy::get_rule<PlayerCardV2, CustodyRule, CustodyRuleConfig>(v2, arg1).version == 1) {
            if (v4.athlete_bps == 250) {
                if (v4.platform_bps == 250) {
                    v4.minimum_gross_mist == 40
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 13);
    }

    public entry fun withdraw_sale_proceeds(arg0: &mut 0x2::kiosk::Kiosk, arg1: &PlayerCardKioskCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg1.kiosk_id && 0x2::kiosk::has_access(arg0, &arg1.native_cap), 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg0, &arg1.native_cap, arg2, arg3), arg1.owner);
    }

    // decompiled from Move bytecode v7
}

