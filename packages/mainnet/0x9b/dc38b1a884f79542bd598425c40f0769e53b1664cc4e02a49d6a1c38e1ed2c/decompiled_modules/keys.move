module 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys {
    struct RegistryMarketInfoKey has copy, drop, store {
        ch_id: 0x2::object::ID,
    }

    struct RegistryCollateralInfoKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RegistryConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccountKey has copy, drop, store {
        account_id: u64,
    }

    struct OrderTicketKey has copy, drop, store {
        ticket_id: 0x2::object::ID,
    }

    struct IntegratorConfigKey has copy, drop, store {
        integrator_id: u32,
    }

    struct IntegratorRegistrationKey has copy, drop, store {
        integrator_id: u32,
    }

    struct MarketVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionKey has copy, drop, store {
        account_id: u64,
    }

    struct MarginRatioProposalKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SettlementPricesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AsksMapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BidsMapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VendorClearingHouseKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VendorRegistrationOpenKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FrozenVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun account(arg0: u64) : AccountKey {
        AccountKey{account_id: arg0}
    }

    public(friend) fun asks_map() : AsksMapKey {
        AsksMapKey{dummy_field: false}
    }

    public(friend) fun bids_map() : BidsMapKey {
        BidsMapKey{dummy_field: false}
    }

    public(friend) fun frozen_version() : FrozenVersionKey {
        FrozenVersionKey{dummy_field: false}
    }

    public(friend) fun integrator_config(arg0: u32) : IntegratorConfigKey {
        IntegratorConfigKey{integrator_id: arg0}
    }

    public(friend) fun integrator_registration(arg0: u32) : IntegratorRegistrationKey {
        IntegratorRegistrationKey{integrator_id: arg0}
    }

    public(friend) fun margin_ratio_proposal() : MarginRatioProposalKey {
        MarginRatioProposalKey{dummy_field: false}
    }

    public(friend) fun market_vault() : MarketVaultKey {
        MarketVaultKey{dummy_field: false}
    }

    public(friend) fun order_ticket(arg0: 0x2::object::ID) : OrderTicketKey {
        OrderTicketKey{ticket_id: arg0}
    }

    public(friend) fun position(arg0: u64) : PositionKey {
        PositionKey{account_id: arg0}
    }

    public(friend) fun registry_collateral_info<T0>() : RegistryCollateralInfoKey<T0> {
        RegistryCollateralInfoKey<T0>{dummy_field: false}
    }

    public(friend) fun registry_config() : RegistryConfigKey {
        RegistryConfigKey{dummy_field: false}
    }

    public(friend) fun registry_market_info(arg0: 0x2::object::ID) : RegistryMarketInfoKey {
        RegistryMarketInfoKey{ch_id: arg0}
    }

    public(friend) fun settlement_prices() : SettlementPricesKey {
        SettlementPricesKey{dummy_field: false}
    }

    public(friend) fun vendor_clearing_house_key<T0>() : VendorClearingHouseKey<T0> {
        VendorClearingHouseKey<T0>{dummy_field: false}
    }

    public(friend) fun vendor_registration_open() : VendorRegistrationOpenKey {
        VendorRegistrationOpenKey{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

