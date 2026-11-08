module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::purchase {
    struct Purchase has drop {
        dummy_field: bool,
    }

    struct Terms has copy, drop, store {
        seller: 0x1::string::String,
        order: 0x1::string::String,
        currency: 0x1::string::String,
    }

    struct Request has copy, drop {
        seller: 0x1::string::String,
        order: 0x1::option::Option<0x1::string::String>,
        total: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        quantity: u64,
    }

    public fun check(arg0: &Terms, arg1: &Request, arg2: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>) : (0x1::option::Option<Purchase>, 0x1::option::Option<0x1::string::String>) {
        let v0 = refuse(arg0, arg1, arg2, arg3, arg4);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            return (0x1::option::none<Purchase>(), v0)
        };
        let v1 = Purchase{dummy_field: false};
        (0x1::option::some<Purchase>(v1), 0x1::option::none<0x1::string::String>())
    }

    fun deny(arg0: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0))
    }

    public fun id() : vector<u8> {
        b"purchase/v1"
    }

    public fun narrows(arg0: &Terms, arg1: &Terms) : bool {
        if (&arg0.seller == &arg1.seller) {
            if (&arg0.order == &arg1.order) {
                &arg0.currency == &arg1.currency
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun parse_terms(arg0: vector<u8>) : 0x1::option::Option<Terms> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(arg0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0) || 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::length(&v0)) {
            return 0x1::option::none<Terms>()
        };
        let v1 = Terms{
            seller   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            order    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            currency : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
        };
        0x1::option::some<Terms>(v1)
    }

    fun refuse(arg0: &Terms, arg1: &Request, arg2: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>, arg3: &0x1::option::Option<u64>, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>) : 0x1::option::Option<0x1::string::String> {
        if (&arg1.seller != &arg0.seller) {
            return deny(b"purchase_seller")
        };
        if (0x1::option::is_some<0x1::string::String>(&arg1.order) && 0x1::option::borrow<0x1::string::String>(&arg1.order) != &arg0.order) {
            return deny(b"purchase_order")
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::money_currency(&arg1.total) != &arg0.currency) {
            return deny(b"quote_currency")
        };
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg2)) {
            return deny(b"NO_FACTS")
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg2);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_pool_quote(v0)) {
            return deny(b"facts_class")
        };
        let (v1, v2, v3) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::pool_quote(v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(&v5);
        let v8 = if (0x1::option::is_none<u64>(arg3)) {
            true
        } else if (0x1::option::is_none<u64>(&v7)) {
            true
        } else {
            *0x1::option::borrow<u64>(arg3) > 0x1::option::destroy_some<u64>(v7)
        };
        if (v8) {
            return deny(b"quote_expired")
        };
        let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v6);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v9)) {
            return deny(b"quote")
        };
        let v10 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v4);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v10)) {
            return deny(b"unit_price")
        };
        let v11 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v10);
        let v12 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v9);
        let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::zero_like(&v11);
        let v14 = 0;
        while (v14 < arg1.quantity) {
            let v15 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::add(&v13, &v11);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v15)) {
                return deny(b"unit_price")
            };
            v13 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v15);
            v14 = v14 + 1;
        };
        let v16 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v13, &v12);
        if (0x1::option::is_none<u8>(&v16)) {
            return deny(b"quote_currency")
        };
        if (0x1::option::destroy_some<u8>(v16) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::equal()) {
            return deny(b"quote_arithmetic")
        };
        let v17 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&arg1.total, &v12);
        if (0x1::option::is_none<u8>(&v17)) {
            return deny(b"quote_currency")
        };
        if (0x1::option::destroy_some<u8>(v17) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
            return deny(b"quote_total")
        };
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(arg4)) {
            return deny(b"purchase_holds")
        };
        let v18 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&arg1.total, 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(arg4));
        if (0x1::option::is_none<u8>(&v18)) {
            return deny(b"quote_currency")
        };
        if (0x1::option::destroy_some<u8>(v18) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
            return deny(b"purchase_holds")
        };
        0x1::option::none<0x1::string::String>()
    }

    public fun request(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg3: u64) : Request {
        Request{
            seller   : arg0,
            order    : arg1,
            total    : arg2,
            quantity : arg3,
        }
    }

    public fun rests_on(arg0: &0x1::string::String) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"NO_FACTS";
        let v2 = if (v0 == &v1) {
            true
        } else {
            let v3 = b"facts_class";
            if (v0 == &v3) {
                true
            } else {
                let v4 = b"quote";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"unit_price";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"quote_currency";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"quote_expired";
                            if (v0 == &v7) {
                                true
                            } else {
                                let v8 = b"quote_arithmetic";
                                if (v0 == &v8) {
                                    true
                                } else {
                                    let v9 = b"quote_total";
                                    v0 == &v9
                                }
                            }
                        }
                    }
                }
            }
        };
        if (v2) {
            0x1::option::some<vector<u8>>(b"pool.quote")
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun terms_currency(arg0: &Terms) : &0x1::string::String {
        &arg0.currency
    }

    public fun terms_order(arg0: &Terms) : &0x1::string::String {
        &arg0.order
    }

    public fun terms_seller(arg0: &Terms) : &0x1::string::String {
        &arg0.seller
    }

    // decompiled from Move bytecode v7
}

