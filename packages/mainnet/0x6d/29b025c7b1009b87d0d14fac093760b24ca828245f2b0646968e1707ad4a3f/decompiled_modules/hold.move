module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::hold {
    struct Hold has drop {
        dummy_field: bool,
    }

    struct Terms has copy, drop, store {
        rail: 0x1::string::String,
        escrow: 0x1::string::String,
        seller: 0x1::string::String,
        order: 0x1::string::String,
        currency: 0x1::string::String,
    }

    struct Request has copy, drop {
        seller: 0x1::string::String,
        order: 0x1::option::Option<0x1::string::String>,
        share: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money,
        escrow: 0x1::string::String,
    }

    public fun check(arg0: &Terms, arg1: &Request) : (0x1::option::Option<Hold>, 0x1::option::Option<0x1::string::String>) {
        let v0 = refuse(arg0, arg1);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            return (0x1::option::none<Hold>(), v0)
        };
        let v1 = Hold{dummy_field: false};
        (0x1::option::some<Hold>(v1), 0x1::option::none<0x1::string::String>())
    }

    fun deny(arg0: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0))
    }

    public fun id() : vector<u8> {
        b"hold/v1"
    }

    public fun narrows(arg0: &Terms, arg1: &Terms) : bool {
        if (&arg0.rail == &arg1.rail) {
            if (&arg0.escrow == &arg1.escrow) {
                if (&arg0.seller == &arg1.seller) {
                    if (&arg0.order == &arg1.order) {
                        &arg0.currency == &arg1.currency
                    } else {
                        false
                    }
                } else {
                    false
                }
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
            rail     : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            escrow   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            seller   : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            order    : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
            currency : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor::string(&mut v0),
        };
        0x1::option::some<Terms>(v1)
    }

    fun refuse(arg0: &Terms, arg1: &Request) : 0x1::option::Option<0x1::string::String> {
        if (&arg1.seller != &arg0.seller) {
            return deny(b"hold_purchase")
        };
        if (0x1::option::is_some<0x1::string::String>(&arg1.order) && 0x1::option::borrow<0x1::string::String>(&arg1.order) != &arg0.order) {
            return deny(b"hold_purchase")
        };
        if (&arg1.escrow != &arg0.escrow) {
            return deny(b"hold_escrow")
        };
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::money_currency(&arg1.share) != &arg0.currency) {
            return deny(b"hold_currency")
        };
        0x1::option::none<0x1::string::String>()
    }

    public fun request(arg0: 0x1::string::String, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money, arg3: 0x1::string::String) : Request {
        Request{
            seller : arg0,
            order  : arg1,
            share  : arg2,
            escrow : arg3,
        }
    }

    public fun rests_on(arg0: &0x1::string::String) : 0x1::option::Option<vector<u8>> {
        0x1::option::none<vector<u8>>()
    }

    public fun terms_currency(arg0: &Terms) : &0x1::string::String {
        &arg0.currency
    }

    public fun terms_escrow(arg0: &Terms) : &0x1::string::String {
        &arg0.escrow
    }

    public fun terms_order(arg0: &Terms) : &0x1::string::String {
        &arg0.order
    }

    public fun terms_rail(arg0: &Terms) : &0x1::string::String {
        &arg0.rail
    }

    public fun terms_seller(arg0: &Terms) : &0x1::string::String {
        &arg0.seller
    }

    // decompiled from Move bytecode v7
}

