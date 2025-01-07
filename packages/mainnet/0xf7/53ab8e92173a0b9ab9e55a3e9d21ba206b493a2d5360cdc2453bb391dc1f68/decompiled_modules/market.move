module 0xf753ab8e92173a0b9ab9e55a3e9d21ba206b493a2d5360cdc2453bb391dc1f68::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Market has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        offers: 0x2::table::Table<address, vector<0x2::object::ID>>,
        fee_percentage: u64,
        balance: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
        sell_interest: u64,
        buy_interest: u64,
        total_interest: u64,
        total_volume: u64,
        coin_type: 0x1::option::Option<0x1::string::String>,
        coin_decimals: 0x1::option::Option<u8>,
        settlement_end_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct MarketCreated has copy, drop {
        market: 0x2::object::ID,
    }

    struct MarketSettlement has copy, drop {
        market: 0x2::object::ID,
    }

    public fun new(arg0: &0x2::package::Publisher, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        let v0 = Market{
            id                          : 0x2::object::new(arg3),
            name                        : 0x1::string::utf8(arg1),
            url                         : 0x2::url::new_unsafe_from_bytes(arg2),
            offers                      : 0x2::table::new<address, vector<0x2::object::ID>>(arg3),
            fee_percentage              : 2,
            balance                     : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
            sell_interest               : 0,
            buy_interest                : 0,
            total_interest              : 0,
            total_volume                : 0,
            coin_type                   : 0x1::option::none<0x1::string::String>(),
            coin_decimals               : 0x1::option::none<u8>(),
            settlement_end_timestamp_ms : 0x1::option::none<u64>(),
        };
        let v1 = MarketCreated{market: 0x2::object::id<Market>(&v0)};
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market>(v0);
    }

    public(friend) fun add_offer(arg0: &mut Market, arg1: 0x2::object::ID, arg2: bool, arg3: bool, arg4: u64, arg5: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg6: &0x2::tx_context::TxContext) {
        update_offers(arg0, 0x2::tx_context::sender(arg6), arg1);
        0x2::coin::put<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg5);
        update_stats(arg0, arg2, arg3, arg4);
    }

    public(friend) fun assert_active(arg0: &Market, arg1: &0x2::clock::Clock) {
        assert!(status(arg0, arg1) == 0, 1);
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<MARKET>(arg0), 0);
    }

    public(friend) fun assert_closed(arg0: &Market, arg1: &0x2::clock::Clock) {
        assert!(status(arg0, arg1) == 2, 3);
    }

    public(friend) fun assert_coin_type<T0>(arg0: &Market) {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())) == 0x1::string::into_bytes(*0x1::option::borrow<0x1::string::String>(&arg0.coin_type)), 4);
    }

    public(friend) fun assert_settlement(arg0: &Market, arg1: &0x2::clock::Clock) {
        assert!(status(arg0, arg1) == 1, 2);
    }

    public(friend) fun coin_decimals(arg0: &Market) : u8 {
        *0x1::option::borrow<u8>(&arg0.coin_decimals)
    }

    public(friend) fun fee_percentage(arg0: &Market) : u64 {
        arg0.fee_percentage
    }

    public fun get_address_offers(arg0: &Market, arg1: address) : vector<0x2::object::ID> {
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.offers, arg1)
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun settlement(arg0: &mut Market, arg1: &0x2::package::Publisher, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert_admin(arg1);
        arg0.settlement_end_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg4) + 86400000);
        arg0.coin_type = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2));
        arg0.coin_decimals = 0x1::option::some<u8>(arg3);
        let v0 = MarketSettlement{market: 0x2::object::id<Market>(arg0)};
        0x2::event::emit<MarketSettlement>(v0);
    }

    public fun status(arg0: &Market, arg1: &0x2::clock::Clock) : u8 {
        if (0x1::option::is_none<u64>(&arg0.settlement_end_timestamp_ms)) {
            0
        } else if (0x2::clock::timestamp_ms(arg1) <= *0x1::option::borrow<u64>(&arg0.settlement_end_timestamp_ms)) {
            1
        } else {
            2
        }
    }

    fun update_offers(arg0: &mut Market, arg1: address, arg2: 0x2::object::ID) {
        let v0 = &mut arg0.offers;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(v0, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(v0, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(v0, arg1), arg2);
    }

    fun update_stats(arg0: &mut Market, arg1: bool, arg2: bool, arg3: u64) {
        if (arg2) {
            arg0.total_volume = arg0.total_volume + arg3;
        };
        if (arg1) {
            arg0.buy_interest = arg0.buy_interest + arg3;
        } else {
            arg0.sell_interest = arg0.sell_interest + arg3;
        };
        arg0.total_interest = arg0.total_interest + arg3;
    }

    public fun withdraw(arg0: &mut Market, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1);
        0xf753ab8e92173a0b9ab9e55a3e9d21ba206b493a2d5360cdc2453bb391dc1f68::utils::withdraw_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg2);
    }

    // decompiled from Move bytecode v6
}

