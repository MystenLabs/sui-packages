module 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_collateral<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::add_collateral_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun add_collateral_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::add_collateral_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun auction_bid<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun auction_bid_finish<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_finish_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun auction_bid_finish_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_finish_local<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun auction_bid_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun auction_bid_seize<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_seize_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun auction_bid_seize_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_seize_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun auction_bid_seize_sui<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_seize_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun auction_bid_start<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, 0x2::coin::Coin<T0>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_start_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun auction_bid_start_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AuctionBidReceipt, 0x2::coin::Coin<T0>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::auction_bid_start_local<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun borrow_local_collateral_value<T0, T1, T2>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID) : u64 {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::market_local_collateral_value<T0, T1, T2>(arg0, arg1)
    }

    public fun cancel_market<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::cancel_market<T0, T1>(arg0, arg1, arg2);
    }

    public fun create_market<T0, T1>(arg0: &ProtocolAdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::MarketRegistry, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfigInput>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: 0x1::string::String, arg16: u64, arg17: u8, arg18: u8, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap {
        let v0 = 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::create_market_alphalend<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::register_market(arg1, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::admin_cap_market_id(&v0), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg3, arg15);
        v0
    }

    public fun create_market_local<T0, T1>(arg0: &ProtocolAdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::MarketRegistry, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfigInput>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: 0x1::string::String, arg15: u64, arg16: u8, arg17: u8, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap {
        let v0 = 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::create_market_local<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::register_market(arg1, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::admin_cap_market_id(&v0), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg3, arg14);
        v0
    }

    public fun create_market_with_partner_cap<T0, T1>(arg0: &ProtocolAdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::MarketRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg4: 0x2::coin::TreasuryCap<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfigInput>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: address, arg17: 0x1::string::String, arg18: u64, arg19: u8, arg20: u8, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap {
        let v0 = 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::create_market_with_partner_cap<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::register_market(arg1, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::admin_cap_market_id(&v0), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg5, arg17);
        v0
    }

    public fun decrease_borrow_coin<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::decrease_borrow_coin_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun decrease_borrow_coin_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::decrease_borrow_coin_local<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun decrease_borrow_tokens<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::decrease_borrow_tokens_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun decrease_borrow_tokens_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::decrease_borrow_tokens_local<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun expire_market<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::expire_market<T0, T1>(arg0, arg1);
    }

    public fun force_resolve_cover_shortfall<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_cover_shortfall_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun force_resolve_cover_shortfall_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_cover_shortfall_local<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun force_resolve_finish<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_finish_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun force_resolve_finish_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_finish_local<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun force_resolve_seize<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_seize_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun force_resolve_seize_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_seize_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun force_resolve_seize_sui<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_seize_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun force_resolve_socialize_loss<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::object::ID, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_socialize_loss_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun force_resolve_socialize_loss_local<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: 0x2::object::ID, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_socialize_loss_local<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun force_resolve_start<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::ForceResolveReceipt {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::force_resolve_start<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun increase_borrow<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::increase_borrow_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun increase_borrow_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::increase_borrow_local<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ProtocolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::liquidate_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun liquidate_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::object::ID, arg2: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::liquidate_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun liquidate_sui<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::object::ID, arg3: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::liquidate_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun mint_borrower_cap(arg0: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::mint_borrower_cap(arg0)
    }

    public fun new_ltv_config(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfig {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::new_ltv_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun new_ltv_input(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfig) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfigInput {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::new_ltv_input(arg0, arg1, arg2)
    }

    public fun new_ltv_input_local(arg0: 0x1::type_name::TypeName, arg1: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfig) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::LtvConfigInput {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_borrow::new_ltv_input_local(arg0, arg1)
    }

    public fun open_borrow<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::open_borrow_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun open_borrow_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::open_borrow_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun pause_market<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::pause_market<T0, T1>(arg0, arg1, arg2);
    }

    public fun payment_asset_coin<T0, T1>(arg0: 0x2::coin::Coin<T0>) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::payment_asset_coin<T0, T1>(arg0)
    }

    public fun payment_asset_into_tokens_or_coin<T0, T1>(arg0: 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1>) : (0x1::option::Option<0x2::coin::Coin<T1>>, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::payment_asset_into_tokens_or_coin<T0, T1>(arg0)
    }

    public fun payment_asset_tokens<T0, T1>(arg0: 0x2::coin::Coin<T1>) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::PaymentAsset<T0, T1> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::payment_asset_tokens<T0, T1>(arg0)
    }

    public fun pool_info(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::MarketRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::PoolInfo> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::pool_info(arg0, arg1)
    }

    public fun pool_info_dex(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::PoolInfo) : 0x1::string::String {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::pool_info_dex(arg0)
    }

    public fun pool_info_pool_id(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::PoolInfo) : address {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::pool_info_pool_id(arg0)
    }

    public fun pull_redemption_reserve<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::pull_redemption_reserve_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun reclaim_position_cap<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::reclaim_position_cap<T0, T1>(arg0, arg1, arg2)
    }

    public fun redeem<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::redeem_alphalend<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun redeem_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::redeem_local<T0, T1>(arg0, arg1, arg2)
    }

    public fun refresh_coin_price<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo, arg2: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::refresh_coin_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun refresh_price<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo, arg2: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::refresh_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun reissue_admin_cap<T0, T1>(arg0: &ProtocolAdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::reissue_admin_cap<T0, T1>(arg1, arg2)
    }

    public fun remove_collateral<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::remove_collateral_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_collateral_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::remove_collateral_local<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun remove_collateral_sui<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::remove_collateral_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun set_pool_info<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::MarketRegistry, arg3: 0x1::string::String, arg4: address) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::verify_version<T0, T1>(arg1);
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::verify_admin_cap<T0, T1>(arg0, arg1);
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_registry::set_pool_info(arg2, 0x2::object::id<0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>>(arg1), arg3, arg4);
    }

    public fun sweep_collateral_fees<T0, T1, T2>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_collateral_fees_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun sweep_collateral_fees_local<T0, T1, T2>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_collateral_fees_local<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun sweep_collateral_fees_sui<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_collateral_fees_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun sweep_treasury<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_treasury_alphalend<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun sweep_treasury_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_treasury_local<T0, T1>(arg0, arg1, arg2);
    }

    public fun sweep_treasury_profit<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_treasury_profit_alphalend<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun sweep_treasury_profit_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::sweep_treasury_profit_local<T0, T1>(arg0, arg1);
    }

    public fun try_open_redemption<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::try_open_redemption_alphalend<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun try_open_redemption_local<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::try_open_redemption_local<T0, T1>(arg0, arg1);
    }

    public fun unpause_market<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: &0x2::clock::Clock) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::unpause_market<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_close_factor_bypass_threshold<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_close_factor_bypass_threshold<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_market_version<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_market_version<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_max_borrow_amount_per_unit<T0, T1, T2>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_max_borrow_amount_per_unit<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun update_max_collateral_amount<T0, T1, T2>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_max_collateral_amount<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun update_max_minted_amount_per_borrow<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_max_minted_amount_per_borrow<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_max_price_age_secs<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: u64) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_max_price_age_secs<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_pull_to_local_on_gate_open<T0, T1>(arg0: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::AdminCap, arg1: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg2: bool) {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::update_pull_to_local_on_gate_open<T0, T1>(arg0, arg1, arg2);
    }

    public fun withdraw_reclaimed_collateral<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::withdraw_reclaimed_collateral_alphalend<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_reclaimed_collateral_local<T0, T1, T2>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::withdraw_reclaimed_collateral_local<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun withdraw_reclaimed_collateral_sui<T0, T1>(arg0: &mut 0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorMarket<T0, T1>, arg1: &0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::TenorBorrowCap, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x5ac772557fd1c6a218ce61fd3114e7d0da27af6e7c20241627bdc95eb64b243::tenor_market::withdraw_reclaimed_collateral_alphalend_sui<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

