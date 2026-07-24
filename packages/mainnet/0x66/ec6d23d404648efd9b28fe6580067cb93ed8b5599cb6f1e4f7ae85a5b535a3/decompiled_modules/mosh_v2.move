module 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::mosh_v2 {
    struct IdentityV2 has copy, drop, store {
        source_id: u64,
        metadata_hash: vector<u8>,
        canonical_art_hash: vector<u8>,
    }

    struct ActiveIdentityV2 has copy, drop, store {
        punk_id: 0x2::object::ID,
        identity: IdentityV2,
        origin_season: u64,
        origin_rotation_id: u64,
        origin_pool_piece: u64,
        reroll_count: u64,
    }

    struct PoolPieceV2 has copy, drop, store {
        source_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        metadata_hash: vector<u8>,
        canonical_art_hash: vector<u8>,
        image_hash: vector<u8>,
    }

    struct DeadIdentityRecord has copy, drop, store {
        death_id: u64,
        punk_id: 0x2::object::ID,
        punk_index: u64,
        previous_identity: IdentityV2,
        replacement_identity: IdentityV2,
        season: u64,
        rotation_id: u64,
        pool_piece: u64,
        actor: address,
    }

    struct RotationRecord has copy, drop, store {
        id: u64,
        status: u8,
        selection_mode: u8,
        expected_remaining: u64,
        seeded: u64,
        request_key: vector<u8>,
        request_payload_hash: vector<u8>,
        selection_hash: vector<u8>,
        manifest_hash: vector<u8>,
        image_root_hash: vector<u8>,
        activated_at_ms: u64,
    }

    struct RotationRequestReceipt has copy, drop, store {
        rotation_id: u64,
        payload_hash: vector<u8>,
    }

    struct BatchKey has copy, drop, store {
        rotation_id: u64,
        batch_index: u64,
    }

    struct SeedBatchPayload has copy, drop, store {
        rotation_id: u64,
        batch_index: u64,
        positions: vector<u64>,
        source_ids: vector<u64>,
        counts: vector<u64>,
        keys_flat: vector<vector<u8>>,
        values_flat: vector<vector<u8>>,
        art_hashes: vector<vector<u8>>,
        image_hashes: vector<vector<u8>>,
    }

    struct BootstrapKey has copy, drop, store {
        kind: u8,
        batch_index: u64,
    }

    struct ActiveBootstrapPayload has copy, drop, store {
        batch_index: u64,
        punk_ids: vector<0x2::object::ID>,
        punk_indices: vector<u64>,
        source_ids: vector<u64>,
        metadata_hashes: vector<vector<u8>>,
        art_hashes: vector<vector<u8>>,
        origin_seasons: vector<u64>,
        origin_rotations: vector<u64>,
        origin_pieces: vector<u64>,
        reroll_counts: vector<u64>,
    }

    struct HistoryBootstrapPayload has copy, drop, store {
        batch_index: u64,
        punk_ids: vector<0x2::object::ID>,
        punk_indices: vector<u64>,
        previous_sources: vector<u64>,
        previous_metadata: vector<vector<u8>>,
        previous_art: vector<vector<u8>>,
        replacement_sources: vector<u64>,
        replacement_metadata: vector<vector<u8>>,
        replacement_art: vector<vector<u8>>,
        pool_pieces: vector<u64>,
        actors: vector<address>,
    }

    struct ConditionClause has copy, drop, store {
        group: u16,
        kind: u8,
        key: 0x1::string::String,
        value: 0x1::string::String,
        number: u64,
        object_id: 0x2::object::ID,
    }

    struct VoucherCampaign has copy, drop, store {
        id: u64,
        tier: u8,
        discount_bps: u16,
        max_discount_mist: u64,
        expires_at_ms: u64,
        supply: u64,
        minted: u64,
        redeemed: u64,
        closed: bool,
        policy_hash: vector<u8>,
        policy: vector<ConditionClause>,
    }

    struct MoshVoucher has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        season: u64,
        campaign_id: u64,
        serial: u64,
        discount_bps: u16,
        max_discount_mist: u64,
        expires_at_ms: u64,
        used: bool,
        used_for: 0x2::object::ID,
        redeemed_piece: u64,
    }

    struct IdentityRegistry has store {
        bootstrap_receipts: 0x2::table::Table<BootstrapKey, vector<u8>>,
        active_by_punk: 0x2::table::Table<u64, ActiveIdentityV2>,
        active_sources: 0x2::table::Table<u64, bool>,
        active_metadata: 0x2::table::Table<vector<u8>, bool>,
        active_art: 0x2::table::Table<vector<u8>, bool>,
        active_count: u64,
        consumed_sources: 0x2::table::Table<u64, bool>,
        consumed_metadata: 0x2::table::Table<vector<u8>, bool>,
        consumed_art: 0x2::table::Table<vector<u8>, bool>,
        consumed_count: u64,
        dead_sources: 0x2::table::Table<u64, bool>,
        dead_metadata: 0x2::table::Table<vector<u8>, bool>,
        dead_art: 0x2::table::Table<vector<u8>, bool>,
        dead_records: 0x2::table::Table<u64, DeadIdentityRecord>,
        dead_count: u64,
        expected_v1_deaths: u64,
        v1_history_count: u64,
    }

    struct VoucherRegistry has store {
        campaigns: 0x2::table::Table<u64, VoucherCampaign>,
        next_campaign_id: u64,
        next_voucher_serial: u64,
        issued_25: u64,
        issued_50: u64,
        issued_free: u64,
    }

    struct RerollPoolV2 has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        season: u64,
        is_open: bool,
        is_deprecated: bool,
        price: u64,
        treasury: address,
        size: u64,
        remaining: u64,
        active_rotation_id: u64,
        next_rotation_id: u64,
        next_rotation_after_ms: u64,
        resume_open_after_rotation: bool,
        rotations: 0x2::table::Table<u64, RotationRecord>,
        rotation_requests: 0x2::table::Table<vector<u8>, RotationRequestReceipt>,
        batch_receipts: 0x2::table::Table<BatchKey, vector<u8>>,
        active_registry: 0x2::table::Table<u64, PoolPieceV2>,
        shuffle: 0x2::table::Table<u64, u64>,
        staging_rotation_id: u64,
        staging_expected: u64,
        staging_seeded: u64,
        staging_registry: 0x2::table::Table<u64, PoolPieceV2>,
        staging_sources: 0x2::table::Table<u64, bool>,
        staging_metadata: 0x2::table::Table<vector<u8>, bool>,
        staging_art: 0x2::table::Table<vector<u8>, bool>,
        identities: IdentityRegistry,
        vouchers: VoucherRegistry,
    }

    struct RerollPoolV2Created has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        size: u64,
        price: u64,
        treasury: address,
        expected_v1_deaths: u64,
    }

    struct PoolRotationV2Started has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        rotation_id: u64,
        expected_remaining: u64,
        selection_mode: u8,
        request_key: vector<u8>,
    }

    struct PoolRotationV2SeedBatch has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        rotation_id: u64,
        batch_index: u64,
        batch_hash: vector<u8>,
        seeded_total: u64,
    }

    struct PoolRotationV2Sealed has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        rotation_id: u64,
        selection_hash: vector<u8>,
        manifest_hash: vector<u8>,
        image_root_hash: vector<u8>,
    }

    struct PoolRotationV2Activated has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        rotation_id: u64,
        remaining: u64,
        activated_at_ms: u64,
    }

    struct DeadIdentityRecorded has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        record: DeadIdentityRecord,
    }

    struct VoucherCampaignCreated has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        campaign_id: u64,
        tier: u8,
        supply: u64,
        policy_hash: vector<u8>,
    }

    struct MoshVoucherIssued has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        campaign_id: u64,
        voucher_id: 0x2::object::ID,
        serial: u64,
        recipient: address,
    }

    struct MoshVoucherRedeemed has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        campaign_id: u64,
        voucher_id: 0x2::object::ID,
        punk_id: 0x2::object::ID,
        discount_bps: u16,
        discount_mist: u64,
        amount_paid: u64,
    }

    struct PunkRerolledV2 has copy, drop {
        pool_id: 0x2::object::ID,
        season: u64,
        rotation_id: u64,
        pool_piece: u64,
        source_id: u64,
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        owner: address,
        custody: u8,
        death_id: u64,
        previous_identity: IdentityV2,
        replacement_identity: IdentityV2,
        listed_price: u64,
        discount_bps: u16,
        discount_mist: u64,
        amount_paid: u64,
        voucher_id: 0x2::object::ID,
        campaign_id: u64,
    }

    public fun activate_rotation(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin(arg0, arg1);
        let v0 = if (arg1.active_rotation_id == arg2) {
            if (0x2::table::contains<u64, RotationRecord>(&arg1.rotations, arg2)) {
                0x2::table::borrow<u64, RotationRecord>(&arg1.rotations, arg2).status == 2
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return
        };
        assert!(arg1.staging_rotation_id == arg2, 7);
        assert!(0x2::table::borrow<u64, RotationRecord>(&arg1.rotations, arg2).status == 1, 7);
        assert!(arg1.remaining == arg1.staging_expected, 16);
        assert!(arg1.staging_seeded == arg1.remaining, 8);
        if (arg1.active_rotation_id != 0) {
            clear_active_selection(arg1);
            0x2::table::borrow_mut<u64, RotationRecord>(&mut arg1.rotations, arg1.active_rotation_id).status = 3;
        };
        let v1 = 0;
        while (v1 < arg1.remaining) {
            let v2 = 0x2::table::remove<u64, PoolPieceV2>(&mut arg1.staging_registry, v1);
            0x2::table::remove<u64, bool>(&mut arg1.staging_sources, v2.source_id);
            0x2::table::remove<vector<u8>, bool>(&mut arg1.staging_metadata, v2.metadata_hash);
            0x2::table::remove<vector<u8>, bool>(&mut arg1.staging_art, v2.canonical_art_hash);
            0x2::table::add<u64, PoolPieceV2>(&mut arg1.active_registry, v1, v2);
            v1 = v1 + 1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::table::borrow_mut<u64, RotationRecord>(&mut arg1.rotations, arg2);
        v4.status = 2;
        v4.activated_at_ms = v3;
        arg1.active_rotation_id = arg2;
        arg1.staging_rotation_id = 0;
        arg1.staging_expected = 0;
        arg1.staging_seeded = 0;
        arg1.next_rotation_after_ms = v3 + 604800000;
        if (arg1.resume_open_after_rotation) {
            arg1.is_open = true;
        };
        arg1.resume_open_after_rotation = false;
        let v5 = PoolRotationV2Activated{
            pool_id         : 0x2::object::id<RerollPoolV2>(arg1),
            season          : arg1.season,
            rotation_id     : arg2,
            remaining       : arg1.remaining,
            activated_at_ms : v3,
        };
        0x2::event::emit<PoolRotationV2Activated>(v5);
    }

    public fun active_count(arg0: &RerollPoolV2) : u64 {
        arg0.identities.active_count
    }

    public fun active_identity(arg0: &RerollPoolV2, arg1: u64) : &ActiveIdentityV2 {
        0x2::table::borrow<u64, ActiveIdentityV2>(&arg0.identities.active_by_punk, arg1)
    }

    public fun active_rotation_id(arg0: &RerollPoolV2) : u64 {
        arg0.active_rotation_id
    }

    fun add_active_identity(arg0: &mut RerollPoolV2, arg1: &IdentityV2) {
        assert_identity_keys_free(&arg0.identities.active_sources, &arg0.identities.active_metadata, &arg0.identities.active_art, arg1.source_id, &arg1.metadata_hash, &arg1.canonical_art_hash);
        0x2::table::add<u64, bool>(&mut arg0.identities.active_sources, arg1.source_id, true);
        0x2::table::add<vector<u8>, bool>(&mut arg0.identities.active_metadata, arg1.metadata_hash, true);
        0x2::table::add<vector<u8>, bool>(&mut arg0.identities.active_art, arg1.canonical_art_hash, true);
    }

    fun add_consumed_identity(arg0: &mut RerollPoolV2, arg1: &IdentityV2) {
        if (!0x2::table::contains<u64, bool>(&arg0.identities.consumed_sources, arg1.source_id)) {
            0x2::table::add<u64, bool>(&mut arg0.identities.consumed_sources, arg1.source_id, true);
            arg0.identities.consumed_count = arg0.identities.consumed_count + 1;
        };
        if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.consumed_metadata, arg1.metadata_hash)) {
            0x2::table::add<vector<u8>, bool>(&mut arg0.identities.consumed_metadata, arg1.metadata_hash, true);
        };
        if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.consumed_art, arg1.canonical_art_hash)) {
            0x2::table::add<vector<u8>, bool>(&mut arg0.identities.consumed_art, arg1.canonical_art_hash, true);
        };
    }

    fun add_dead_identity(arg0: &mut RerollPoolV2, arg1: &IdentityV2) {
        let v0 = if (!0x2::table::contains<u64, bool>(&arg0.identities.active_sources, arg1.source_id)) {
            if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.active_metadata, arg1.metadata_hash)) {
                !0x2::table::contains<vector<u8>, bool>(&arg0.identities.active_art, arg1.canonical_art_hash)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(!0x2::table::contains<u64, bool>(&arg0.identities.dead_sources, arg1.source_id), 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.identities.dead_metadata, arg1.metadata_hash), 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.identities.dead_art, arg1.canonical_art_hash), 5);
        0x2::table::add<u64, bool>(&mut arg0.identities.dead_sources, arg1.source_id, true);
        0x2::table::add<vector<u8>, bool>(&mut arg0.identities.dead_metadata, arg1.metadata_hash, true);
        0x2::table::add<vector<u8>, bool>(&mut arg0.identities.dead_art, arg1.canonical_art_hash, true);
    }

    fun assert_admin(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &RerollPoolV2) {
        assert!(0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap>(arg0) == arg1.admin, 0);
    }

    fun assert_bootstrap(arg0: &RerollPoolV2) {
        assert!(arg0.active_rotation_id == 0 && !arg0.is_open, 7);
    }

    fun assert_candidate_available(arg0: &RerollPoolV2, arg1: u64, arg2: &vector<u8>, arg3: &vector<u8>) {
        let v0 = if (!0x2::table::contains<u64, bool>(&arg0.identities.active_sources, arg1)) {
            if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.active_metadata, *arg2)) {
                if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.active_art, *arg3)) {
                    if (!0x2::table::contains<u64, bool>(&arg0.identities.consumed_sources, arg1)) {
                        if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.consumed_metadata, *arg2)) {
                            if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.consumed_art, *arg3)) {
                                if (!0x2::table::contains<u64, bool>(&arg0.identities.dead_sources, arg1)) {
                                    if (!0x2::table::contains<vector<u8>, bool>(&arg0.identities.dead_metadata, *arg2)) {
                                        !0x2::table::contains<vector<u8>, bool>(&arg0.identities.dead_art, *arg3)
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
    }

    fun assert_identity_hashes(arg0: &IdentityV2) {
        assert_hash(&arg0.metadata_hash);
        assert_hash(&arg0.canonical_art_hash);
    }

    fun assert_identity_keys_free(arg0: &0x2::table::Table<u64, bool>, arg1: &0x2::table::Table<vector<u8>, bool>, arg2: &0x2::table::Table<vector<u8>, bool>, arg3: u64, arg4: &vector<u8>, arg5: &vector<u8>) {
        let v0 = if (!0x2::table::contains<u64, bool>(arg0, arg3)) {
            if (!0x2::table::contains<vector<u8>, bool>(arg1, *arg4)) {
                !0x2::table::contains<vector<u8>, bool>(arg2, *arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
    }

    fun assert_not_deprecated(arg0: &RerollPoolV2) {
        assert!(!arg0.is_deprecated, 30);
    }

    fun assert_selection_mode(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 18);
    }

    public fun begin_rotation(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &0x2::clock::Clock) : u64 {
        assert_admin(arg0, arg1);
        assert_not_deprecated(arg1);
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_selection_mode(arg4);
        if (0x2::table::contains<vector<u8>, RotationRequestReceipt>(&arg1.rotation_requests, arg2)) {
            let v0 = 0x2::table::borrow<vector<u8>, RotationRequestReceipt>(&arg1.rotation_requests, arg2);
            assert!(v0.payload_hash == arg3, 16);
            return v0.rotation_id
        };
        assert!(arg1.staging_rotation_id == 0, 15);
        assert!(arg1.active_rotation_id != 0, 7);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.next_rotation_after_ms, 14);
        let v1 = arg1.next_rotation_id;
        arg1.next_rotation_id = v1 + 1;
        arg1.resume_open_after_rotation = arg1.is_open;
        arg1.is_open = false;
        arg1.staging_rotation_id = v1;
        arg1.staging_expected = arg1.remaining;
        arg1.staging_seeded = 0;
        let v2 = RotationRecord{
            id                   : v1,
            status               : 0,
            selection_mode       : arg4,
            expected_remaining   : arg1.remaining,
            seeded               : 0,
            request_key          : arg2,
            request_payload_hash : arg3,
            selection_hash       : b"",
            manifest_hash        : b"",
            image_root_hash      : b"",
            activated_at_ms      : 0,
        };
        0x2::table::add<u64, RotationRecord>(&mut arg1.rotations, v1, v2);
        let v3 = RotationRequestReceipt{
            rotation_id  : v1,
            payload_hash : arg3,
        };
        0x2::table::add<vector<u8>, RotationRequestReceipt>(&mut arg1.rotation_requests, arg2, v3);
        let v4 = PoolRotationV2Started{
            pool_id            : 0x2::object::id<RerollPoolV2>(arg1),
            season             : arg1.season,
            rotation_id        : v1,
            expected_remaining : arg1.remaining,
            selection_mode     : arg4,
            request_key        : arg2,
        };
        0x2::event::emit<PoolRotationV2Started>(v4);
        v1
    }

    fun calculate_discount(arg0: u64, arg1: u16, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 < arg2) {
            v0
        } else {
            arg2
        }
    }

    public fun campaign(arg0: &RerollPoolV2, arg1: u64) : &VoucherCampaign {
        0x2::table::borrow<u64, VoucherCampaign>(&arg0.vouchers.campaigns, arg1)
    }

    public fun cancel_rotation(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64) {
        assert_admin(arg0, arg1);
        assert!(arg1.staging_rotation_id == arg2, 7);
        let v0 = 0;
        while (v0 < arg1.staging_expected) {
            if (0x2::table::contains<u64, PoolPieceV2>(&arg1.staging_registry, v0)) {
                let v1 = 0x2::table::remove<u64, PoolPieceV2>(&mut arg1.staging_registry, v0);
                0x2::table::remove<u64, bool>(&mut arg1.staging_sources, v1.source_id);
                0x2::table::remove<vector<u8>, bool>(&mut arg1.staging_metadata, v1.metadata_hash);
                0x2::table::remove<vector<u8>, bool>(&mut arg1.staging_art, v1.canonical_art_hash);
            };
            v0 = v0 + 1;
        };
        0x2::table::borrow_mut<u64, RotationRecord>(&mut arg1.rotations, arg2).status = 4;
        arg1.staging_rotation_id = 0;
        arg1.staging_expected = 0;
        arg1.staging_seeded = 0;
        arg1.is_open = arg1.resume_open_after_rotation;
        arg1.resume_open_after_rotation = false;
    }

    fun clause_matches(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg1: &ActiveIdentityV2, arg2: u8, arg3: &ConditionClause) : bool {
        let v0 = 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::attributes(arg0);
        if (arg3.kind == 0) {
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &arg3.key)) {
                let v2 = arg3.value;
                0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v0, &arg3.key) == &v2
            } else {
                false
            }
        } else {
            arg3.kind == 1 && 0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &arg3.key) || arg3.kind == 2 && !0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v0, &arg3.key) || arg3.kind == 3 && 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(v0) >= arg3.number || arg3.kind == 4 && 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(v0) <= arg3.number || arg3.kind == 5 && 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::index(arg0) == arg3.number || arg3.kind == 6 && 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::number(arg0) == arg3.number || arg3.kind == 7 && 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg0) == arg3.object_id || arg3.kind == 8 && (arg2 as u64) == arg3.number || arg3.kind == 9 && arg1.origin_season == arg3.number || arg3.kind == 10 && arg1.reroll_count >= arg3.number
        }
    }

    fun clear_active_selection(arg0: &mut RerollPoolV2) {
        let v0 = arg0.remaining;
        let v1 = 0;
        while (v1 < v0) {
            let v2 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
                *0x2::table::borrow<u64, u64>(&arg0.shuffle, v1)
            } else {
                v1
            };
            0x2::table::remove<u64, PoolPieceV2>(&mut arg0.active_registry, v2);
            v1 = v1 + 1;
        };
        let v3 = 0;
        while (v3 < v0) {
            if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
                0x2::table::remove<u64, u64>(&mut arg0.shuffle, v3);
            };
            v3 = v3 + 1;
        };
    }

    public fun close_expired_campaign(arg0: &mut RerollPoolV2, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, VoucherCampaign>(&arg0.vouchers.campaigns, arg1), 21);
        let v0 = 0x2::table::borrow_mut<u64, VoucherCampaign>(&mut arg0.vouchers.campaigns, arg1);
        if (v0.closed) {
            return
        };
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.expires_at_ms, 23);
        v0.closed = true;
    }

    fun consume_tier_cap(arg0: &mut RerollPoolV2, arg1: u8, arg2: u64) {
        if (arg1 == 0) {
            assert!(arg0.vouchers.issued_25 + arg2 <= 150, 20);
            arg0.vouchers.issued_25 = arg0.vouchers.issued_25 + arg2;
        } else if (arg1 == 1) {
            assert!(arg0.vouchers.issued_50 + arg2 <= 100, 20);
            arg0.vouchers.issued_50 = arg0.vouchers.issued_50 + arg2;
        } else {
            assert!(arg1 == 2, 19);
            assert!(arg0.vouchers.issued_free + arg2 <= 100, 20);
            arg0.vouchers.issued_free = arg0.vouchers.issued_free + arg2;
        };
    }

    public fun consumed_count(arg0: &RerollPoolV2) : u64 {
        arg0.identities.consumed_count
    }

    public fun create(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 480, 4);
        assert!(arg4 != @0x0, 1);
        assert_hash(&arg6);
        assert_hash(&arg7);
        assert_selection_mode(arg8);
        let v0 = 0x2::table::new<u64, RotationRecord>(arg9);
        let v1 = RotationRecord{
            id                   : 1,
            status               : 0,
            selection_mode       : arg8,
            expected_remaining   : arg2,
            seeded               : 0,
            request_key          : arg6,
            request_payload_hash : arg7,
            selection_hash       : b"",
            manifest_hash        : b"",
            image_root_hash      : b"",
            activated_at_ms      : 0,
        };
        0x2::table::add<u64, RotationRecord>(&mut v0, 1, v1);
        let v2 = 0x2::table::new<vector<u8>, RotationRequestReceipt>(arg9);
        let v3 = RotationRequestReceipt{
            rotation_id  : 1,
            payload_hash : arg7,
        };
        0x2::table::add<vector<u8>, RotationRequestReceipt>(&mut v2, arg6, v3);
        let v4 = IdentityRegistry{
            bootstrap_receipts : 0x2::table::new<BootstrapKey, vector<u8>>(arg9),
            active_by_punk     : 0x2::table::new<u64, ActiveIdentityV2>(arg9),
            active_sources     : 0x2::table::new<u64, bool>(arg9),
            active_metadata    : 0x2::table::new<vector<u8>, bool>(arg9),
            active_art         : 0x2::table::new<vector<u8>, bool>(arg9),
            active_count       : 0,
            consumed_sources   : 0x2::table::new<u64, bool>(arg9),
            consumed_metadata  : 0x2::table::new<vector<u8>, bool>(arg9),
            consumed_art       : 0x2::table::new<vector<u8>, bool>(arg9),
            consumed_count     : 0,
            dead_sources       : 0x2::table::new<u64, bool>(arg9),
            dead_metadata      : 0x2::table::new<vector<u8>, bool>(arg9),
            dead_art           : 0x2::table::new<vector<u8>, bool>(arg9),
            dead_records       : 0x2::table::new<u64, DeadIdentityRecord>(arg9),
            dead_count         : 0,
            expected_v1_deaths : arg5,
            v1_history_count   : 0,
        };
        let v5 = VoucherRegistry{
            campaigns           : 0x2::table::new<u64, VoucherCampaign>(arg9),
            next_campaign_id    : 1,
            next_voucher_serial : 1,
            issued_25           : 0,
            issued_50           : 0,
            issued_free         : 0,
        };
        let v6 = RerollPoolV2{
            id                         : 0x2::object::new(arg9),
            version                    : 2,
            admin                      : 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap>(arg0),
            season                     : arg1,
            is_open                    : false,
            is_deprecated              : false,
            price                      : arg3,
            treasury                   : arg4,
            size                       : arg2,
            remaining                  : arg2,
            active_rotation_id         : 0,
            next_rotation_id           : 2,
            next_rotation_after_ms     : 0,
            resume_open_after_rotation : false,
            rotations                  : v0,
            rotation_requests          : v2,
            batch_receipts             : 0x2::table::new<BatchKey, vector<u8>>(arg9),
            active_registry            : 0x2::table::new<u64, PoolPieceV2>(arg9),
            shuffle                    : 0x2::table::new<u64, u64>(arg9),
            staging_rotation_id        : 1,
            staging_expected           : arg2,
            staging_seeded             : 0,
            staging_registry           : 0x2::table::new<u64, PoolPieceV2>(arg9),
            staging_sources            : 0x2::table::new<u64, bool>(arg9),
            staging_metadata           : 0x2::table::new<vector<u8>, bool>(arg9),
            staging_art                : 0x2::table::new<vector<u8>, bool>(arg9),
            identities                 : v4,
            vouchers                   : v5,
        };
        let v7 = RerollPoolV2Created{
            pool_id            : 0x2::object::id<RerollPoolV2>(&v6),
            season             : arg1,
            size               : arg2,
            price              : arg3,
            treasury           : arg4,
            expected_v1_deaths : arg5,
        };
        0x2::event::emit<RerollPoolV2Created>(v7);
        0x2::transfer::share_object<RerollPoolV2>(v6);
    }

    public fun create_campaign(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u16>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<u64>, arg11: vector<0x2::object::ID>, arg12: &0x2::clock::Clock) : u64 {
        assert_admin(arg0, arg1);
        assert_not_deprecated(arg1);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg12), 23);
        assert!(arg5 > 0, 20);
        let v0 = 0x1::vector::length<u16>(&arg6);
        assert!(0x1::vector::length<u8>(&arg7) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg8) == v0, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg9) == v0, 3);
        assert!(0x1::vector::length<u64>(&arg10) == v0, 3);
        assert!(0x1::vector::length<0x2::object::ID>(&arg11) == v0, 3);
        let v1 = 0x1::vector::empty<ConditionClause>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u16>(&arg6, v2);
            let v4 = *0x1::vector::borrow<u8>(&arg7, v2);
            assert!(v4 <= 10, 27);
            if (v2 > 0) {
                assert!(v3 >= 0, 27);
            };
            let v5 = ConditionClause{
                group     : v3,
                kind      : v4,
                key       : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v2)),
                value     : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg9, v2)),
                number    : *0x1::vector::borrow<u64>(&arg10, v2),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg11, v2),
            };
            0x1::vector::push_back<ConditionClause>(&mut v1, v5);
            v2 = v2 + 1;
        };
        let v6 = 0x1::bcs::to_bytes<vector<ConditionClause>>(&v1);
        let v7 = 0x2::hash::blake2b256(&v6);
        let v8 = if (arg2 == 2) {
            18446744073709551615
        } else {
            arg3
        };
        consume_tier_cap(arg1, arg2, arg5);
        let v9 = arg1.vouchers.next_campaign_id;
        arg1.vouchers.next_campaign_id = v9 + 1;
        let v10 = VoucherCampaign{
            id                : v9,
            tier              : arg2,
            discount_bps      : tier_bps(arg2),
            max_discount_mist : v8,
            expires_at_ms     : arg4,
            supply            : arg5,
            minted            : 0,
            redeemed          : 0,
            closed            : false,
            policy_hash       : v7,
            policy            : v1,
        };
        0x2::table::add<u64, VoucherCampaign>(&mut arg1.vouchers.campaigns, v9, v10);
        let v11 = VoucherCampaignCreated{
            pool_id     : 0x2::object::id<RerollPoolV2>(arg1),
            season      : arg1.season,
            campaign_id : v9,
            tier        : arg2,
            supply      : arg5,
            policy_hash : v7,
        };
        0x2::event::emit<VoucherCampaignCreated>(v11);
        v9
    }

    public fun dead_count(arg0: &RerollPoolV2) : u64 {
        arg0.identities.dead_count
    }

    public fun death(arg0: &RerollPoolV2, arg1: u64) : &DeadIdentityRecord {
        0x2::table::borrow<u64, DeadIdentityRecord>(&arg0.identities.dead_records, arg1)
    }

    public fun death_previous_source(arg0: &DeadIdentityRecord) : u64 {
        arg0.previous_identity.source_id
    }

    public fun death_punk_id(arg0: &DeadIdentityRecord) : 0x2::object::ID {
        arg0.punk_id
    }

    public fun death_punk_index(arg0: &DeadIdentityRecord) : u64 {
        arg0.punk_index
    }

    public fun death_replacement_source(arg0: &DeadIdentityRecord) : u64 {
        arg0.replacement_identity.source_id
    }

    public fun deprecate(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2) {
        assert_admin(arg0, arg1);
        arg1.is_open = false;
        arg1.is_deprecated = true;
    }

    fun draw_piece(arg0: &mut RerollPoolV2, arg1: &mut 0x2::random::RandomGenerator) : (u64, PoolPieceV2) {
        let v0 = arg0.remaining;
        let v1 = 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1);
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v1)
        } else {
            v1
        };
        let v3 = v0 - 1;
        let v4 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v3)
        } else {
            v3
        };
        if (v1 != v3) {
            if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.shuffle, v1) = v4;
            } else {
                0x2::table::add<u64, u64>(&mut arg0.shuffle, v1, v4);
            };
        };
        if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            0x2::table::remove<u64, u64>(&mut arg0.shuffle, v3);
        };
        arg0.remaining = v0 - 1;
        (v2, 0x2::table::remove<u64, PoolPieceV2>(&mut arg0.active_registry, v2))
    }

    fun finish_voucher(arg0: &mut RerollPoolV2, arg1: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: &mut MoshVoucher, arg3: u64, arg4: 0x2::object::ID) {
        arg2.used = true;
        arg2.used_for = 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1);
        arg2.redeemed_piece = 0x2::table::borrow<u64, ActiveIdentityV2>(&arg0.identities.active_by_punk, 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::index(arg1)).origin_pool_piece;
        0x2::table::borrow_mut<u64, VoucherCampaign>(&mut arg0.vouchers.campaigns, arg3).redeemed = 0x2::table::borrow<u64, VoucherCampaign>(&arg0.vouchers.campaigns, arg3).redeemed + 1;
        let v0 = calculate_discount(arg0.price, arg2.discount_bps, arg2.max_discount_mist);
        let v1 = MoshVoucherRedeemed{
            pool_id       : 0x2::object::id<RerollPoolV2>(arg0),
            season        : arg0.season,
            campaign_id   : arg3,
            voucher_id    : arg4,
            punk_id       : 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1),
            discount_bps  : arg2.discount_bps,
            discount_mist : v0,
            amount_paid   : arg0.price - v0,
        };
        0x2::event::emit<MoshVoucherRedeemed>(v1);
    }

    public fun is_open(arg0: &RerollPoolV2) : bool {
        arg0.is_open
    }

    public fun issue_vouchers_batch(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: vector<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, VoucherCampaign>(&arg1.vouchers.campaigns, arg2), 21);
        let v0 = 0x2::object::id<RerollPoolV2>(arg1);
        let v1 = arg1.season;
        let v2 = 0x2::table::borrow<u64, VoucherCampaign>(&arg1.vouchers.campaigns, arg2);
        let v3 = v2.max_discount_mist;
        let v4 = v2.expires_at_ms;
        let v5 = v2.minted;
        assert!(!v2.closed, 22);
        assert!(0x2::clock::timestamp_ms(arg4) < v4, 23);
        assert!(v5 + 0x1::vector::length<address>(&arg3) <= v2.supply, 20);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg3)) {
            let v7 = arg1.vouchers.next_voucher_serial;
            arg1.vouchers.next_voucher_serial = v7 + 1;
            let v8 = MoshVoucher{
                id                : 0x2::object::new(arg5),
                pool_id           : v0,
                season            : v1,
                campaign_id       : arg2,
                serial            : v7,
                discount_bps      : v2.discount_bps,
                max_discount_mist : v3,
                expires_at_ms     : v4,
                used              : false,
                used_for          : 0x2::object::id_from_address(@0x0),
                redeemed_piece    : 0,
            };
            let v9 = *0x1::vector::borrow<address>(&arg3, v6);
            let v10 = MoshVoucherIssued{
                pool_id     : v0,
                season      : v1,
                campaign_id : arg2,
                voucher_id  : 0x2::object::id<MoshVoucher>(&v8),
                serial      : v7,
                recipient   : v9,
            };
            0x2::event::emit<MoshVoucherIssued>(v10);
            0x2::transfer::public_transfer<MoshVoucher>(v8, v9);
            v6 = v6 + 1;
        };
        0x2::table::borrow_mut<u64, VoucherCampaign>(&mut arg1.vouchers.campaigns, arg2).minted = v5 + 0x1::vector::length<address>(&arg3);
    }

    public fun issued_25(arg0: &RerollPoolV2) : u64 {
        arg0.vouchers.issued_25
    }

    public fun issued_50(arg0: &RerollPoolV2) : u64 {
        arg0.vouchers.issued_50
    }

    public fun issued_free(arg0: &RerollPoolV2) : u64 {
        arg0.vouchers.issued_free
    }

    fun policy_matches(arg0: &RerollPoolV2, arg1: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: u8, arg3: &vector<ConditionClause>) : bool {
        if (0x1::vector::is_empty<ConditionClause>(arg3)) {
            return true
        };
        let v0 = 0x2::table::borrow<u64, ActiveIdentityV2>(&arg0.identities.active_by_punk, 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::index(arg1));
        let v1 = 0x1::vector::borrow<ConditionClause>(arg3, 0).group;
        let v2 = true;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ConditionClause>(arg3)) {
            let v4 = 0x1::vector::borrow<ConditionClause>(arg3, v3);
            if (v4.group != v1) {
                if (v2) {
                    return true
                };
                v1 = v4.group;
                v2 = true;
            };
            let v5 = v2 && clause_matches(arg1, v0, arg2, v4);
            v2 = v5;
            v3 = v3 + 1;
        };
        v2
    }

    public fun price(arg0: &RerollPoolV2) : u64 {
        arg0.price
    }

    public fun register_active_batch(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>) {
        assert_admin(arg0, arg1);
        assert_bootstrap(arg1);
        let v0 = ActiveBootstrapPayload{
            batch_index      : arg2,
            punk_ids         : arg3,
            punk_indices     : arg4,
            source_ids       : arg5,
            metadata_hashes  : arg6,
            art_hashes       : arg7,
            origin_seasons   : arg8,
            origin_rotations : arg9,
            origin_pieces    : arg10,
            reroll_counts    : arg11,
        };
        let v1 = 0x1::bcs::to_bytes<ActiveBootstrapPayload>(&v0);
        let v2 = BootstrapKey{
            kind        : 1,
            batch_index : arg2,
        };
        if (0x2::table::contains<BootstrapKey, vector<u8>>(&arg1.identities.bootstrap_receipts, v2)) {
            assert!(*0x2::table::borrow<BootstrapKey, vector<u8>>(&arg1.identities.bootstrap_receipts, v2) == 0x2::hash::blake2b256(&v1), 17);
            return
        };
        let v3 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(0x1::vector::length<u64>(&arg4) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg5) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg8) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg9) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg10) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg11) == v3, 3);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = *0x1::vector::borrow<u64>(&arg4, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg5, v4);
            let v7 = *0x1::vector::borrow<vector<u8>>(&arg6, v4);
            let v8 = *0x1::vector::borrow<vector<u8>>(&arg7, v4);
            assert!(v5 > 0 && v5 <= 480, 4);
            assert_hash(&v7);
            assert_hash(&v8);
            assert!(!0x2::table::contains<u64, ActiveIdentityV2>(&arg1.identities.active_by_punk, v5), 5);
            let v9 = if (!0x2::table::contains<u64, bool>(&arg1.identities.dead_sources, v6)) {
                if (!0x2::table::contains<vector<u8>, bool>(&arg1.identities.dead_metadata, v7)) {
                    !0x2::table::contains<vector<u8>, bool>(&arg1.identities.dead_art, v8)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v9, 6);
            assert_identity_keys_free(&arg1.identities.active_sources, &arg1.identities.active_metadata, &arg1.identities.active_art, v6, &v7, &v8);
            0x2::table::add<u64, bool>(&mut arg1.identities.active_sources, v6, true);
            0x2::table::add<vector<u8>, bool>(&mut arg1.identities.active_metadata, v7, true);
            0x2::table::add<vector<u8>, bool>(&mut arg1.identities.active_art, v8, true);
            let v10 = IdentityV2{
                source_id          : v6,
                metadata_hash      : v7,
                canonical_art_hash : v8,
            };
            let v11 = ActiveIdentityV2{
                punk_id            : *0x1::vector::borrow<0x2::object::ID>(&arg3, v4),
                identity           : v10,
                origin_season      : *0x1::vector::borrow<u64>(&arg8, v4),
                origin_rotation_id : *0x1::vector::borrow<u64>(&arg9, v4),
                origin_pool_piece  : *0x1::vector::borrow<u64>(&arg10, v4),
                reroll_count       : *0x1::vector::borrow<u64>(&arg11, v4),
            };
            0x2::table::add<u64, ActiveIdentityV2>(&mut arg1.identities.active_by_punk, v5, v11);
            arg1.identities.active_count = arg1.identities.active_count + 1;
            v4 = v4 + 1;
        };
        assert!(arg1.identities.active_count <= 480, 29);
        0x2::table::add<BootstrapKey, vector<u8>>(&mut arg1.identities.bootstrap_receipts, v2, 0x2::hash::blake2b256(&v1));
    }

    public fun register_v1_history_batch(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: vector<u64>, arg12: vector<address>) {
        assert_admin(arg0, arg1);
        assert_bootstrap(arg1);
        let v0 = HistoryBootstrapPayload{
            batch_index          : arg2,
            punk_ids             : arg3,
            punk_indices         : arg4,
            previous_sources     : arg5,
            previous_metadata    : arg6,
            previous_art         : arg7,
            replacement_sources  : arg8,
            replacement_metadata : arg9,
            replacement_art      : arg10,
            pool_pieces          : arg11,
            actors               : arg12,
        };
        let v1 = 0x1::bcs::to_bytes<HistoryBootstrapPayload>(&v0);
        let v2 = BootstrapKey{
            kind        : 0,
            batch_index : arg2,
        };
        if (0x2::table::contains<BootstrapKey, vector<u8>>(&arg1.identities.bootstrap_receipts, v2)) {
            assert!(*0x2::table::borrow<BootstrapKey, vector<u8>>(&arg1.identities.bootstrap_receipts, v2) == 0x2::hash::blake2b256(&v1), 17);
            return
        };
        let v3 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(0x1::vector::length<u64>(&arg4) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg5) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg6) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg8) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg9) == v3, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg10) == v3, 3);
        assert!(0x1::vector::length<u64>(&arg11) == v3, 3);
        assert!(0x1::vector::length<address>(&arg12) == v3, 3);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = IdentityV2{
                source_id          : *0x1::vector::borrow<u64>(&arg5, v4),
                metadata_hash      : *0x1::vector::borrow<vector<u8>>(&arg6, v4),
                canonical_art_hash : *0x1::vector::borrow<vector<u8>>(&arg7, v4),
            };
            let v6 = IdentityV2{
                source_id          : *0x1::vector::borrow<u64>(&arg8, v4),
                metadata_hash      : *0x1::vector::borrow<vector<u8>>(&arg9, v4),
                canonical_art_hash : *0x1::vector::borrow<vector<u8>>(&arg10, v4),
            };
            assert_identity_hashes(&v5);
            assert_identity_hashes(&v6);
            add_dead_identity(arg1, &v5);
            add_consumed_identity(arg1, &v6);
            let v7 = arg1.identities.dead_count;
            let v8 = DeadIdentityRecord{
                death_id             : v7,
                punk_id              : *0x1::vector::borrow<0x2::object::ID>(&arg3, v4),
                punk_index           : *0x1::vector::borrow<u64>(&arg4, v4),
                previous_identity    : v5,
                replacement_identity : v6,
                season               : 1,
                rotation_id          : 1,
                pool_piece           : *0x1::vector::borrow<u64>(&arg11, v4),
                actor                : *0x1::vector::borrow<address>(&arg12, v4),
            };
            0x2::table::add<u64, DeadIdentityRecord>(&mut arg1.identities.dead_records, v7, v8);
            arg1.identities.dead_count = v7 + 1;
            arg1.identities.v1_history_count = arg1.identities.v1_history_count + 1;
            let v9 = DeadIdentityRecorded{
                pool_id : 0x2::object::id<RerollPoolV2>(arg1),
                season  : 1,
                record  : v8,
            };
            0x2::event::emit<DeadIdentityRecorded>(v9);
            v4 = v4 + 1;
        };
        assert!(arg1.identities.v1_history_count <= arg1.identities.expected_v1_deaths, 28);
        0x2::table::add<BootstrapKey, vector<u8>>(&mut arg1.identities.bootstrap_receipts, v2, 0x2::hash::blake2b256(&v1));
    }

    public fun remaining(arg0: &RerollPoolV2) : u64 {
        arg0.remaining
    }

    fun remove_active_identity(arg0: &mut RerollPoolV2, arg1: &IdentityV2) {
        0x2::table::remove<u64, bool>(&mut arg0.identities.active_sources, arg1.source_id);
        0x2::table::remove<vector<u8>, bool>(&mut arg0.identities.active_metadata, arg1.metadata_hash);
        0x2::table::remove<vector<u8>, bool>(&mut arg0.identities.active_art, arg1.canonical_art_hash);
    }

    entry fun reroll(arg0: &mut RerollPoolV2, arg1: &mut 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        reroll_apply(arg0, arg1, arg2, 0, 0, 0, 0x2::object::id_from_address(@0x0), 0, arg3, arg4);
    }

    fun reroll_apply(arg0: &mut RerollPoolV2, arg1: &mut 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u16, arg4: u64, arg5: u8, arg6: 0x2::object::ID, arg7: u64, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert_not_deprecated(arg0);
        assert!(arg0.is_open, 9);
        assert!(arg0.remaining > 0, 10);
        let v0 = 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::index(arg1);
        assert!(v0 > 0, 4);
        assert!(0x2::table::contains<u64, ActiveIdentityV2>(&arg0.identities.active_by_punk, v0), 12);
        let v1 = *0x2::table::borrow<u64, ActiveIdentityV2>(&arg0.identities.active_by_punk, v0);
        assert!(v1.punk_id == 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1), 12);
        let v2 = 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::attributes(arg1));
        assert!(0x2::hash::blake2b256(&v2) == v1.identity.metadata_hash, 13);
        let v3 = calculate_discount(arg0.price, arg3, arg4);
        let v4 = arg0.price - v3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 11);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg9), arg0.treasury);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
        };
        let v5 = 0x2::random::new_generator(arg8, arg9);
        let v6 = &mut v5;
        let (v7, v8) = draw_piece(arg0, v6);
        let v9 = v8;
        let v10 = IdentityV2{
            source_id          : v9.source_id,
            metadata_hash      : v9.metadata_hash,
            canonical_art_hash : v9.canonical_art_hash,
        };
        transition_identity(arg0, v0, v1, v10, v7 + 1, 0x2::tx_context::sender(arg9));
        0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::replace_attributes_from_mosh(arg1, v9.attributes);
        let v11 = PunkRerolledV2{
            pool_id              : 0x2::object::id<RerollPoolV2>(arg0),
            season               : arg0.season,
            rotation_id          : arg0.active_rotation_id,
            pool_piece           : v7 + 1,
            source_id            : v10.source_id,
            object_id            : 0x2::object::id<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1),
            number               : 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::number(arg1),
            index                : v0,
            owner                : 0x2::tx_context::sender(arg9),
            custody              : arg5,
            death_id             : arg0.identities.dead_count - 1,
            previous_identity    : v1.identity,
            replacement_identity : v10,
            listed_price         : arg0.price,
            discount_bps         : arg3,
            discount_mist        : v3,
            amount_paid          : v4,
            voucher_id           : arg6,
            campaign_id          : arg7,
        };
        0x2::event::emit<PunkRerolledV2>(v11);
    }

    entry fun reroll_kiosk(arg0: &mut RerollPoolV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, arg2, arg3);
        let v2 = v0;
        let v3 = &mut v2;
        reroll_apply(arg0, v3, arg4, 0, 0, 1, 0x2::object::id_from_address(@0x0), 0, arg5, arg6);
        0x2::kiosk::return_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, v2, v1);
    }

    entry fun reroll_kiosk_with_voucher(arg0: &mut RerollPoolV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut MoshVoucher, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, arg2, arg3);
        let v2 = v0;
        let (v3, v4, v5) = validate_voucher(arg0, &v2, arg4, 1, arg6);
        let v6 = 0x2::object::id<MoshVoucher>(arg4);
        let v7 = &mut v2;
        reroll_apply(arg0, v7, arg5, v4, v5, 1, v6, v3, arg7, arg8);
        finish_voucher(arg0, &v2, arg4, v3, v6);
        0x2::kiosk::return_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, v2, v1);
    }

    entry fun reroll_personal_kiosk(arg0: &mut RerollPoolV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3);
        let v2 = v0;
        let v3 = &mut v2;
        reroll_apply(arg0, v3, arg4, 0, 0, 2, 0x2::object::id_from_address(@0x0), 0, arg5, arg6);
        0x2::kiosk::return_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, v2, v1);
    }

    entry fun reroll_personal_kiosk_with_voucher(arg0: &mut RerollPoolV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &mut MoshVoucher, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::borrow_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg3);
        let v2 = v0;
        let (v3, v4, v5) = validate_voucher(arg0, &v2, arg4, 2, arg6);
        let v6 = 0x2::object::id<MoshVoucher>(arg4);
        let v7 = &mut v2;
        reroll_apply(arg0, v7, arg5, v4, v5, 2, v6, v3, arg7, arg8);
        finish_voucher(arg0, &v2, arg4, v3, v6);
        0x2::kiosk::return_val<0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk>(arg1, v2, v1);
    }

    entry fun reroll_with_voucher(arg0: &mut RerollPoolV2, arg1: &mut 0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: &mut MoshVoucher, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = validate_voucher(arg0, arg1, arg2, 0, arg4);
        let v3 = 0x2::object::id<MoshVoucher>(arg2);
        reroll_apply(arg0, arg1, arg3, v1, v2, 0, v3, v0, arg5, arg6);
        finish_voucher(arg0, arg1, arg2, v0, v3);
    }

    public fun rotation(arg0: &RerollPoolV2, arg1: u64) : &RotationRecord {
        0x2::table::borrow<u64, RotationRecord>(&arg0.rotations, arg1)
    }

    public fun seal_rotation(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_admin(arg0, arg1);
        assert_hash(&arg3);
        assert_hash(&arg4);
        assert_hash(&arg5);
        assert!(0x2::table::contains<u64, RotationRecord>(&arg1.rotations, arg2), 7);
        let v0 = 0x2::table::borrow_mut<u64, RotationRecord>(&mut arg1.rotations, arg2);
        if (v0.status == 1 || v0.status == 2) {
            let v1 = if (v0.selection_hash == arg3) {
                if (v0.manifest_hash == arg4) {
                    v0.image_root_hash == arg5
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 16);
            return
        };
        assert!(arg1.staging_rotation_id == arg2, 7);
        assert!(arg1.staging_seeded == arg1.staging_expected, 8);
        assert!(v0.status == 0, 7);
        v0.status = 1;
        v0.selection_hash = arg3;
        v0.manifest_hash = arg4;
        v0.image_root_hash = arg5;
        let v2 = PoolRotationV2Sealed{
            pool_id         : 0x2::object::id<RerollPoolV2>(arg1),
            season          : arg1.season,
            rotation_id     : arg2,
            selection_hash  : arg3,
            manifest_hash   : arg4,
            image_root_hash : arg5,
        };
        0x2::event::emit<PoolRotationV2Sealed>(v2);
    }

    public fun season(arg0: &RerollPoolV2) : u64 {
        arg0.season
    }

    public fun seed_rotation_batch(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>) {
        assert_admin(arg0, arg1);
        assert_not_deprecated(arg1);
        assert!(arg1.staging_rotation_id == arg2, 7);
        let v0 = SeedBatchPayload{
            rotation_id  : arg2,
            batch_index  : arg3,
            positions    : arg4,
            source_ids   : arg5,
            counts       : arg6,
            keys_flat    : arg7,
            values_flat  : arg8,
            art_hashes   : arg9,
            image_hashes : arg10,
        };
        let v1 = 0x1::bcs::to_bytes<SeedBatchPayload>(&v0);
        let v2 = 0x2::hash::blake2b256(&v1);
        let v3 = BatchKey{
            rotation_id : arg2,
            batch_index : arg3,
        };
        if (0x2::table::contains<BatchKey, vector<u8>>(&arg1.batch_receipts, v3)) {
            assert!(*0x2::table::borrow<BatchKey, vector<u8>>(&arg1.batch_receipts, v3) == v2, 17);
            return
        };
        let v4 = 0x1::vector::length<u64>(&arg4);
        assert!(0x1::vector::length<u64>(&arg5) == v4, 3);
        assert!(0x1::vector::length<u64>(&arg6) == v4, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg9) == v4, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg10) == v4, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == 0x1::vector::length<vector<u8>>(&arg8), 3);
        let v5 = 0;
        let v6 = 0;
        while (v5 < v4) {
            let v7 = *0x1::vector::borrow<u64>(&arg4, v5);
            let v8 = *0x1::vector::borrow<u64>(&arg5, v5);
            let v9 = *0x1::vector::borrow<u64>(&arg6, v5);
            let v10 = *0x1::vector::borrow<vector<u8>>(&arg9, v5);
            let v11 = *0x1::vector::borrow<vector<u8>>(&arg10, v5);
            assert!(v7 < arg1.staging_expected, 4);
            assert!(!0x2::table::contains<u64, PoolPieceV2>(&arg1.staging_registry, v7), 31);
            assert_hash(&v10);
            assert_hash(&v11);
            let v12 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v13 = 0;
            while (v13 < v9) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v12, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v6 + v13)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v6 + v13)));
                v13 = v13 + 1;
            };
            v6 = v6 + v9;
            let v14 = 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&v12);
            let v15 = 0x2::hash::blake2b256(&v14);
            assert_candidate_available(arg1, v8, &v15, &v10);
            assert!(!0x2::table::contains<u64, bool>(&arg1.staging_sources, v8), 5);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.staging_metadata, v15), 5);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.staging_art, v10), 5);
            0x2::table::add<u64, bool>(&mut arg1.staging_sources, v8, true);
            0x2::table::add<vector<u8>, bool>(&mut arg1.staging_metadata, v15, true);
            0x2::table::add<vector<u8>, bool>(&mut arg1.staging_art, v10, true);
            let v16 = PoolPieceV2{
                source_id          : v8,
                attributes         : v12,
                metadata_hash      : v15,
                canonical_art_hash : v10,
                image_hash         : v11,
            };
            0x2::table::add<u64, PoolPieceV2>(&mut arg1.staging_registry, v7, v16);
            arg1.staging_seeded = arg1.staging_seeded + 1;
            v5 = v5 + 1;
        };
        assert!(v6 == 0x1::vector::length<vector<u8>>(&arg7), 3);
        assert!(arg1.staging_seeded <= arg1.staging_expected, 8);
        0x2::table::add<BatchKey, vector<u8>>(&mut arg1.batch_receipts, v3, v2);
        0x2::table::borrow_mut<u64, RotationRecord>(&mut arg1.rotations, arg2).seeded = arg1.staging_seeded;
        let v17 = PoolRotationV2SeedBatch{
            pool_id      : 0x2::object::id<RerollPoolV2>(arg1),
            season       : arg1.season,
            rotation_id  : arg2,
            batch_index  : arg3,
            batch_hash   : v2,
            seeded_total : arg1.staging_seeded,
        };
        0x2::event::emit<PoolRotationV2SeedBatch>(v17);
    }

    public fun set_open(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: bool) {
        assert_admin(arg0, arg1);
        assert_not_deprecated(arg1);
        if (arg2) {
            assert!(arg1.active_rotation_id != 0, 8);
            assert!(arg1.identities.active_count == arg1.size, 29);
            assert!(arg1.identities.v1_history_count == arg1.identities.expected_v1_deaths, 28);
            assert!(arg1.staging_rotation_id == 0, 15);
            assert!(arg1.remaining > 0, 10);
        };
        arg1.is_open = arg2;
    }

    public fun set_price(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: u64) {
        assert_admin(arg0, arg1);
        arg1.price = arg2;
    }

    public fun set_treasury(arg0: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::AdminCap, arg1: &mut RerollPoolV2, arg2: address) {
        assert_admin(arg0, arg1);
        assert!(arg2 != @0x0, 1);
        arg1.treasury = arg2;
    }

    public fun staging_rotation_id(arg0: &RerollPoolV2) : u64 {
        arg0.staging_rotation_id
    }

    public fun staging_seeded(arg0: &RerollPoolV2) : u64 {
        arg0.staging_seeded
    }

    fun tier_bps(arg0: u8) : u16 {
        if (arg0 == 0) {
            2500
        } else if (arg0 == 1) {
            5000
        } else {
            assert!(arg0 == 2, 19);
            10000
        }
    }

    fun transition_identity(arg0: &mut RerollPoolV2, arg1: u64, arg2: ActiveIdentityV2, arg3: IdentityV2, arg4: u64, arg5: address) {
        remove_active_identity(arg0, &arg2.identity);
        add_dead_identity(arg0, &arg2.identity);
        add_consumed_identity(arg0, &arg3);
        add_active_identity(arg0, &arg3);
        let v0 = arg0.identities.dead_count;
        let v1 = DeadIdentityRecord{
            death_id             : v0,
            punk_id              : arg2.punk_id,
            punk_index           : arg1,
            previous_identity    : arg2.identity,
            replacement_identity : arg3,
            season               : arg0.season,
            rotation_id          : arg0.active_rotation_id,
            pool_piece           : arg4,
            actor                : arg5,
        };
        0x2::table::add<u64, DeadIdentityRecord>(&mut arg0.identities.dead_records, v0, v1);
        arg0.identities.dead_count = v0 + 1;
        let v2 = ActiveIdentityV2{
            punk_id            : arg2.punk_id,
            identity           : arg3,
            origin_season      : arg0.season,
            origin_rotation_id : arg0.active_rotation_id,
            origin_pool_piece  : arg4,
            reroll_count       : arg2.reroll_count + 1,
        };
        *0x2::table::borrow_mut<u64, ActiveIdentityV2>(&mut arg0.identities.active_by_punk, arg1) = v2;
        let v3 = DeadIdentityRecorded{
            pool_id : 0x2::object::id<RerollPoolV2>(arg0),
            season  : arg0.season,
            record  : v1,
        };
        0x2::event::emit<DeadIdentityRecorded>(v3);
    }

    fun validate_voucher(arg0: &RerollPoolV2, arg1: &0xd3f2fa865c3d692066e87f12291a7e2fbd3281747d4325ef044250a9da629e85::spunks::Punk, arg2: &MoshVoucher, arg3: u8, arg4: &0x2::clock::Clock) : (u64, u16, u64) {
        assert!(!arg2.used, 24);
        assert!(arg2.pool_id == 0x2::object::id<RerollPoolV2>(arg0), 25);
        assert!(arg2.season == arg0.season, 25);
        assert!(0x2::table::contains<u64, VoucherCampaign>(&arg0.vouchers.campaigns, arg2.campaign_id), 21);
        let v0 = 0x2::table::borrow<u64, VoucherCampaign>(&arg0.vouchers.campaigns, arg2.campaign_id);
        assert!(!v0.closed, 22);
        assert!(0x2::clock::timestamp_ms(arg4) < v0.expires_at_ms, 23);
        assert!(arg2.expires_at_ms == v0.expires_at_ms, 25);
        assert!(arg2.discount_bps == v0.discount_bps, 25);
        assert!(arg2.max_discount_mist == v0.max_discount_mist, 25);
        assert!(policy_matches(arg0, arg1, arg3, &v0.policy), 26);
        (v0.id, v0.discount_bps, v0.max_discount_mist)
    }

    public fun version(arg0: &RerollPoolV2) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

