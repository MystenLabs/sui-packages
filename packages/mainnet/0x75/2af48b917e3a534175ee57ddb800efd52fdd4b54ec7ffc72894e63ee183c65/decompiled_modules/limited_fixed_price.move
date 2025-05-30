module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::limited_fixed_price {
    struct LimitedFixedPriceMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        limit: u64,
        price: u64,
        inventory_id: 0x2::object::ID,
        addresses: 0x2::vec_map::VecMap<address, u64>,
    }

    struct MarketKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LimitedFixedPriceMarket<T0> {
        LimitedFixedPriceMarket<T0>{
            id           : 0x2::object::new(arg3),
            limit        : arg1,
            price        : arg2,
            inventory_id : arg0,
            addresses    : 0x2::vec_map::empty<address, u64>(),
        }
    }

    public fun assert_limit<T0>(arg0: &LimitedFixedPriceMarket<T0>, arg1: u64) {
        assert!(arg1 <= arg0.limit, 1);
    }

    public fun borrow_count<T0>(arg0: &LimitedFixedPriceMarket<T0>, arg1: address) : u64 {
        let v0 = 0x2::vec_map::get_idx_opt<address, u64>(&arg0.addresses, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.addresses, 0x1::option::destroy_some<u64>(v0));
            *v3
        } else {
            0
        }
    }

    public fun borrow_market<T0>(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue) : &LimitedFixedPriceMarket<T0> {
        let v0 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::borrow_market<LimitedFixedPriceMarket<T0>, MarketKey>(v0, arg0)
    }

    public entry fun buy_nft<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_venue(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_live(v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_not_whitelisted(v0);
        let v1 = 0x2::coin::balance_mut<T1>(arg2);
        let v2 = buy_nft_<T0, T1>(arg0, arg1, v1, arg3);
        0x2::transfer::public_transfer<T0>(v2, 0x2::tx_context::sender(arg3));
    }

    fun buy_nft_<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::market_internal_mut<LimitedFixedPriceMarket<T1>, MarketKey>(arg0, v0, arg1);
        increment_count<T1>(v1, 0x2::tx_context::sender(arg3));
        let v2 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::buy_pseudorandom_nft<T0, T1, LimitedFixedPriceMarket<T1>, MarketKey>(arg0, v2, v1.inventory_id, arg1, 0x2::tx_context::sender(arg3), 0x2::balance::split<T1>(arg2, v1.price), arg3)
    }

    public entry fun buy_nft_into_kiosk<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_venue(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_live(v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_not_whitelisted(v0);
        let v1 = 0x2::coin::balance_mut<T1>(arg2);
        let v2 = buy_nft_<T0, T1>(arg0, arg1, v1, arg4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg3, v2, arg4);
    }

    public entry fun buy_whitelisted_nft<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist::Certificate, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg4);
        let v2 = v0;
        let v3 = &mut v2;
        buy_whitelisted_nft_into_kiosk<T0, T1>(arg0, arg1, arg2, v3, arg3, arg4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public entry fun buy_whitelisted_nft_into_kiosk<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist::Certificate, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_venue(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_live(v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist::assert_whitelist(&arg4, v0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist::burn(arg4);
        let v1 = 0x2::coin::balance_mut<T1>(arg2);
        let v2 = buy_nft_<T0, T1>(arg0, arg1, v1, arg5);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg3, v2, arg5);
    }

    public fun create_venue<T0, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_inventory<T0>(arg0, arg1);
        let v0 = new<T1>(arg1, arg3, arg4, arg5);
        let v1 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::create_venue<LimitedFixedPriceMarket<T1>, MarketKey>(arg0, v1, v0, arg2, arg5)
    }

    public fun increment_count<T0>(arg0: &mut LimitedFixedPriceMarket<T0>, arg1: address) {
        let v0 = 0x2::vec_map::get_idx_opt<address, u64>(&arg0.addresses, &arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<address, u64>(&mut arg0.addresses, 0x1::option::destroy_some<u64>(v0));
            *v2 = *v2 + 1;
            assert_limit<T0>(arg0, *v2);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.addresses, arg1, 1);
            assert_limit<T0>(arg0, 1);
        };
    }

    public entry fun init_market<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<LimitedFixedPriceMarket<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun init_venue<T0, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_venue<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun limit<T0>(arg0: &LimitedFixedPriceMarket<T0>) : u64 {
        arg0.limit
    }

    public fun price<T0>(arg0: &LimitedFixedPriceMarket<T0>) : u64 {
        arg0.price
    }

    public entry fun set_limit<T0>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin(arg0, arg3);
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::market_internal_mut<LimitedFixedPriceMarket<T0>, MarketKey>(arg0, v0, arg1);
        assert!(arg2 >= v1.limit, 2);
        v1.limit = arg2;
    }

    public entry fun set_price<T0>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin(arg0, arg3);
        let v0 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::market_internal_mut<LimitedFixedPriceMarket<T0>, MarketKey>(arg0, v0, arg1).price = arg2;
    }

    // decompiled from Move bytecode v6
}

