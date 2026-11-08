module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::award {
    struct Award has drop {
        dummy_field: bool,
    }

    struct Opening has copy, drop {
        record_id: address,
        bid: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount,
        commit_seq: u64,
    }

    struct Inputs has copy, drop {
        openings: vector<Opening>,
        bids_closed_seq: u64,
        bids_closed_root: address,
    }

    public fun base(arg0: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>) : 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money> {
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg0)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg0);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_inventory(v0)) {
            return 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>()
        };
        let (_, _, v3, _) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::sell_inventory(v0);
        let v5 = v3;
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&v5)
    }

    public fun check(arg0: &vector<address>, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg2: u64, arg3: &0x1::string::String, arg4: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>, arg5: &0x1::option::Option<Inputs>, arg6: 0x1::option::Option<address>) : (0x1::option::Option<Award>, 0x1::option::Option<0x1::string::String>) {
        let v0 = refuse(arg0, arg1, arg2, arg3, &arg6, arg4, arg5);
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            return (0x1::option::none<Award>(), v0)
        };
        let v1 = Award{dummy_field: false};
        (0x1::option::some<Award>(v1), 0x1::option::none<0x1::string::String>())
    }

    fun deny(arg0: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0))
    }

    public fun id() : vector<u8> {
        b"award/v1"
    }

    public fun inputs_of(arg0: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::AwardInputsArg>) : 0x1::option::Option<Inputs> {
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::AwardInputsArg>(arg0)) {
            return 0x1::option::none<Inputs>()
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::AwardInputsArg>(arg0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::award_openings(v0);
        let v2 = 0x1::vector::empty<Opening>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::AwardOpeningArg>(v1)) {
            let v4 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::AwardOpeningArg>(v1, v3);
            let v5 = Opening{
                record_id  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_record_id(v4),
                bid        : *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_bid(v4),
                commit_seq : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::opening_commit_seq(v4),
            };
            0x1::vector::push_back<Opening>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = Inputs{
            openings         : v2,
            bids_closed_seq  : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::bids_closed_seq(v0),
            bids_closed_root : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::bids_closed_root(v0),
        };
        0x1::option::some<Inputs>(v6)
    }

    fun ranked(arg0: &vector<Opening>) : 0x1::option::Option<vector<u64>> {
        let v0 = 0x1::vector::length<Opening>(arg0);
        let v1 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&0x1::vector::borrow<Opening>(arg0, v2).bid);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v3)) {
                return 0x1::option::none<vector<u64>>()
            };
            0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&mut v1, 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(v3));
            v2 = v2 + 1;
        };
        let v4 = vector[];
        let v5 = vector[];
        v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<bool>(&mut v5, false);
            v2 = v2 + 1;
        };
        let v6 = 0;
        while (v6 < v0) {
            let v7 = 0;
            while (v7 < v0) {
                if (!*0x1::vector::borrow<bool>(&v5, v7)) {
                    if (v0 == v0) {
                    } else {
                        let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1, v7), 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v1, v0));
                        if (0x1::option::is_none<u8>(&v8)) {
                            return 0x1::option::none<vector<u64>>()
                        };
                        let v9 = 0x1::option::destroy_some<u8>(v8);
                        if (v9 == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::greater()) {
                        };
                    };
                };
                v7 = v7 + 1;
            };
            *0x1::vector::borrow_mut<bool>(&mut v5, v0) = true;
            0x1::vector::push_back<u64>(&mut v4, v0);
            v6 = v6 + 1;
        };
        0x1::option::some<vector<u64>>(v4)
    }

    fun record_id(arg0: &0x1::string::String, arg1: &vector<address>, arg2: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg3: &Inputs) : address {
        let v0 = 0x2::bcs::to_bytes<0x1::string::String>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3.bids_closed_seq));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3.bids_closed_root));
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::record_id(&v0)
    }

    fun refuse(arg0: &vector<address>, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Amount, arg2: u64, arg3: &0x1::string::String, arg4: &0x1::option::Option<address>, arg5: &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>, arg6: &0x1::option::Option<Inputs>) : 0x1::option::Option<0x1::string::String> {
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg5)) {
            return deny(b"NO_FACTS")
        };
        let v0 = 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts>(arg5);
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_inventory(v0)) {
            return deny(b"facts_class")
        };
        let (_, v2, _, _) = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::sell_inventory(v0);
        if (v2 < 1) {
            return deny(b"inventory")
        };
        if (0x1::option::is_none<Inputs>(arg6)) {
            return deny(b"award_inputs")
        };
        let v5 = 0x1::option::borrow<Inputs>(arg6);
        let v6 = &v5.openings;
        let v7 = if (0x1::vector::is_empty<Opening>(v6)) {
            true
        } else if (v5.bids_closed_seq == 0) {
            true
        } else {
            v5.bids_closed_root == @0x0
        };
        if (v7) {
            return deny(b"award_inputs")
        };
        if (0x1::option::is_none<address>(arg4) || record_id(arg3, arg0, arg1, v5) != *0x1::option::borrow<address>(arg4)) {
            return deny(b"award_inputs")
        };
        let v8 = ranked(v6);
        if (0x1::option::is_none<vector<u64>>(&v8)) {
            return deny(b"award_inputs")
        };
        let v9 = 0x1::option::destroy_some<vector<u64>>(v8);
        let v10 = if (arg2 < 0x1::vector::length<u64>(&v9)) {
            arg2
        } else {
            0x1::vector::length<u64>(&v9)
        };
        if (v10 == 0 || 0x1::vector::length<address>(arg0) != v10) {
            return deny(b"ranking")
        };
        let v11 = 0;
        while (v11 < v10) {
            if (0x1::vector::borrow<Opening>(v6, *0x1::vector::borrow<u64>(&v9, v11)).record_id != *0x1::vector::borrow<address>(arg0, v11)) {
                return deny(b"ranking")
            };
            v11 = v11 + 1;
        };
        let v12 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(arg1);
        let v13 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::parse(&0x1::vector::borrow<Opening>(v6, *0x1::vector::borrow<u64>(&v9, v10 - 1)).bid);
        if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v12) || 0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v13)) {
            return deny(b"pricing")
        };
        let v14 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::compare(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v12), 0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::Money>(&v13));
        if (0x1::option::is_none<u8>(&v14) || 0x1::option::destroy_some<u8>(v14) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount::equal()) {
            return deny(b"pricing")
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
                let v4 = b"inventory";
                v0 == &v4
            }
        };
        if (v2) {
            0x1::option::some<vector<u8>>(b"sell.inventory")
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    // decompiled from Move bytecode v7
}

