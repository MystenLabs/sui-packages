module 0xdfd24bed65c9717f8af9eb8597f8adfffff9a3ebabc18574a95671931ee45756::scallop_usdc_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        market_coin: 0x1::option::Option<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        market_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        principal_micros: u64,
        market_coin_amount: u64,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        principal_micros: u64,
        market_coin_amount: u64,
    }

    struct Withdrawn has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        market_id: 0x2::object::ID,
        principal_micros: u64,
        measured_return_micros: u64,
    }

    struct MarketCoinRecovered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        market_id: 0x2::object::ID,
        principal_micros: u64,
        market_coin_amount: u64,
    }

    fun assert_deposit_authority(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 1);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter>(arg1) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 2);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::is_paused(arg1), 3);
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4) == @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9, 5);
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3) == @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f6ac7, 12);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg2)), 4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg2, b"sui-scallop-usdc", b"sui");
    }

    fun assert_exit_authority(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &Position, arg3: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg2, 0x2::tx_context::sender(arg3));
        assert_recorded_market(&arg2.record, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1));
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1) == @0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9, 5);
        assert!(0x2::object::id_address<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg0) == @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f6ac7, 12);
        assert!(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg0) == arg2.record.version_id, 12);
        assert!(0x1::option::is_some<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(&arg2.market_coin), 13);
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

    fun close_position(arg0: &mut Position) : address {
        arg0.record.closed = true;
        arg0.record.payout_destination
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun deposit_usdc(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        deposit_usdc_for_owner(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
    }

    public fun deposit_usdc_for_owner(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority(arg0, arg1, arg2, arg3, arg4);
        assert_nonzero_owner(arg6);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5);
        assert_nonzero_principal(v0);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg4, arg5, arg7, arg8);
        let v2 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v1);
        assert!(v2 > 0, 13);
        let v3 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg4);
        let v4 = PositionRecord{
            owner              : arg6,
            payout_destination : arg6,
            market_id          : v3,
            version_id         : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version>(arg3),
            principal_micros   : v0,
            market_coin_amount : v2,
            closed             : false,
        };
        let v5 = Position{
            id          : 0x2::object::new(arg8),
            record      : v4,
            market_coin : 0x1::option::some<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(v1),
        };
        let v6 = Deposited{
            position_id        : 0x2::object::id<Position>(&v5),
            owner              : arg6,
            market_id          : v3,
            principal_micros   : v0,
            market_coin_amount : v2,
        };
        0x2::event::emit<Deposited>(v6);
        0x2::transfer::transfer<Position>(v5, arg6);
    }

    public fun market_coin_amount(arg0: &Position) : u64 {
        arg0.record.market_coin_amount
    }

    public fun market_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.market_id
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

    public fun recover_market_coin(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = arg0.record.owner;
        let v1 = 0x2::object::id<Position>(arg0);
        let v2 = arg0.record.market_id;
        let v3 = arg0.record.principal_micros;
        let v4 = arg0.record.market_coin_amount;
        let v5 = 0x1::option::extract<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(&mut arg0.market_coin);
        close_position(arg0);
        let v6 = MarketCoinRecovered{
            position_id        : v1,
            owner              : v0,
            market_id          : v2,
            principal_micros   : v3,
            market_coin_amount : v4,
        };
        0x2::event::emit<MarketCoinRecovered>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(v5, v0);
    }

    public fun version_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.version_id
    }

    public fun withdraw_all_usdc(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_exit_authority(arg0, arg1, arg2, arg4);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(&mut arg2.market_coin);
        assert!(0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&v0) == arg2.record.market_coin_amount, 13);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, v0, arg3, arg4);
        let v2 = close_position(arg2);
        let v3 = Withdrawn{
            position_id            : 0x2::object::id<Position>(arg2),
            owner                  : arg2.record.owner,
            payout_destination     : v2,
            market_id              : arg2.record.market_id,
            principal_micros       : arg2.record.principal_micros,
            measured_return_micros : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v1),
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

