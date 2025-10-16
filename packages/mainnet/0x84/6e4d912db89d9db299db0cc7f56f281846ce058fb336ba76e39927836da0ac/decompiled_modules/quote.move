module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote {
    struct QuoteVerifier has store, key {
        id: 0x2::object::UID,
        queue: 0x2::object::ID,
        quotes: 0x2::table::Table<vector<u8>, Quote>,
    }

    struct Quotes has drop {
        quotes: vector<Quote>,
        oracles: vector<0x2::object::ID>,
        queue_id: 0x2::object::ID,
    }

    struct Quote has copy, drop, store {
        feed_id: vector<u8>,
        result: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal,
        timestamp_ms: u64,
        slot: u64,
    }

    public fun length(arg0: &Quotes) : u64 {
        0x1::vector::length<Quote>(&arg0.quotes)
    }

    public fun timestamp_ms(arg0: &Quote) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun new(arg0: vector<u8>, arg1: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal, arg2: u64, arg3: u64) : Quote {
        Quote{
            feed_id      : arg0,
            result       : arg1,
            timestamp_ms : arg2,
            slot         : arg3,
        }
    }

    public fun delete_verifier(arg0: QuoteVerifier) {
        let QuoteVerifier {
            id     : v0,
            queue  : _,
            quotes : v2,
        } = arg0;
        0x2::table::drop<vector<u8>, Quote>(v2);
        0x2::object::delete(v0);
    }

    public fun feed_id(arg0: &Quote) : vector<u8> {
        arg0.feed_id
    }

    public fun get(arg0: &Quotes, arg1: vector<u8>) : Quote {
        let v0 = get_as_option(arg0, arg1);
        assert!(0x1::option::is_some<Quote>(&v0), 13906835084876447745);
        0x1::option::extract<Quote>(&mut v0)
    }

    public fun get_as_option(arg0: &Quotes, arg1: vector<u8>) : 0x1::option::Option<Quote> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Quote>(&arg0.quotes)) {
            let v1 = 0x1::vector::borrow<Quote>(&arg0.quotes, v0);
            if (v1.feed_id == arg1) {
                return 0x1::option::some<Quote>(*v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Quote>()
    }

    public fun get_quote(arg0: &QuoteVerifier, arg1: vector<u8>) : &Quote {
        0x2::table::borrow<vector<u8>, Quote>(&arg0.quotes, arg1)
    }

    public(friend) fun new_quotes(arg0: vector<Quote>, arg1: vector<0x2::object::ID>, arg2: 0x2::object::ID) : Quotes {
        Quotes{
            quotes   : arg0,
            oracles  : arg1,
            queue_id : arg2,
        }
    }

    public fun new_verifier(arg0: &mut 0x2::tx_context::TxContext, arg1: 0x2::object::ID) : QuoteVerifier {
        QuoteVerifier{
            id     : 0x2::object::new(arg0),
            queue  : arg1,
            quotes : 0x2::table::new<vector<u8>, Quote>(arg0),
        }
    }

    public fun oracles(arg0: &Quotes) : vector<0x2::object::ID> {
        arg0.oracles
    }

    public fun queue_id(arg0: &Quotes) : 0x2::object::ID {
        arg0.queue_id
    }

    public fun quote_exists(arg0: &QuoteVerifier, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Quote>(&arg0.quotes, arg1)
    }

    public fun quotes_vec(arg0: &Quotes) : vector<Quote> {
        arg0.quotes
    }

    public fun result(arg0: &Quote) : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal {
        arg0.result
    }

    public fun slot(arg0: &Quote) : u64 {
        arg0.slot
    }

    public fun verify_quotes(arg0: &mut QuoteVerifier, arg1: &Quotes, arg2: &0x2::clock::Clock) {
        assert!(arg1.queue_id == arg0.queue, 13906834788523835395);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Quote>(&arg1.quotes)) {
            let v1 = 0x1::vector::borrow<Quote>(&arg1.quotes, v0);
            if (v1.timestamp_ms > 0x2::clock::timestamp_ms(arg2)) {
                continue
            };
            let v2 = get_quote(arg0, v1.feed_id);
            if (v1.timestamp_ms > v2.timestamp_ms) {
                if (!0x2::table::contains<vector<u8>, Quote>(&arg0.quotes, v1.feed_id)) {
                    0x2::table::add<vector<u8>, Quote>(&mut arg0.quotes, v1.feed_id, *v1);
                } else {
                    *0x2::table::borrow_mut<vector<u8>, Quote>(&mut arg0.quotes, v1.feed_id) = *v1;
                };
            } else if (v1.timestamp_ms == v2.timestamp_ms && v1.slot > v2.slot) {
                if (!0x2::table::contains<vector<u8>, Quote>(&arg0.quotes, v1.feed_id)) {
                    0x2::table::add<vector<u8>, Quote>(&mut arg0.quotes, v1.feed_id, *v1);
                } else {
                    *0x2::table::borrow_mut<vector<u8>, Quote>(&mut arg0.quotes, v1.feed_id) = *v1;
                };
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

