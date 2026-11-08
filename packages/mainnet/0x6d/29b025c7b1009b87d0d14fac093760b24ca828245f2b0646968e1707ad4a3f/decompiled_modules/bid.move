module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::bid {
    struct Bid has drop {
        dummy_field: bool,
    }

    struct Terms has copy, drop, store {
        rail: 0x1::string::String,
        escrow: 0x1::string::String,
        edition: 0x1::string::String,
        currency: 0x1::string::String,
    }

    public fun check(arg0: &Terms, arg1: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg2: &0x1::string::String, arg3: bool, arg4: u64, arg5: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : (0x1::option::Option<Bid>, 0x1::option::Option<0x1::string::String>) {
        let v0 = refuse(arg0, &arg1, arg2, arg3, arg4, arg5);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            return (0x1::option::none<Bid>(), v0)
        };
        let v1 = Bid{dummy_field: false};
        (0x1::option::some<Bid>(v1), 0x1::option::none<0x1::string::String>())
    }

    fun deny(arg0: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0))
    }

    public fun id() : vector<u8> {
        b"bid/v1"
    }

    public fun parse_terms(arg0: vector<u8>) : 0x1::option::Option<Terms> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::new(arg0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::ok(&v0) || 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::pos(&v0) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::length(&v0)) {
            return 0x1::option::none<Terms>()
        };
        let v1 = Terms{
            rail     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            escrow   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            edition  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            currency : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
        };
        0x1::option::some<Terms>(v1)
    }

    fun refuse(arg0: &Terms, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg2: &0x1::string::String, arg3: bool, arg4: u64, arg5: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : 0x1::option::Option<0x1::string::String> {
        if (!arg3) {
            return 0x1::option::none<0x1::string::String>()
        };
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg5)) {
            return deny(b"NO_FACTS")
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg5);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_customer(v0)) {
            return deny(b"facts_class")
        };
        if (arg2 != &arg0.escrow) {
            return deny(b"bid_escrow")
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::money_currency(arg1) != &arg0.currency) {
            return deny(b"bid_currency")
        };
        let (_, v2) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::sell_customer(v0);
        if (v2 >= arg4) {
            return deny(b"cap_per_customer")
        };
        0x1::option::none<0x1::string::String>()
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
                let v4 = b"cap_per_customer";
                v0 == &v4
            }
        };
        if (v2) {
            0x1::option::some<vector<u8>>(b"sell.customer")
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    // decompiled from Move bytecode v7
}

