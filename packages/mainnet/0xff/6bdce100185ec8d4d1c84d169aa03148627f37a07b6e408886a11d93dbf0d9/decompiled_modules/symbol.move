module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::symbol {
    struct Symbol has drop, store {
        symbol: 0x1::string::String,
    }

    public fun symbol(arg0: &Symbol) : &0x1::string::String {
        &arg0.symbol
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: Symbol) {
        assert_no_symbol(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Symbol>, Symbol>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Symbol>(), arg1);
    }

    public fun assert_no_symbol(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_symbol(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Symbol>, Symbol>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Symbol>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Symbol>, Symbol>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Symbol>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Symbol>, Symbol>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Symbol>())
    }

    public fun new(arg0: 0x1::string::String) : Symbol {
        Symbol{symbol: arg0}
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<Symbol>, Symbol>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<Symbol>())
    }

    public fun set_symbol<T0>(arg0: &mut Symbol, arg1: 0x1::string::String) {
        arg0.symbol = arg1;
    }

    // decompiled from Move bytecode v6
}

