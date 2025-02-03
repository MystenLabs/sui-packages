module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::secondary_market {
    struct Listing<phantom T0> has key {
        id: 0x2::object::UID,
        cnt_id: address,
        price: u64,
        seller: address,
        is_open: bool,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        price: 0x2::coin::Coin<T0>,
        buyer: address,
        ticket_type_id: address,
        is_open: bool,
    }

    public entry fun cancel_listing<T0>(arg0: &mut Listing<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg1), 3);
        close_listing<T0>(arg0);
    }

    public entry fun cancel_offer<T0>(arg0: &mut Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.price;
        assert!(arg0.buyer == v0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, 0x2::coin::value<T0>(v1), arg1), v0);
        close_offer<T0>(arg0);
    }

    fun close_listing<T0>(arg0: &mut Listing<T0>) {
        arg0.is_open = false;
    }

    fun close_offer<T0>(arg0: &mut Offer<T0>) {
        arg0.is_open = false;
    }

    public fun is_listing_open<T0>(arg0: &Listing<T0>) : bool {
        arg0.is_open
    }

    public entry fun list<T0>(arg0: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::Event, arg1: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::CNT, arg2: u64, arg3: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::price_oracle::ExchangeRate, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_owner(arg1) == v0, 7);
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::get_event_id(arg0) == 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_event_id(arg1), 0);
        let (v1, v2) = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_paid_amount(arg1);
        let v3 = v1;
        assert!(0x1::option::is_some<0x1::ascii::String>(&v3), 4);
        assert!(arg2 <= 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::price_oracle::exchange_value(*0x1::option::borrow<0x1::ascii::String>(&v3), 0x1::type_name::into_string(0x1::type_name::get<T0>()), v2, arg3) * (10000 + (0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::get_resale_cap_bps(arg0) as u64)) / 10000, 1);
        let v4 = Listing<T0>{
            id      : 0x2::object::new(arg4),
            cnt_id  : 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_id(arg1),
            price   : arg2,
            seller  : v0,
            is_open : true,
        };
        0x2::transfer::share_object<Listing<T0>>(v4);
    }

    public entry fun offer<T0>(arg0: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::Event, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event::has_ticket_type(arg0, &arg1), 5);
        let v0 = Offer<T0>{
            id             : 0x2::object::new(arg3),
            price          : arg2,
            buyer          : 0x2::tx_context::sender(arg3),
            ticket_type_id : arg1,
            is_open        : true,
        };
        0x2::transfer::share_object<Offer<T0>>(v0);
    }

    public entry fun purchase_listing<T0>(arg0: &mut 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::CNT, arg1: &mut Listing<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event_registry::Config, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_open, 8);
        assert!(arg1.cnt_id == 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_id(arg0), 2);
        let (v0, v1, v2) = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::market_utils::split_payable_amount<T0>(arg2, arg1.price, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v0, arg4), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v1, arg4), arg1.seller);
        0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::transfer(arg0, 0x2::tx_context::sender(arg4));
        close_listing<T0>(arg1);
    }

    public entry fun purchase_offer<T0>(arg0: &mut 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::CNT, arg1: &mut Offer<T0>, arg2: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event_registry::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_owner(arg0) == v0, 7);
        assert!(arg1.is_open, 9);
        assert!(arg1.ticket_type_id == 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::get_cnt_ticket_type_id(arg0), 5);
        let v1 = &mut arg1.price;
        let (v2, v3, v4) = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::market_utils::split_payable_amount<T0>(v1, 0x2::coin::value<T0>(v1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v2, arg3), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, v3, arg3), v0);
        0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::ticket::transfer(arg0, arg1.buyer);
        close_offer<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

