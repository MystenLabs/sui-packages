module 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::keys {
    struct RegistryMarketInfo has copy, drop, store {
        ch_id: 0x2::object::ID,
    }

    struct RegistryCollateralInfo<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RegistryConfig has copy, drop, store {
        dummy_field: bool,
    }

    struct IntegratorConfig has copy, drop, store {
        integrator_address: address,
    }

    struct IntegratorVault has copy, drop, store {
        integrator_address: address,
    }

    struct Orderbook has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketVault has copy, drop, store {
        dummy_field: bool,
    }

    struct Position has copy, drop, store {
        account_id: u64,
    }

    struct MarginRatioProposal has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionFeesProposal has copy, drop, store {
        account_id: u64,
    }

    struct SettlementPrices has copy, drop, store {
        dummy_field: bool,
    }

    struct AsksMap has copy, drop, store {
        dummy_field: bool,
    }

    struct BidsMap has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun asks_map() : AsksMap {
        AsksMap{dummy_field: false}
    }

    public(friend) fun bids_map() : BidsMap {
        BidsMap{dummy_field: false}
    }

    public(friend) fun integrator_config(arg0: address) : IntegratorConfig {
        IntegratorConfig{integrator_address: arg0}
    }

    public(friend) fun integrator_vault(arg0: address) : IntegratorVault {
        IntegratorVault{integrator_address: arg0}
    }

    public(friend) fun margin_ratio_proposal() : MarginRatioProposal {
        MarginRatioProposal{dummy_field: false}
    }

    public(friend) fun market_orderbook() : Orderbook {
        Orderbook{dummy_field: false}
    }

    public(friend) fun market_vault() : MarketVault {
        MarketVault{dummy_field: false}
    }

    public(friend) fun position(arg0: u64) : Position {
        Position{account_id: arg0}
    }

    public(friend) fun position_fees_proposal(arg0: u64) : PositionFeesProposal {
        PositionFeesProposal{account_id: arg0}
    }

    public(friend) fun registry_collateral_info<T0>() : RegistryCollateralInfo<T0> {
        RegistryCollateralInfo<T0>{dummy_field: false}
    }

    public(friend) fun registry_config() : RegistryConfig {
        RegistryConfig{dummy_field: false}
    }

    public(friend) fun registry_market_info(arg0: 0x2::object::ID) : RegistryMarketInfo {
        RegistryMarketInfo{ch_id: arg0}
    }

    public(friend) fun settlement_prices() : SettlementPrices {
        SettlementPrices{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

