module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::events {
    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        collection_type: u8,
        max_supply: u64,
        royalty_bps: u16,
        platform_fee_bps: u16,
    }

    struct CollectionPaused has copy, drop {
        collection_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct CollectionUnpaused has copy, drop {
        collection_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct CollectionDeleted has copy, drop {
        collection_id: 0x2::object::ID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
        recipient: address,
        price: u64,
        stage_index: u64,
    }

    struct MintStagesConfigured has copy, drop {
        collection_id: 0x2::object::ID,
        stage_count: u64,
    }

    struct RevenueDistributed has copy, drop {
        collection_id: 0x2::object::ID,
        total_amount: u64,
    }

    struct DropItemsAdded has copy, drop {
        collection_id: 0x2::object::ID,
        count: u64,
        total_items: u64,
    }

    struct DisplayConfigured has copy, drop {
        collection_id: 0x2::object::ID,
    }

    struct TransferPolicyCreated has copy, drop {
        collection_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    struct PlatformFeeUpdated has copy, drop {
        old_fee_bps: u16,
        new_fee_bps: u16,
    }

    struct DeploymentFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct RegistryPausedChanged has copy, drop {
        paused: bool,
    }

    struct PlatformAddressUpdated has copy, drop {
        old_address: address,
        new_address: address,
    }

    public fun emit_collection_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: u8, arg5: u64, arg6: u16, arg7: u16) {
        let v0 = CollectionCreated{
            collection_id    : arg0,
            name             : arg1,
            symbol           : arg2,
            creator          : arg3,
            collection_type  : arg4,
            max_supply       : arg5,
            royalty_bps      : arg6,
            platform_fee_bps : arg7,
        };
        0x2::event::emit<CollectionCreated>(v0);
    }

    public fun emit_collection_deleted(arg0: 0x2::object::ID) {
        let v0 = CollectionDeleted{collection_id: arg0};
        0x2::event::emit<CollectionDeleted>(v0);
    }

    public fun emit_collection_paused(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = CollectionPaused{
            collection_id : arg0,
            timestamp_ms  : arg1,
        };
        0x2::event::emit<CollectionPaused>(v0);
    }

    public fun emit_collection_unpaused(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = CollectionUnpaused{
            collection_id : arg0,
            timestamp_ms  : arg1,
        };
        0x2::event::emit<CollectionUnpaused>(v0);
    }

    public fun emit_deployment_fee_updated(arg0: u64, arg1: u64) {
        let v0 = DeploymentFeeUpdated{
            old_fee : arg0,
            new_fee : arg1,
        };
        0x2::event::emit<DeploymentFeeUpdated>(v0);
    }

    public fun emit_display_configured(arg0: 0x2::object::ID) {
        let v0 = DisplayConfigured{collection_id: arg0};
        0x2::event::emit<DisplayConfigured>(v0);
    }

    public fun emit_drop_items_added(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = DropItemsAdded{
            collection_id : arg0,
            count         : arg1,
            total_items   : arg2,
        };
        0x2::event::emit<DropItemsAdded>(v0);
    }

    public fun emit_mint_stages_configured(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MintStagesConfigured{
            collection_id : arg0,
            stage_count   : arg1,
        };
        0x2::event::emit<MintStagesConfigured>(v0);
    }

    public fun emit_nft_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: address, arg5: u64, arg6: u64) {
        let v0 = NFTMinted{
            nft_id        : arg0,
            collection_id : arg1,
            token_id      : arg2,
            minter        : arg3,
            recipient     : arg4,
            price         : arg5,
            stage_index   : arg6,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    public fun emit_platform_address_updated(arg0: address, arg1: address) {
        let v0 = PlatformAddressUpdated{
            old_address : arg0,
            new_address : arg1,
        };
        0x2::event::emit<PlatformAddressUpdated>(v0);
    }

    public fun emit_platform_fee_updated(arg0: u16, arg1: u16) {
        let v0 = PlatformFeeUpdated{
            old_fee_bps : arg0,
            new_fee_bps : arg1,
        };
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    public fun emit_registry_paused_changed(arg0: bool) {
        let v0 = RegistryPausedChanged{paused: arg0};
        0x2::event::emit<RegistryPausedChanged>(v0);
    }

    public fun emit_revenue_distributed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = RevenueDistributed{
            collection_id : arg0,
            total_amount  : arg1,
        };
        0x2::event::emit<RevenueDistributed>(v0);
    }

    public fun emit_transfer_policy_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = TransferPolicyCreated{
            collection_id : arg0,
            policy_id     : arg1,
        };
        0x2::event::emit<TransferPolicyCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

