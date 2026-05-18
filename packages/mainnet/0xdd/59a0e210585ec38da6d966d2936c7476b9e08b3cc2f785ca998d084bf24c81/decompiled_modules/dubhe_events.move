module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events {
    struct Dubhe_Store_SetRecord has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
        value: vector<vector<u8>>,
    }

    struct Dubhe_Store_SetField has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
        field_name: vector<u8>,
        field_value: vector<u8>,
    }

    struct Dubhe_Store_DeleteRecord has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
    }

    struct Dubhe_Store_DeleteField has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: 0x1::ascii::String,
        key: vector<vector<u8>>,
        field_name: vector<u8>,
    }

    struct DappCreated has copy, drop {
        dapp_key: 0x1::ascii::String,
        admin: address,
        created_at: u64,
        dapp_storage_id: address,
    }

    struct DappPausedChanged has copy, drop {
        dapp_key: 0x1::ascii::String,
        paused: bool,
        updated_by: address,
    }

    struct WritesSettled has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: address,
        writes: u64,
        bytes: u256,
        free_cost: u256,
        paid_cost: u256,
    }

    struct SettlementSkipped has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: address,
        unsettled_writes: u64,
        unsettled_bytes: u256,
    }

    struct SettlementPartial has copy, drop {
        dapp_key: 0x1::ascii::String,
        account: address,
        settled_writes: u64,
        settled_bytes: u256,
        remaining_writes: u64,
        remaining_bytes: u256,
        free_cost: u256,
        paid_cost: u256,
    }

    struct FreeCreditGranted has copy, drop {
        dapp_key: 0x1::ascii::String,
        amount: u256,
        expires_at: u64,
        granted_by: address,
    }

    struct FreeCreditRevoked has copy, drop {
        dapp_key: 0x1::ascii::String,
        amount_remaining: u256,
        revoked_by: address,
    }

    struct FreeCreditExtended has copy, drop {
        dapp_key: 0x1::ascii::String,
        new_expires_at: u64,
        extended_by: address,
    }

    struct SessionActivated has copy, drop {
        dapp_key: 0x1::ascii::String,
        canonical: address,
        session_wallet: address,
        expires_at: u64,
    }

    struct SessionDeactivated has copy, drop {
        dapp_key: 0x1::ascii::String,
        canonical: address,
        session_key: address,
    }

    struct CreditRecharged has copy, drop {
        dapp_key: 0x1::ascii::String,
        from: address,
        coin_type: 0x1::ascii::String,
        amount: u256,
    }

    struct FeeUpdated has copy, drop {
        new_base_fee: u256,
        new_bytes_fee: u256,
        at_ms: u64,
    }

    struct FeeUpdateScheduled has copy, drop {
        pending_base_fee: u256,
        pending_bytes_fee: u256,
        effective_at_ms: u64,
    }

    struct CoinTypeChangeProposed has copy, drop {
        new_coin_type: 0x1::ascii::String,
        effective_at_ms: u64,
    }

    struct CoinTypeChanged has copy, drop {
        new_coin_type: 0x1::ascii::String,
    }

    struct DappRevenueWithdrawn has copy, drop {
        dapp_key: 0x1::ascii::String,
        admin: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SettlementModeChanged has copy, drop {
        dapp_key: 0x1::ascii::String,
        old_mode: u8,
        new_mode: u8,
    }

    struct DappRevenueShareSet has copy, drop {
        dapp_key: 0x1::ascii::String,
        new_bps: u64,
    }

    struct DefaultRevenueShareUpdated has copy, drop {
        new_bps: u64,
    }

    struct DappUpgraded has copy, drop {
        dapp_key: 0x1::ascii::String,
        new_package_id: address,
        new_version: u32,
        admin: address,
    }

    struct FrameworkMaxWriteLimitUpdated has copy, drop {
        new_limit: u64,
        admin: address,
    }

    struct DefaultFreeCreditUpdated has copy, drop {
        new_amount: u256,
        new_duration_ms: u64,
        updated_by: address,
    }

    struct UserWriteLimitSynced has copy, drop {
        dapp_key: 0x1::ascii::String,
        owner: address,
        new_limit: u64,
    }

    struct ItemListed has copy, drop {
        dapp_key: 0x1::ascii::String,
        listing_id: address,
        seller: address,
        record_type: vector<u8>,
        record_key: vector<vector<u8>>,
        field_names: vector<vector<u8>>,
        record_data: vector<vector<u8>>,
        price: u64,
        coin_type: 0x1::ascii::String,
        is_fungible: bool,
        listed_until: 0x1::option::Option<u64>,
    }

    struct MarketplaceFeeSettled has copy, drop {
        dapp_key: 0x1::ascii::String,
        listing_id: address,
        coin_type: 0x1::ascii::String,
        total_fee: u64,
        treasury_amount: u64,
        dapp_amount: u64,
    }

    struct ItemSold has copy, drop {
        dapp_key: 0x1::ascii::String,
        listing_id: address,
        buyer: address,
        seller: address,
        record_type: vector<u8>,
        price: u64,
        coin_type: 0x1::ascii::String,
        is_fungible: bool,
    }

    struct ListingCancelled has copy, drop {
        dapp_key: 0x1::ascii::String,
        listing_id: address,
        seller: address,
        is_fungible: bool,
    }

    struct ListingExpired has copy, drop {
        dapp_key: 0x1::ascii::String,
        listing_id: address,
        seller: address,
        is_fungible: bool,
    }

    struct Dubhe_UserStorage_Created has copy, drop {
        dapp_key: 0x1::ascii::String,
        canonical_owner: address,
        user_storage_id: address,
    }

    struct Dubhe_Object_Created has copy, drop {
        dapp_key: 0x1::ascii::String,
        object_type: vector<u8>,
        object_id: address,
        entity_id: vector<u8>,
    }

    struct Dubhe_Object_Destroyed has copy, drop {
        dapp_key: 0x1::ascii::String,
        object_type: vector<u8>,
        object_id: address,
        entity_id: vector<u8>,
    }

    struct Dubhe_Object_SetField has copy, drop {
        dapp_key: 0x1::ascii::String,
        object_type: vector<u8>,
        object_id: address,
        field_name: vector<u8>,
        field_value: vector<u8>,
    }

    struct Dubhe_Object_DeleteField has copy, drop {
        dapp_key: 0x1::ascii::String,
        object_type: vector<u8>,
        object_id: address,
        field_name: vector<u8>,
    }

    struct Dubhe_Scene_Created has copy, drop {
        dapp_key: 0x1::ascii::String,
        scene_type: vector<u8>,
        scene_id: address,
        authorization_kind: vector<u8>,
        authorized_permit_id: 0x1::option::Option<address>,
    }

    struct Dubhe_Scene_Destroyed has copy, drop {
        dapp_key: 0x1::ascii::String,
        scene_type: vector<u8>,
        scene_id: address,
        authorized_permit_id: 0x1::option::Option<address>,
    }

    struct Dubhe_Scene_SetField has copy, drop {
        dapp_key: 0x1::ascii::String,
        scene_type: vector<u8>,
        scene_id: address,
        field_name: vector<u8>,
        field_value: vector<u8>,
    }

    struct Dubhe_Scene_DeleteField has copy, drop {
        dapp_key: 0x1::ascii::String,
        scene_type: vector<u8>,
        scene_id: address,
        field_name: vector<u8>,
    }

    struct Dubhe_ScenePermit_Created has copy, drop {
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        permit_id: address,
        expires_at: 0x1::option::Option<u64>,
        invites_expire_at: 0x1::option::Option<u64>,
        max_participants: 0x1::option::Option<u64>,
        participant_count: u64,
    }

    struct Dubhe_ScenePermit_Accept has copy, drop {
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        permit_id: address,
        participant: address,
    }

    struct Dubhe_ScenePermit_Join has copy, drop {
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        permit_id: address,
        participant: address,
    }

    struct Dubhe_ScenePermit_Leave has copy, drop {
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        permit_id: address,
        participant: address,
    }

    struct Dubhe_ScenePermit_Expire has copy, drop {
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        permit_id: address,
    }

    struct Dubhe_Marketplace_FeeUpdated has copy, drop {
        fee_bps: u64,
    }

    struct DappFeeStateUpdated has copy, drop {
        dapp_key: 0x1::ascii::String,
        base_fee_per_write: u256,
        bytes_fee_per_byte: u256,
        free_credit: u256,
        credit_pool: u256,
        total_settled: u256,
    }

    struct DappRevenueStateUpdated has copy, drop {
        dapp_key: 0x1::ascii::String,
        dapp_revenue: u64,
        coin_type: 0x1::ascii::String,
    }

    public(friend) fun emit_coin_type_change_proposed(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = CoinTypeChangeProposed{
            new_coin_type   : arg0,
            effective_at_ms : arg1,
        };
        0x2::event::emit<CoinTypeChangeProposed>(v0);
    }

    public(friend) fun emit_coin_type_changed(arg0: 0x1::ascii::String) {
        let v0 = CoinTypeChanged{new_coin_type: arg0};
        0x2::event::emit<CoinTypeChanged>(v0);
    }

    public(friend) fun emit_credit_recharged(arg0: 0x1::ascii::String, arg1: address, arg2: 0x1::ascii::String, arg3: u256) {
        let v0 = CreditRecharged{
            dapp_key  : arg0,
            from      : arg1,
            coin_type : arg2,
            amount    : arg3,
        };
        0x2::event::emit<CreditRecharged>(v0);
    }

    public(friend) fun emit_dapp_created(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: address) {
        let v0 = DappCreated{
            dapp_key        : arg0,
            admin           : arg1,
            created_at      : arg2,
            dapp_storage_id : arg3,
        };
        0x2::event::emit<DappCreated>(v0);
    }

    public(friend) fun emit_dapp_fee_state_updated(arg0: 0x1::ascii::String, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = DappFeeStateUpdated{
            dapp_key           : arg0,
            base_fee_per_write : arg1,
            bytes_fee_per_byte : arg2,
            free_credit        : arg3,
            credit_pool        : arg4,
            total_settled      : arg5,
        };
        0x2::event::emit<DappFeeStateUpdated>(v0);
    }

    public(friend) fun emit_dapp_paused_changed(arg0: 0x1::ascii::String, arg1: bool, arg2: address) {
        let v0 = DappPausedChanged{
            dapp_key   : arg0,
            paused     : arg1,
            updated_by : arg2,
        };
        0x2::event::emit<DappPausedChanged>(v0);
    }

    public(friend) fun emit_dapp_revenue_share_set(arg0: 0x1::ascii::String, arg1: u64) {
        let v0 = DappRevenueShareSet{
            dapp_key : arg0,
            new_bps  : arg1,
        };
        0x2::event::emit<DappRevenueShareSet>(v0);
    }

    public(friend) fun emit_dapp_revenue_state_updated(arg0: 0x1::ascii::String, arg1: u64, arg2: 0x1::ascii::String) {
        let v0 = DappRevenueStateUpdated{
            dapp_key     : arg0,
            dapp_revenue : arg1,
            coin_type    : arg2,
        };
        0x2::event::emit<DappRevenueStateUpdated>(v0);
    }

    public(friend) fun emit_dapp_revenue_withdrawn(arg0: 0x1::ascii::String, arg1: address, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = DappRevenueWithdrawn{
            dapp_key  : arg0,
            admin     : arg1,
            coin_type : arg2,
            amount    : arg3,
        };
        0x2::event::emit<DappRevenueWithdrawn>(v0);
    }

    public(friend) fun emit_dapp_upgraded(arg0: 0x1::ascii::String, arg1: address, arg2: u32, arg3: address) {
        let v0 = DappUpgraded{
            dapp_key       : arg0,
            new_package_id : arg1,
            new_version    : arg2,
            admin          : arg3,
        };
        0x2::event::emit<DappUpgraded>(v0);
    }

    public(friend) fun emit_default_free_credit_updated(arg0: u256, arg1: u64, arg2: address) {
        let v0 = DefaultFreeCreditUpdated{
            new_amount      : arg0,
            new_duration_ms : arg1,
            updated_by      : arg2,
        };
        0x2::event::emit<DefaultFreeCreditUpdated>(v0);
    }

    public(friend) fun emit_default_revenue_share_updated(arg0: u64) {
        let v0 = DefaultRevenueShareUpdated{new_bps: arg0};
        0x2::event::emit<DefaultRevenueShareUpdated>(v0);
    }

    public(friend) fun emit_fee_update_scheduled(arg0: u256, arg1: u256, arg2: u64) {
        let v0 = FeeUpdateScheduled{
            pending_base_fee  : arg0,
            pending_bytes_fee : arg1,
            effective_at_ms   : arg2,
        };
        0x2::event::emit<FeeUpdateScheduled>(v0);
    }

    public(friend) fun emit_fee_updated(arg0: u256, arg1: u256, arg2: u64) {
        let v0 = FeeUpdated{
            new_base_fee  : arg0,
            new_bytes_fee : arg1,
            at_ms         : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public(friend) fun emit_framework_max_write_limit_updated(arg0: u64, arg1: address) {
        let v0 = FrameworkMaxWriteLimitUpdated{
            new_limit : arg0,
            admin     : arg1,
        };
        0x2::event::emit<FrameworkMaxWriteLimitUpdated>(v0);
    }

    public(friend) fun emit_free_credit_extended(arg0: 0x1::ascii::String, arg1: u64, arg2: address) {
        let v0 = FreeCreditExtended{
            dapp_key       : arg0,
            new_expires_at : arg1,
            extended_by    : arg2,
        };
        0x2::event::emit<FreeCreditExtended>(v0);
    }

    public(friend) fun emit_free_credit_granted(arg0: 0x1::ascii::String, arg1: u256, arg2: u64, arg3: address) {
        let v0 = FreeCreditGranted{
            dapp_key   : arg0,
            amount     : arg1,
            expires_at : arg2,
            granted_by : arg3,
        };
        0x2::event::emit<FreeCreditGranted>(v0);
    }

    public(friend) fun emit_free_credit_revoked(arg0: 0x1::ascii::String, arg1: u256, arg2: address) {
        let v0 = FreeCreditRevoked{
            dapp_key         : arg0,
            amount_remaining : arg1,
            revoked_by       : arg2,
        };
        0x2::event::emit<FreeCreditRevoked>(v0);
    }

    public(friend) fun emit_item_listed(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: u64, arg8: 0x1::ascii::String, arg9: bool, arg10: 0x1::option::Option<u64>) {
        let v0 = ItemListed{
            dapp_key     : arg0,
            listing_id   : arg1,
            seller       : arg2,
            record_type  : arg3,
            record_key   : arg4,
            field_names  : arg5,
            record_data  : arg6,
            price        : arg7,
            coin_type    : arg8,
            is_fungible  : arg9,
            listed_until : arg10,
        };
        0x2::event::emit<ItemListed>(v0);
    }

    public(friend) fun emit_item_sold(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: address, arg4: vector<u8>, arg5: u64, arg6: 0x1::ascii::String, arg7: bool) {
        let v0 = ItemSold{
            dapp_key    : arg0,
            listing_id  : arg1,
            buyer       : arg2,
            seller      : arg3,
            record_type : arg4,
            price       : arg5,
            coin_type   : arg6,
            is_fungible : arg7,
        };
        0x2::event::emit<ItemSold>(v0);
    }

    public(friend) fun emit_listing_cancelled(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: bool) {
        let v0 = ListingCancelled{
            dapp_key    : arg0,
            listing_id  : arg1,
            seller      : arg2,
            is_fungible : arg3,
        };
        0x2::event::emit<ListingCancelled>(v0);
    }

    public(friend) fun emit_listing_expired(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: bool) {
        let v0 = ListingExpired{
            dapp_key    : arg0,
            listing_id  : arg1,
            seller      : arg2,
            is_fungible : arg3,
        };
        0x2::event::emit<ListingExpired>(v0);
    }

    public(friend) fun emit_marketplace_fee_settled(arg0: 0x1::ascii::String, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = MarketplaceFeeSettled{
            dapp_key        : arg0,
            listing_id      : arg1,
            coin_type       : arg2,
            total_fee       : arg3,
            treasury_amount : arg4,
            dapp_amount     : arg5,
        };
        0x2::event::emit<MarketplaceFeeSettled>(v0);
    }

    public(friend) fun emit_marketplace_fee_updated(arg0: u64) {
        let v0 = Dubhe_Marketplace_FeeUpdated{fee_bps: arg0};
        0x2::event::emit<Dubhe_Marketplace_FeeUpdated>(v0);
    }

    public(friend) fun emit_object_created(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>) {
        let v0 = Dubhe_Object_Created{
            dapp_key    : arg0,
            object_type : arg1,
            object_id   : arg2,
            entity_id   : arg3,
        };
        0x2::event::emit<Dubhe_Object_Created>(v0);
    }

    public(friend) fun emit_object_delete_field(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>) {
        let v0 = Dubhe_Object_DeleteField{
            dapp_key    : arg0,
            object_type : arg1,
            object_id   : arg2,
            field_name  : arg3,
        };
        0x2::event::emit<Dubhe_Object_DeleteField>(v0);
    }

    public(friend) fun emit_object_destroyed(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>) {
        let v0 = Dubhe_Object_Destroyed{
            dapp_key    : arg0,
            object_type : arg1,
            object_id   : arg2,
            entity_id   : arg3,
        };
        0x2::event::emit<Dubhe_Object_Destroyed>(v0);
    }

    public(friend) fun emit_object_set_field(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = Dubhe_Object_SetField{
            dapp_key    : arg0,
            object_type : arg1,
            object_id   : arg2,
            field_name  : arg3,
            field_value : arg4,
        };
        0x2::event::emit<Dubhe_Object_SetField>(v0);
    }

    public(friend) fun emit_scene_created(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: 0x1::option::Option<address>) {
        let v0 = Dubhe_Scene_Created{
            dapp_key             : arg0,
            scene_type           : arg1,
            scene_id             : arg2,
            authorization_kind   : arg3,
            authorized_permit_id : arg4,
        };
        0x2::event::emit<Dubhe_Scene_Created>(v0);
    }

    public(friend) fun emit_scene_delete_field(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>) {
        let v0 = Dubhe_Scene_DeleteField{
            dapp_key   : arg0,
            scene_type : arg1,
            scene_id   : arg2,
            field_name : arg3,
        };
        0x2::event::emit<Dubhe_Scene_DeleteField>(v0);
    }

    public(friend) fun emit_scene_destroyed(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: 0x1::option::Option<address>) {
        let v0 = Dubhe_Scene_Destroyed{
            dapp_key             : arg0,
            scene_type           : arg1,
            scene_id             : arg2,
            authorized_permit_id : arg3,
        };
        0x2::event::emit<Dubhe_Scene_Destroyed>(v0);
    }

    public(friend) fun emit_scene_permit_accept(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: address) {
        let v0 = Dubhe_ScenePermit_Accept{
            dapp_key    : arg0,
            permit_type : arg1,
            permit_id   : arg2,
            participant : arg3,
        };
        0x2::event::emit<Dubhe_ScenePermit_Accept>(v0);
    }

    public(friend) fun emit_scene_permit_created(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: u64) {
        let v0 = Dubhe_ScenePermit_Created{
            dapp_key          : arg0,
            permit_type       : arg1,
            permit_id         : arg2,
            expires_at        : arg3,
            invites_expire_at : arg4,
            max_participants  : arg5,
            participant_count : arg6,
        };
        0x2::event::emit<Dubhe_ScenePermit_Created>(v0);
    }

    public(friend) fun emit_scene_permit_expire(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address) {
        let v0 = Dubhe_ScenePermit_Expire{
            dapp_key    : arg0,
            permit_type : arg1,
            permit_id   : arg2,
        };
        0x2::event::emit<Dubhe_ScenePermit_Expire>(v0);
    }

    public(friend) fun emit_scene_permit_join(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: address) {
        let v0 = Dubhe_ScenePermit_Join{
            dapp_key    : arg0,
            permit_type : arg1,
            permit_id   : arg2,
            participant : arg3,
        };
        0x2::event::emit<Dubhe_ScenePermit_Join>(v0);
    }

    public(friend) fun emit_scene_permit_leave(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: address) {
        let v0 = Dubhe_ScenePermit_Leave{
            dapp_key    : arg0,
            permit_type : arg1,
            permit_id   : arg2,
            participant : arg3,
        };
        0x2::event::emit<Dubhe_ScenePermit_Leave>(v0);
    }

    public(friend) fun emit_scene_set_field(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = Dubhe_Scene_SetField{
            dapp_key    : arg0,
            scene_type  : arg1,
            scene_id    : arg2,
            field_name  : arg3,
            field_value : arg4,
        };
        0x2::event::emit<Dubhe_Scene_SetField>(v0);
    }

    public(friend) fun emit_session_activated(arg0: 0x1::ascii::String, arg1: address, arg2: address, arg3: u64) {
        let v0 = SessionActivated{
            dapp_key       : arg0,
            canonical      : arg1,
            session_wallet : arg2,
            expires_at     : arg3,
        };
        0x2::event::emit<SessionActivated>(v0);
    }

    public(friend) fun emit_session_deactivated(arg0: 0x1::ascii::String, arg1: address, arg2: address) {
        let v0 = SessionDeactivated{
            dapp_key    : arg0,
            canonical   : arg1,
            session_key : arg2,
        };
        0x2::event::emit<SessionDeactivated>(v0);
    }

    public(friend) fun emit_settlement_mode_changed(arg0: 0x1::ascii::String, arg1: u8, arg2: u8) {
        let v0 = SettlementModeChanged{
            dapp_key : arg0,
            old_mode : arg1,
            new_mode : arg2,
        };
        0x2::event::emit<SettlementModeChanged>(v0);
    }

    public(friend) fun emit_settlement_partial(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: u256, arg4: u64, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = SettlementPartial{
            dapp_key         : arg0,
            account          : arg1,
            settled_writes   : arg2,
            settled_bytes    : arg3,
            remaining_writes : arg4,
            remaining_bytes  : arg5,
            free_cost        : arg6,
            paid_cost        : arg7,
        };
        0x2::event::emit<SettlementPartial>(v0);
    }

    public(friend) fun emit_settlement_skipped(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: u256) {
        let v0 = SettlementSkipped{
            dapp_key         : arg0,
            account          : arg1,
            unsettled_writes : arg2,
            unsettled_bytes  : arg3,
        };
        0x2::event::emit<SettlementSkipped>(v0);
    }

    public(friend) fun emit_store_delete_field(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<u8>) {
        let v0 = Dubhe_Store_DeleteField{
            dapp_key   : arg0,
            account    : arg1,
            key        : arg2,
            field_name : arg3,
        };
        0x2::event::emit<Dubhe_Store_DeleteField>(v0);
    }

    public(friend) fun emit_store_delete_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        0x2::event::emit<Dubhe_Store_DeleteRecord>(new_store_delete_record(arg0, arg1, arg2));
    }

    public(friend) fun emit_store_set_field(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = Dubhe_Store_SetField{
            dapp_key    : arg0,
            account     : arg1,
            key         : arg2,
            field_name  : arg3,
            field_value : arg4,
        };
        0x2::event::emit<Dubhe_Store_SetField>(v0);
    }

    public(friend) fun emit_store_set_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) {
        0x2::event::emit<Dubhe_Store_SetRecord>(new_store_set_record(arg0, arg1, arg2, arg3));
    }

    public(friend) fun emit_user_storage_created(arg0: 0x1::ascii::String, arg1: address, arg2: address) {
        let v0 = Dubhe_UserStorage_Created{
            dapp_key        : arg0,
            canonical_owner : arg1,
            user_storage_id : arg2,
        };
        0x2::event::emit<Dubhe_UserStorage_Created>(v0);
    }

    public(friend) fun emit_user_write_limit_synced(arg0: 0x1::ascii::String, arg1: address, arg2: u64) {
        let v0 = UserWriteLimitSynced{
            dapp_key  : arg0,
            owner     : arg1,
            new_limit : arg2,
        };
        0x2::event::emit<UserWriteLimitSynced>(v0);
    }

    public(friend) fun emit_writes_settled(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = WritesSettled{
            dapp_key  : arg0,
            account   : arg1,
            writes    : arg2,
            bytes     : arg3,
            free_cost : arg4,
            paid_cost : arg5,
        };
        0x2::event::emit<WritesSettled>(v0);
    }

    public(friend) fun new_store_delete_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : Dubhe_Store_DeleteRecord {
        Dubhe_Store_DeleteRecord{
            dapp_key : arg0,
            account  : arg1,
            key      : arg2,
        }
    }

    public(friend) fun new_store_set_record(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : Dubhe_Store_SetRecord {
        Dubhe_Store_SetRecord{
            dapp_key : arg0,
            account  : arg1,
            key      : arg2,
            value    : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

