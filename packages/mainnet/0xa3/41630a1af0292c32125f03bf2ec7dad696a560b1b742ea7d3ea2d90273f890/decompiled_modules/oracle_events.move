module 0xa341630a1af0292c32125f03bf2ec7dad696a560b1b742ea7d3ea2d90273f890::oracle_events {
    struct AggOracleMarketAdded has copy, drop {
        oracle_id: u64,
        pair_label: 0x1::string::String,
        base_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
    }

    struct FeederUpdated has copy, drop {
        feeder: address,
        enabled: bool,
    }

    struct PriceUpdated has copy, drop {
        feeder: address,
        asset_type: 0x1::type_name::TypeName,
        source: u8,
        value: u128,
        conf: u128,
        last_updated: u64,
    }

    struct AssetWeightsUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        sources: vector<u8>,
        weights: vector<u64>,
    }

    struct AssetMaxStalenessUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        max_staleness: u64,
    }

    struct AssetConfThresholdUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        conf_threshold: u128,
    }

    struct AssetConfLiquidateThresholdUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        conf_liquidate_threshold: u128,
    }

    struct AssetDeviationThresholdUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        deviation_threshold: u128,
    }

    struct AssetDegradeThresholdUpdated has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        degrade_threshold: u64,
    }

    struct SourceUpdated has copy, drop {
        source: u8,
        name: 0x1::string::String,
    }

    struct FeedObjectsSet has copy, drop {
        asset_type: 0x1::type_name::TypeName,
        sources: vector<u8>,
        feed_objects: vector<address>,
    }

    public fun emit_agg_oracle_market_added(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName) {
        let v0 = AggOracleMarketAdded{
            oracle_id        : arg0,
            pair_label       : arg1,
            base_token_type  : arg2,
            quote_token_type : arg3,
        };
        0x2::event::emit<AggOracleMarketAdded>(v0);
    }

    public fun emit_asset_conf_liquidate_threshold_updated(arg0: 0x1::type_name::TypeName, arg1: u128) {
        let v0 = AssetConfLiquidateThresholdUpdated{
            asset_type               : arg0,
            conf_liquidate_threshold : arg1,
        };
        0x2::event::emit<AssetConfLiquidateThresholdUpdated>(v0);
    }

    public fun emit_asset_conf_threshold_updated(arg0: 0x1::type_name::TypeName, arg1: u128) {
        let v0 = AssetConfThresholdUpdated{
            asset_type     : arg0,
            conf_threshold : arg1,
        };
        0x2::event::emit<AssetConfThresholdUpdated>(v0);
    }

    public fun emit_asset_degrade_threshold_updated(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = AssetDegradeThresholdUpdated{
            asset_type        : arg0,
            degrade_threshold : arg1,
        };
        0x2::event::emit<AssetDegradeThresholdUpdated>(v0);
    }

    public fun emit_asset_deviation_threshold_updated(arg0: 0x1::type_name::TypeName, arg1: u128) {
        let v0 = AssetDeviationThresholdUpdated{
            asset_type          : arg0,
            deviation_threshold : arg1,
        };
        0x2::event::emit<AssetDeviationThresholdUpdated>(v0);
    }

    public fun emit_asset_max_staleness_updated(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = AssetMaxStalenessUpdated{
            asset_type    : arg0,
            max_staleness : arg1,
        };
        0x2::event::emit<AssetMaxStalenessUpdated>(v0);
    }

    public fun emit_asset_weights_updated(arg0: 0x1::type_name::TypeName, arg1: vector<u8>, arg2: vector<u64>) {
        let v0 = AssetWeightsUpdated{
            asset_type : arg0,
            sources    : arg1,
            weights    : arg2,
        };
        0x2::event::emit<AssetWeightsUpdated>(v0);
    }

    public fun emit_feed_objects_set(arg0: 0x1::type_name::TypeName, arg1: vector<u8>, arg2: vector<address>) {
        let v0 = FeedObjectsSet{
            asset_type   : arg0,
            sources      : arg1,
            feed_objects : arg2,
        };
        0x2::event::emit<FeedObjectsSet>(v0);
    }

    public fun emit_feeder_updated(arg0: address, arg1: bool) {
        let v0 = FeederUpdated{
            feeder  : arg0,
            enabled : arg1,
        };
        0x2::event::emit<FeederUpdated>(v0);
    }

    public fun emit_price_updated(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u128, arg4: u128, arg5: u64) {
        let v0 = PriceUpdated{
            feeder       : arg0,
            asset_type   : arg1,
            source       : arg2,
            value        : arg3,
            conf         : arg4,
            last_updated : arg5,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public fun emit_source_updated(arg0: u8, arg1: 0x1::string::String) {
        let v0 = SourceUpdated{
            source : arg0,
            name   : arg1,
        };
        0x2::event::emit<SourceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

