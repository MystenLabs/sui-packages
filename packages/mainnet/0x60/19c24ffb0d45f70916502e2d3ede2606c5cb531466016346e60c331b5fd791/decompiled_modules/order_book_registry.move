module 0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::order_book_registry {
    struct OrderBookRegistry has key {
        id: 0x2::object::UID,
        order_books: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        num_order_books: u64,
    }

    struct RegistryInitEvent has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct OrderBookRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        order_book_id: 0x2::object::ID,
    }

    public fun has_order_book(arg0: &OrderBookRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_books, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderBookRegistry{
            id              : 0x2::object::new(arg0),
            order_books     : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            num_order_books : 0,
        };
        let v1 = RegistryInitEvent{registry_id: 0x2::object::id<OrderBookRegistry>(&v0)};
        0x2::event::emit<RegistryInitEvent>(v1);
        0x2::transfer::share_object<OrderBookRegistry>(v0);
    }

    public fun num_order_books(arg0: &OrderBookRegistry) : u64 {
        arg0.num_order_books
    }

    public fun order_book_id(arg0: &OrderBookRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_books, arg1), 13906834513645928451);
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.order_books, arg1)
    }

    public(friend) fun register(arg0: &mut OrderBookRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.order_books, arg1), 13906834457811222529);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.order_books, arg1, arg2);
        arg0.num_order_books = arg0.num_order_books + 1;
        let v0 = OrderBookRegisteredEvent{
            market_id     : arg1,
            order_book_id : arg2,
        };
        0x2::event::emit<OrderBookRegisteredEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

