module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::refund {
    struct Refund has drop {
        dummy_field: bool,
    }

    struct Terms has copy, drop, store {
        order: 0x1::string::String,
        ceiling_bps: u64,
        refundable: vector<0x1::string::String>,
        currency: 0x1::string::String,
    }

    struct Request has copy, drop {
        order: 0x1::option::Option<0x1::string::String>,
        credit: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        currency: 0x1::string::String,
    }

    public fun base(arg0: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money> {
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg0)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_case_order(v0)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        let (v1, _, v3, _) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::case_order(v0);
        let v5 = v3;
        let v6 = v1;
        let v7 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v6);
        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v5);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v7) || 0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v8)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        let v9 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v7);
        let v10 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v8);
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&v9, &v10)
    }

    public fun check(arg0: &Terms, arg1: &Request, arg2: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : (0x1::option::Option<Refund>, 0x1::option::Option<0x1::string::String>) {
        let v0 = refuse(arg0, arg1, arg2);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            return (0x1::option::none<Refund>(), v0)
        };
        let v1 = Refund{dummy_field: false};
        (0x1::option::some<Refund>(v1), 0x1::option::none<0x1::string::String>())
    }

    fun deny(arg0: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0))
    }

    public fun id() : vector<u8> {
        b"refund/v1"
    }

    public fun narrows(arg0: &Terms, arg1: &Terms) : bool {
        if (&arg0.order != &arg1.order || &arg0.currency != &arg1.currency) {
            return false
        };
        if (arg0.ceiling_bps > arg1.ceiling_bps) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.refundable)) {
            if (!0x1::vector::contains<0x1::string::String>(&arg1.refundable, 0x1::vector::borrow<0x1::string::String>(&arg0.refundable, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun parse_terms(arg0: vector<u8>) : 0x1::option::Option<Terms> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(arg0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0) || 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::length(&v0)) {
            return 0x1::option::none<Terms>()
        };
        let v1 = Terms{
            order       : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            ceiling_bps : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::read_u64(&mut v0),
            refundable  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::vec_string(&mut v0),
            currency    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
        };
        0x1::option::some<Terms>(v1)
    }

    fun refuse(arg0: &Terms, arg1: &Request, arg2: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : 0x1::option::Option<0x1::string::String> {
        if (0x1::option::is_some<0x1::string::String>(&arg1.order) && 0x1::option::borrow<0x1::string::String>(&arg1.order) != &arg0.order) {
            return deny(b"refund_order")
        };
        if (&arg1.currency != &arg0.currency) {
            return deny(b"order_currency")
        };
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg2)) {
            return deny(b"NO_FACTS")
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg2);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_case_order(v0)) {
            return deny(b"facts_class")
        };
        let (v1, v2, v3, v4) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::case_order(v0);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        if (!0x1::vector::contains<0x1::string::String>(&arg0.refundable, &v7)) {
            return deny(b"order_status")
        };
        let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v8);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v9)) {
            return deny(b"order_total")
        };
        let v10 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v6);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v10)) {
            return deny(b"prior_refunds")
        };
        if (&arg1.currency != &v5) {
            return deny(b"order_currency")
        };
        let v11 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v10);
        let v12 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v9);
        let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&v11, &v12);
        if (0x1::option::is_none<u8>(&v13)) {
            return deny(b"order_currency")
        };
        if (0x1::option::destroy_some<u8>(v13) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::less()) {
            return deny(b"order_refunded")
        };
        let v14 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::sub(&v12, &v11);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v14)) {
            return deny(b"prior_refunds")
        };
        let v15 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v14);
        let v16 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&arg1.credit, &v15);
        if (0x1::option::is_none<u8>(&v16)) {
            return deny(b"order_currency")
        };
        if (0x1::option::destroy_some<u8>(v16) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
            return deny(b"order_total")
        };
        let v17 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::scale_bps(&v15, arg0.ceiling_bps);
        let v18 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(&arg1.credit, &v17);
        if (0x1::option::is_none<u8>(&v18)) {
            return deny(b"order_currency")
        };
        if (0x1::option::destroy_some<u8>(v18) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
            return deny(b"credit_ceiling")
        };
        0x1::option::none<0x1::string::String>()
    }

    public fun request(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg2: 0x1::string::String) : Request {
        Request{
            order    : arg0,
            credit   : arg1,
            currency : arg2,
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
                let v4 = b"order_status";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"order_currency";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"order_total";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"prior_refunds";
                            if (v0 == &v7) {
                                true
                            } else {
                                let v8 = b"order_refunded";
                                if (v0 == &v8) {
                                    true
                                } else {
                                    let v9 = b"credit_ceiling";
                                    v0 == &v9
                                }
                            }
                        }
                    }
                }
            }
        };
        if (v2) {
            0x1::option::some<vector<u8>>(b"case.order")
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun terms_ceiling_bps(arg0: &Terms) : u64 {
        arg0.ceiling_bps
    }

    public fun terms_currency(arg0: &Terms) : &0x1::string::String {
        &arg0.currency
    }

    public fun terms_order(arg0: &Terms) : &0x1::string::String {
        &arg0.order
    }

    public fun terms_refundable(arg0: &Terms) : &vector<0x1::string::String> {
        &arg0.refundable
    }

    // decompiled from Move bytecode v7
}

