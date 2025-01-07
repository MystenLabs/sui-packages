module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::fixed_price {
    struct FixedPriceMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        price: u64,
        inventory_id: 0x2::object::ID,
    }

    struct MarketKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FixedPriceMarket<T0> {
        FixedPriceMarket<T0>{
            id           : 0x2::object::new(arg2),
            price        : arg1,
            inventory_id : arg0,
        }
    }

    public fun borrow_market<T0>(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue) : &FixedPriceMarket<T0> {
        let v0 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::borrow_market<FixedPriceMarket<T0>, MarketKey>(v0, arg0)
    }

    public entry fun buy_nft<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(0x2::tx_context::sender(arg3), arg3);
        let v2 = v0;
        let v3 = &mut v2;
        buy_nft_into_kiosk<T0, T1>(arg0, arg1, arg2, v3, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun buy_nft_<T0: store + key, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = borrow_market<T1>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_venue(arg0, arg1));
        let v1 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::buy_pseudorandom_nft<T0, T1, FixedPriceMarket<T1>, MarketKey>(arg0, v1, v0.inventory_id, arg1, 0x2::tx_context::sender(arg3), 0x2::balance::split<T1>(arg2, v0.price), arg3)
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

    public fun create_venue<T0, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_inventory<T0>(arg0, arg1);
        let v0 = new<T1>(arg1, arg3, arg4);
        let v1 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::create_venue<FixedPriceMarket<T1>, MarketKey>(arg0, v1, v0, arg2, arg4)
    }

    public entry fun init_market<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<FixedPriceMarket<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun init_venue<T0, T1>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        create_venue<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun price<T0>(arg0: &FixedPriceMarket<T0>) : u64 {
        arg0.price
    }

    public entry fun set_price<T0>(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin_or_member(arg0, arg3);
        let v0 = MarketKey{dummy_field: false};
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::market_internal_mut<FixedPriceMarket<T0>, MarketKey>(arg0, v0, arg1).price = arg2;
    }

    // decompiled from Move bytecode v6
}

