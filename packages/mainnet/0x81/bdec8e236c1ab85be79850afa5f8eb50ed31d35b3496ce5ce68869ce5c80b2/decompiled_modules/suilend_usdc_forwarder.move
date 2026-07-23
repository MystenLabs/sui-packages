module 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        obligation_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        principal_micros: u64,
        ctoken_amount: u64,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        principal_micros: u64,
        ctoken_amount: u64,
    }

    struct Withdrawn has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        principal_micros: u64,
        measured_return_micros: u64,
    }

    struct ObligationCapabilityRecovered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        principal_micros: u64,
    }

    fun assert_deposit_authority(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 1);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter>(arg1) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 2);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::is_paused(arg1), 3);
        assert!(0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg3) == @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1, 5);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg2)), 4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg2, b"sui-suilend-usdc", b"sui");
    }

    fun assert_exact_recorded_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 == arg2, 10);
        assert!(arg1 == arg3, 10);
    }

    fun assert_exact_recorded_obligation(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &Position, arg2: u64) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg0, arg1.record.obligation_id);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v0);
        assert_exact_recorded_shape(0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v1), 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v0)));
        let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v1, 0);
        assert_exact_recorded_deposit(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v2), arg2, arg1.record.ctoken_amount);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_coin_type(v2) == 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 10);
    }

    fun assert_exact_recorded_shape(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, 10);
        assert!(arg1 == 0, 10);
    }

    fun assert_exit_authority(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &Position, arg2: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg1, 0x2::tx_context::sender(arg2));
        assert_recorded_market(&arg1.record, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg0));
        assert!(0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg0) == @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1, 5);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg1.obligation_cap)) == arg1.record.obligation_id, 8);
    }

    fun assert_nonzero_owner(arg0: address) {
        assert!(arg0 != @0x0, 11);
    }

    fun assert_nonzero_principal(arg0: u64) {
        assert!(arg0 > 0, 9);
    }

    fun assert_recorded_market(arg0: &PositionRecord, arg1: 0x2::object::ID) {
        assert!(arg1 == arg0.market_id, 5);
    }

    fun assert_recorded_owner(arg0: &Position, arg1: address) {
        assert!(arg1 == arg0.record.owner, 6);
        assert!(!arg0.record.closed, 7);
    }

    fun close_and_take_cap(arg0: &mut Position) : (address, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        arg0.record.closed = true;
        (arg0.record.payout_destination, 0x1::option::extract<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_cap))
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun ctoken_amount(arg0: &Position) : u64 {
        arg0.record.ctoken_amount
    }

    public fun deposit_usdc(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        deposit_usdc_for_owner(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6);
    }

    public fun deposit_usdc_for_owner(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority(arg0, arg1, arg2, arg3);
        assert_nonzero_owner(arg5);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        assert_nonzero_principal(v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg7);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&v2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v1, arg6, arg4, arg7);
        let v5 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v1, &v2, arg6, v4, arg7);
        let v6 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg3);
        let v7 = PositionRecord{
            owner              : arg5,
            payout_destination : arg5,
            market_id          : v6,
            obligation_id      : v3,
            principal_micros   : v0,
            ctoken_amount      : v5,
            closed             : false,
        };
        let v8 = Position{
            id             : 0x2::object::new(arg7),
            record         : v7,
            obligation_cap : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v2),
        };
        let v9 = Deposited{
            position_id      : 0x2::object::id<Position>(&v8),
            owner            : arg5,
            market_id        : v6,
            obligation_id    : v3,
            principal_micros : v0,
            ctoken_amount    : v5,
        };
        0x2::event::emit<Deposited>(v9);
        0x2::transfer::transfer<Position>(v8, arg5);
    }

    public fun market_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.market_id
    }

    public fun obligation_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.obligation_id
    }

    public fun owner(arg0: &Position) : address {
        arg0.record.owner
    }

    public fun payout_destination(arg0: &Position) : address {
        arg0.record.payout_destination
    }

    public fun principal_micros(arg0: &Position) : u64 {
        arg0.record.principal_micros
    }

    public fun recover_obligation_cap(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = arg0.record.owner;
        let v1 = 0x2::object::id<Position>(arg0);
        let v2 = arg0.record.market_id;
        let v3 = arg0.record.obligation_id;
        let v4 = arg0.record.principal_micros;
        let (_, v6) = close_and_take_cap(arg0);
        let v7 = ObligationCapabilityRecovered{
            position_id      : v1,
            owner            : v0,
            market_id        : v2,
            obligation_id    : v3,
            principal_micros : v4,
        };
        0x2::event::emit<ObligationCapabilityRecovered>(v7);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v6, v0);
    }

    public fun withdraw_all_usdc(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_exit_authority(arg0, arg1, arg3);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        assert_exact_recorded_obligation(arg0, arg1, v0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v0, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v0, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg1.obligation_cap), arg2, arg1.record.ctoken_amount, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(), arg3);
        let (v2, v3) = close_and_take_cap(arg1);
        let v4 = Withdrawn{
            position_id            : 0x2::object::id<Position>(arg1),
            owner                  : arg1.record.owner,
            payout_destination     : v2,
            market_id              : arg1.record.market_id,
            obligation_id          : arg1.record.obligation_id,
            principal_micros       : arg1.record.principal_micros,
            measured_return_micros : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v1),
        };
        0x2::event::emit<Withdrawn>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v1, v2);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v3, arg1.record.owner);
    }

    // decompiled from Move bytecode v7
}

