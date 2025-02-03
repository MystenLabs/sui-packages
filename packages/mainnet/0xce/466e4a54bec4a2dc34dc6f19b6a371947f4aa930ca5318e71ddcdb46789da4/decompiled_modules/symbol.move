module 0xce466e4a54bec4a2dc34dc6f19b6a371947f4aa930ca5318e71ddcdb46789da4::symbol {
    struct Symbol has drop, store {
        symbol: 0x1::string::String,
    }

    public fun symbol(arg0: &Symbol) : &0x1::string::String {
        &arg0.symbol
    }

    public fun add_domain(arg0: &mut 0x2::object::UID, arg1: Symbol) {
        assert_no_symbol(arg0);
        0x2::dynamic_field::add<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Symbol>, Symbol>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Symbol>(), arg1);
    }

    public fun assert_no_symbol(arg0: &0x2::object::UID) {
        assert!(!has_domain(arg0), 2);
    }

    public fun assert_symbol(arg0: &0x2::object::UID) {
        assert!(has_domain(arg0), 1);
    }

    public fun borrow_domain(arg0: &0x2::object::UID) : &Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::borrow<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Symbol>, Symbol>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Symbol>())
    }

    public fun borrow_domain_mut(arg0: &mut 0x2::object::UID) : &mut Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::borrow_mut<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Symbol>, Symbol>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Symbol>())
    }

    public fun has_domain(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Symbol>, Symbol>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Symbol>())
    }

    public fun new(arg0: 0x1::string::String) : Symbol {
        Symbol{symbol: arg0}
    }

    public fun remove_domain(arg0: &mut 0x2::object::UID) : Symbol {
        assert_symbol(arg0);
        0x2::dynamic_field::remove<0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::Marker<Symbol>, Symbol>(arg0, 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::marker<Symbol>())
    }

    public fun set_symbol<T0>(arg0: &mut Symbol, arg1: 0x1::string::String) {
        arg0.symbol = arg1;
    }

    // decompiled from Move bytecode v6
}

