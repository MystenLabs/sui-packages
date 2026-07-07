module 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events {
    struct MarketState has copy, drop {
        total_supply_assets: u128,
        total_supply_shares: u128,
        fee_shares: u128,
        total_borrow_assets: u128,
        total_borrow_shares: u128,
        total_collateral_assets: u128,
        total_collateral_shares: u128,
        last_update: u64,
        rate_at_target: u256,
        fee: u256,
        flash_active: bool,
    }

    struct AccountState has copy, drop {
        borrow_shares: u128,
        borrow_assets: u128,
        collateral_shares: u128,
        collateral_assets: u128,
    }

    struct PriceSnapshot has copy, drop {
        oracle: 0x2::object::ID,
        price: u256,
        decimals: u8,
        timestamp: u64,
    }

    struct AclCreated has copy, drop {
        acl: 0x2::object::ID,
        super_admin: address,
        owner: address,
        new_super_admin: address,
        start: u64,
        delay: u64,
    }

    struct NewAdmin has copy, drop {
        admin: address,
        permissions: u128,
    }

    struct RoleAdded has copy, drop {
        admin: address,
        role: u8,
        permissions: u128,
    }

    struct RoleRemoved has copy, drop {
        admin: address,
        role: u8,
        permissions: u128,
    }

    struct RevokeAdmin has copy, drop {
        admin: address,
        previous_permissions: u128,
    }

    struct AdminDestroyed has copy, drop {
        admin: address,
        previous_permissions: u128,
        was_registered: bool,
    }

    struct StartSuperAdminTransfer has copy, drop {
        super_admin: address,
        current_super_admin: address,
        new_super_admin: address,
        start: u64,
        delay: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        super_admin: address,
        old_super_admin: address,
        new_super_admin: address,
    }

    struct SuperAdminDestroyed has copy, drop {
        super_admin: address,
    }

    struct ProtocolUpgradeCapCreated has copy, drop {
        authority: 0x2::object::ID,
        package: 0x2::object::ID,
        policy: u8,
    }

    struct ProtocolUpgradeAuthorized has copy, drop {
        authority: 0x2::object::ID,
        package: 0x2::object::ID,
        policy: u8,
        digest: vector<u8>,
    }

    struct ProtocolUpgradeCommitted has copy, drop {
        authority: 0x2::object::ID,
        package: 0x2::object::ID,
        version: u64,
    }

    struct ProtocolUpgradePolicyRestricted has copy, drop {
        authority: 0x2::object::ID,
        package: 0x2::object::ID,
        policy: u8,
    }

    struct ProtocolUpgradeCapMadeImmutable has copy, drop {
        authority: 0x2::object::ID,
        package: 0x2::object::ID,
    }

    struct NewOracle has copy, drop {
        oracle: 0x2::object::ID,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct OracleDestroyed has copy, drop {
        oracle: 0x2::object::ID,
    }

    struct FeedAdded has copy, drop {
        oracle: 0x2::object::ID,
        feed: 0x1::type_name::TypeName,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct FeedRemoved has copy, drop {
        oracle: 0x2::object::ID,
        feed: 0x1::type_name::TypeName,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct TimeLimitUpdated has copy, drop {
        oracle: 0x2::object::ID,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct DeviationUpdated has copy, drop {
        oracle: 0x2::object::ID,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct PriceModeUpdated has copy, drop {
        oracle: 0x2::object::ID,
        feeds: vector<0x1::type_name::TypeName>,
        price_mode: u8,
        time_limit: u64,
        deviation: u256,
    }

    struct PriceResolved has copy, drop {
        oracle: 0x2::object::ID,
        price_mode: u8,
        price: u256,
        decimals: u8,
        timestamp: u64,
    }

    struct MarketCreated has copy, drop {
        market: 0x2::object::ID,
        market_cap: 0x2::object::ID,
        oracle: 0x2::object::ID,
        collateral_type: 0x1::type_name::TypeName,
        loan_type: 0x1::type_name::TypeName,
        share_type: 0x1::type_name::TypeName,
        lltv: u256,
        fee: u256,
        last_update: u64,
        irm: 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::irm::InterestRateModel,
        state: MarketState,
    }

    struct PositionOpened has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        account: AccountState,
    }

    struct PositionClosed has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        account: AccountState,
    }

    struct MarketCapDestroyed has copy, drop {
        market: 0x2::object::ID,
    }

    struct Supplied has copy, drop {
        market: 0x2::object::ID,
        assets: u128,
        shares: u128,
        state: MarketState,
    }

    struct Withdrawn has copy, drop {
        market: 0x2::object::ID,
        assets: u128,
        shares: u128,
        state: MarketState,
    }

    struct FeeWithdrawn has copy, drop {
        market: 0x2::object::ID,
        assets: u128,
        shares: u128,
        state: MarketState,
    }

    struct CollateralSupplied has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        amount: u128,
        shares: u128,
        account: AccountState,
        state: MarketState,
    }

    struct CollateralWithdrawn has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        amount: u128,
        shares: u128,
        price: PriceSnapshot,
        account: AccountState,
        state: MarketState,
    }

    struct Borrowed has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        assets: u128,
        shares: u128,
        price: PriceSnapshot,
        account: AccountState,
        state: MarketState,
    }

    struct Repaid has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        assets: u128,
        shares: u128,
        account: AccountState,
        state: MarketState,
    }

    struct InterestAccrued has copy, drop {
        market: 0x2::object::ID,
        interest: u128,
        fee_shares: u128,
        rate_at_target: u256,
        last_update: u64,
        state: MarketState,
    }

    struct FeeSet has copy, drop {
        market: 0x2::object::ID,
        fee: u256,
        state: MarketState,
    }

    struct InterestRateModelSet has copy, drop {
        market: 0x2::object::ID,
        irm: 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::irm::InterestRateModel,
        state: MarketState,
    }

    struct Liquidated has copy, drop {
        market: 0x2::object::ID,
        position: 0x2::object::ID,
        repaid_assets: u128,
        repaid_shares: u128,
        seized_collateral: u128,
        seized_collateral_shares: u128,
        bad_debt: u128,
        price: PriceSnapshot,
        account: AccountState,
        state: MarketState,
    }

    struct LiquidationRepaid has copy, drop {
        market: 0x2::object::ID,
        repaid_assets: u128,
        excess: u128,
        state: MarketState,
    }

    struct LiquidatorUpdated has copy, drop {
        market: 0x2::object::ID,
        liquidator: address,
        whitelisted: bool,
        liquidators: vector<address>,
    }

    struct FlashLoaned has copy, drop {
        market: 0x2::object::ID,
        loan_amount: u128,
        loan_fee: u128,
        collateral_amount: u128,
        collateral_fee: u128,
        state: MarketState,
    }

    struct FlashLoanRepaid has copy, drop {
        market: 0x2::object::ID,
        loan_repaid: u128,
        collateral_repaid: u128,
        loan_amount: u128,
        collateral_amount: u128,
        state: MarketState,
    }

    public(friend) fun account_state(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : AccountState {
        AccountState{
            borrow_shares     : arg0,
            borrow_assets     : arg1,
            collateral_shares : arg2,
            collateral_assets : arg3,
        }
    }

    public(friend) fun acl_created(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64) {
        let v0 = AclCreated{
            acl             : arg0,
            super_admin     : arg1,
            owner           : arg2,
            new_super_admin : arg3,
            start           : arg4,
            delay           : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<AclCreated>(v0);
    }

    public(friend) fun admin_destroyed(arg0: address, arg1: u128, arg2: bool) {
        let v0 = AdminDestroyed{
            admin                : arg0,
            previous_permissions : arg1,
            was_registered       : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<AdminDestroyed>(v0);
    }

    public(friend) fun borrowed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: PriceSnapshot, arg5: AccountState, arg6: MarketState) {
        let v0 = Borrowed{
            market   : arg0,
            position : arg1,
            assets   : arg2,
            shares   : arg3,
            price    : arg4,
            account  : arg5,
            state    : arg6,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<Borrowed>(v0);
    }

    public(friend) fun collateral_supplied(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: AccountState, arg5: MarketState) {
        let v0 = CollateralSupplied{
            market   : arg0,
            position : arg1,
            amount   : arg2,
            shares   : arg3,
            account  : arg4,
            state    : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<CollateralSupplied>(v0);
    }

    public(friend) fun collateral_withdrawn(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: PriceSnapshot, arg5: AccountState, arg6: MarketState) {
        let v0 = CollateralWithdrawn{
            market   : arg0,
            position : arg1,
            amount   : arg2,
            shares   : arg3,
            price    : arg4,
            account  : arg5,
            state    : arg6,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<CollateralWithdrawn>(v0);
    }

    public(friend) fun deviation_updated(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: u8, arg3: u64, arg4: u256) {
        let v0 = DeviationUpdated{
            oracle     : arg0,
            feeds      : arg1,
            price_mode : arg2,
            time_limit : arg3,
            deviation  : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<DeviationUpdated>(v0);
    }

    public(friend) fun fee_set(arg0: 0x2::object::ID, arg1: u256, arg2: MarketState) {
        let v0 = FeeSet{
            market : arg0,
            fee    : arg1,
            state  : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FeeSet>(v0);
    }

    public(friend) fun fee_withdrawn(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: MarketState) {
        let v0 = FeeWithdrawn{
            market : arg0,
            assets : arg1,
            shares : arg2,
            state  : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FeeWithdrawn>(v0);
    }

    public(friend) fun feed_added(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: vector<0x1::type_name::TypeName>, arg3: u8, arg4: u64, arg5: u256) {
        let v0 = FeedAdded{
            oracle     : arg0,
            feed       : arg1,
            feeds      : arg2,
            price_mode : arg3,
            time_limit : arg4,
            deviation  : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FeedAdded>(v0);
    }

    public(friend) fun feed_removed(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: vector<0x1::type_name::TypeName>, arg3: u8, arg4: u64, arg5: u256) {
        let v0 = FeedRemoved{
            oracle     : arg0,
            feed       : arg1,
            feeds      : arg2,
            price_mode : arg3,
            time_limit : arg4,
            deviation  : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FeedRemoved>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address, arg1: address, arg2: address) {
        let v0 = FinishSuperAdminTransfer{
            super_admin     : arg0,
            old_super_admin : arg1,
            new_super_admin : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun flash_loan_repaid(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: MarketState) {
        let v0 = FlashLoanRepaid{
            market            : arg0,
            loan_repaid       : arg1,
            collateral_repaid : arg2,
            loan_amount       : arg3,
            collateral_amount : arg4,
            state             : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FlashLoanRepaid>(v0);
    }

    public(friend) fun flash_loaned(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: MarketState) {
        let v0 = FlashLoaned{
            market            : arg0,
            loan_amount       : arg1,
            loan_fee          : arg2,
            collateral_amount : arg3,
            collateral_fee    : arg4,
            state             : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<FlashLoaned>(v0);
    }

    public(friend) fun interest_accrued(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u256, arg4: u64, arg5: MarketState) {
        let v0 = InterestAccrued{
            market         : arg0,
            interest       : arg1,
            fee_shares     : arg2,
            rate_at_target : arg3,
            last_update    : arg4,
            state          : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<InterestAccrued>(v0);
    }

    public(friend) fun interest_rate_model_set(arg0: 0x2::object::ID, arg1: 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::irm::InterestRateModel, arg2: MarketState) {
        let v0 = InterestRateModelSet{
            market : arg0,
            irm    : arg1,
            state  : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<InterestRateModelSet>(v0);
    }

    public(friend) fun liquidated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: PriceSnapshot, arg8: AccountState, arg9: MarketState) {
        let v0 = Liquidated{
            market                   : arg0,
            position                 : arg1,
            repaid_assets            : arg2,
            repaid_shares            : arg3,
            seized_collateral        : arg4,
            seized_collateral_shares : arg5,
            bad_debt                 : arg6,
            price                    : arg7,
            account                  : arg8,
            state                    : arg9,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<Liquidated>(v0);
    }

    public(friend) fun liquidation_repaid(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: MarketState) {
        let v0 = LiquidationRepaid{
            market        : arg0,
            repaid_assets : arg1,
            excess        : arg2,
            state         : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<LiquidationRepaid>(v0);
    }

    public(friend) fun liquidator_updated(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: vector<address>) {
        let v0 = LiquidatorUpdated{
            market      : arg0,
            liquidator  : arg1,
            whitelisted : arg2,
            liquidators : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<LiquidatorUpdated>(v0);
    }

    public(friend) fun market_cap_destroyed(arg0: 0x2::object::ID) {
        let v0 = MarketCapDestroyed{market: arg0};
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<MarketCapDestroyed>(v0);
    }

    public(friend) fun market_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u256, arg7: u256, arg8: u64, arg9: 0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::irm::InterestRateModel, arg10: MarketState) {
        let v0 = MarketCreated{
            market          : arg0,
            market_cap      : arg1,
            oracle          : arg2,
            collateral_type : arg3,
            loan_type       : arg4,
            share_type      : arg5,
            lltv            : arg6,
            fee             : arg7,
            last_update     : arg8,
            irm             : arg9,
            state           : arg10,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<MarketCreated>(v0);
    }

    public(friend) fun market_state(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u256, arg9: u256, arg10: bool) : MarketState {
        MarketState{
            total_supply_assets     : arg0,
            total_supply_shares     : arg1,
            fee_shares              : arg2,
            total_borrow_assets     : arg3,
            total_borrow_shares     : arg4,
            total_collateral_assets : arg5,
            total_collateral_shares : arg6,
            last_update             : arg7,
            rate_at_target          : arg8,
            fee                     : arg9,
            flash_active            : arg10,
        }
    }

    public(friend) fun new_admin(arg0: address, arg1: u128) {
        let v0 = NewAdmin{
            admin       : arg0,
            permissions : arg1,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun new_oracle(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: u8, arg3: u64, arg4: u256) {
        let v0 = NewOracle{
            oracle     : arg0,
            feeds      : arg1,
            price_mode : arg2,
            time_limit : arg3,
            deviation  : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<NewOracle>(v0);
    }

    public(friend) fun oracle_destroyed(arg0: 0x2::object::ID) {
        let v0 = OracleDestroyed{oracle: arg0};
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<OracleDestroyed>(v0);
    }

    public(friend) fun position_closed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: AccountState) {
        let v0 = PositionClosed{
            market   : arg0,
            position : arg1,
            account  : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<PositionClosed>(v0);
    }

    public(friend) fun position_opened(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: AccountState) {
        let v0 = PositionOpened{
            market   : arg0,
            position : arg1,
            account  : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<PositionOpened>(v0);
    }

    public(friend) fun price_mode_updated(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: u8, arg3: u64, arg4: u256) {
        let v0 = PriceModeUpdated{
            oracle     : arg0,
            feeds      : arg1,
            price_mode : arg2,
            time_limit : arg3,
            deviation  : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<PriceModeUpdated>(v0);
    }

    public(friend) fun price_resolved(arg0: 0x2::object::ID, arg1: u8, arg2: u256, arg3: u8, arg4: u64) {
        let v0 = PriceResolved{
            oracle     : arg0,
            price_mode : arg1,
            price      : arg2,
            decimals   : arg3,
            timestamp  : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<PriceResolved>(v0);
    }

    public(friend) fun price_snapshot(arg0: 0x2::object::ID, arg1: u256, arg2: u8, arg3: u64) : PriceSnapshot {
        PriceSnapshot{
            oracle    : arg0,
            price     : arg1,
            decimals  : arg2,
            timestamp : arg3,
        }
    }

    public(friend) fun protocol_upgrade_authorized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: vector<u8>) {
        let v0 = ProtocolUpgradeAuthorized{
            authority : arg0,
            package   : arg1,
            policy    : arg2,
            digest    : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<ProtocolUpgradeAuthorized>(v0);
    }

    public(friend) fun protocol_upgrade_cap_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = ProtocolUpgradeCapCreated{
            authority : arg0,
            package   : arg1,
            policy    : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<ProtocolUpgradeCapCreated>(v0);
    }

    public(friend) fun protocol_upgrade_cap_made_immutable(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ProtocolUpgradeCapMadeImmutable{
            authority : arg0,
            package   : arg1,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<ProtocolUpgradeCapMadeImmutable>(v0);
    }

    public(friend) fun protocol_upgrade_committed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ProtocolUpgradeCommitted{
            authority : arg0,
            package   : arg1,
            version   : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<ProtocolUpgradeCommitted>(v0);
    }

    public(friend) fun protocol_upgrade_policy_restricted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) {
        let v0 = ProtocolUpgradePolicyRestricted{
            authority : arg0,
            package   : arg1,
            policy    : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<ProtocolUpgradePolicyRestricted>(v0);
    }

    public(friend) fun repaid(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: AccountState, arg5: MarketState) {
        let v0 = Repaid{
            market   : arg0,
            position : arg1,
            assets   : arg2,
            shares   : arg3,
            account  : arg4,
            state    : arg5,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<Repaid>(v0);
    }

    public(friend) fun revoke_admin(arg0: address, arg1: u128) {
        let v0 = RevokeAdmin{
            admin                : arg0,
            previous_permissions : arg1,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun role_added(arg0: address, arg1: u8, arg2: u128) {
        let v0 = RoleAdded{
            admin       : arg0,
            role        : arg1,
            permissions : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<RoleAdded>(v0);
    }

    public(friend) fun role_removed(arg0: address, arg1: u8, arg2: u128) {
        let v0 = RoleRemoved{
            admin       : arg0,
            role        : arg1,
            permissions : arg2,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<RoleRemoved>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = StartSuperAdminTransfer{
            super_admin         : arg0,
            current_super_admin : arg1,
            new_super_admin     : arg2,
            start               : arg3,
            delay               : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    public(friend) fun super_admin_destroyed(arg0: address) {
        let v0 = SuperAdminDestroyed{super_admin: arg0};
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<SuperAdminDestroyed>(v0);
    }

    public(friend) fun supplied(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: MarketState) {
        let v0 = Supplied{
            market : arg0,
            assets : arg1,
            shares : arg2,
            state  : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<Supplied>(v0);
    }

    public(friend) fun time_limit_updated(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: u8, arg3: u64, arg4: u256) {
        let v0 = TimeLimitUpdated{
            oracle     : arg0,
            feeds      : arg1,
            price_mode : arg2,
            time_limit : arg3,
            deviation  : arg4,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<TimeLimitUpdated>(v0);
    }

    public(friend) fun withdrawn(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: MarketState) {
        let v0 = Withdrawn{
            market : arg0,
            assets : arg1,
            shares : arg2,
            state  : arg3,
        };
        0x35bb2811abb1378bcac0b35e56064745a13015d50d16548c70a7e873920d67b7::events_wrapper::emit_event<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

