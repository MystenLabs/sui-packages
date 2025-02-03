module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::primary_market {
    struct TicketPurchased has copy, drop {
        cnt_id: address,
        price: u64,
        fees: u64,
        buyer: address,
        sale_type: 0x1::string::String,
    }

    public entry fun fixed_price<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: vector<vector<u8>>, arg7: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        pre_purchase(arg0, arg2, arg4, arg5, arg6, arg8);
        let (v0, v1, v2) = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::basic_sale::fixed_price<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg9);
        post_purchase(arg0, arg4);
        let v3 = TicketPurchased{
            cnt_id    : v0,
            price     : v1,
            fees      : v2,
            buyer     : 0x2::tx_context::sender(arg9),
            sale_type : 0x1::string::utf8(b"fixed_price"),
        };
        0x2::event::emit<TicketPurchased>(v3);
    }

    public entry fun free_sale(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        pre_purchase(arg0, arg1, arg3, arg4, arg5, arg6);
        let v0 = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::basic_sale::free_sale(arg0, arg1, arg2, arg3, arg4, arg7);
        post_purchase(arg0, arg3);
        let v1 = TicketPurchased{
            cnt_id    : v0,
            price     : 0,
            fees      : 0,
            buyer     : 0x2::tx_context::sender(arg7),
            sale_type : 0x1::string::utf8(b"free"),
        };
        0x2::event::emit<TicketPurchased>(v1);
    }

    public entry fun refundable<T0>(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        pre_purchase(arg0, arg2, arg4, arg5, arg6, arg7);
        let (v0, v1) = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::basic_sale::refundable<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        post_purchase(arg0, arg4);
        let v2 = TicketPurchased{
            cnt_id    : v0,
            price     : v1,
            fees      : 0,
            buyer     : 0x2::tx_context::sender(arg8),
            sale_type : 0x1::string::utf8(b"refundable"),
        };
        0x2::event::emit<TicketPurchased>(v2);
    }

    fun create_seat_leaf(arg0: u64, arg1: 0x1::string::String) : vector<u8> {
        let v0 = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::num_utils::u64_to_str(arg0);
        let v1 = *0x1::string::bytes(&v0);
        0x1::vector::append<u8>(&mut v1, b".");
        0x1::vector::append<u8>(&mut v1, *0x1::string::bytes(&arg1));
        v1
    }

    fun post_purchase(arg0: &mut 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64) {
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::update_seats(arg0, arg1);
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::increment_tickets_sold(arg0);
    }

    fun pre_purchase(arg0: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::Event, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::get_ticket_type(arg0, arg1);
        let (v2, v3) = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::get_ticket_type_sale_time(v1);
        assert!(v0 >= v2 && v0 < v3, 0);
        let (v4, v5) = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::get_seat_range(v1);
        assert!(arg2 >= v4 && arg2 <= v5, 1);
        assert!(!0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::bitmap::is_set(0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::get_seats(arg0), arg2), 2);
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::merkle_tree::verify(0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event::get_ticket_type_mt_root(v1), arg4, create_seat_leaf(arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

