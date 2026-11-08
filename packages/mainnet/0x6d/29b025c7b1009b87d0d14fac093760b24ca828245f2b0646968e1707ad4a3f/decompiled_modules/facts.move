module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::facts {
    struct FactSnapshotRef has copy, drop, store {
        class: 0x1::string::String,
        hash: 0x1::string::String,
    }

    struct VerifiedFacts has copy, drop {
        class: 0x1::string::String,
        entry_hash: 0x1::string::String,
        typed: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts,
    }

    fun bytes_le(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::string::as_bytes(arg1);
        let v2 = if (0x1::vector::length<u8>(v0) < 0x1::vector::length<u8>(v1)) {
            0x1::vector::length<u8>(v0)
        } else {
            0x1::vector::length<u8>(v1)
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(v0, v3) < *0x1::vector::borrow<u8>(v1, v3)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(v0, v3) > *0x1::vector::borrow<u8>(v1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        0x1::vector::length<u8>(v0) <= 0x1::vector::length<u8>(v1)
    }

    public fun cite(arg0: 0x1::string::String, arg1: 0x1::string::String) : FactSnapshotRef {
        FactSnapshotRef{
            class : arg0,
            hash  : arg1,
        }
    }

    public fun cited(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg2: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>, arg3: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>) : vector<FactSnapshotRef> {
        let v0 = required_for(arg0, arg1);
        let v1 = 0x1::vector::empty<FactSnapshotRef>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v0)) {
            let v3 = find_for(arg2, 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v0, v2), arg3);
            if (0x1::option::is_some<u64>(&v3)) {
                let v4 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg2, 0x1::option::destroy_some<u64>(v3));
                0x1::vector::push_back<FactSnapshotRef>(&mut v1, cite(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_class(v4), *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_entry_hash(v4)));
            };
            v2 = v2 + 1;
        };
        let v5 = 1;
        while (v5 < 0x1::vector::length<FactSnapshotRef>(&v1)) {
            while (v5 > 0 && !bytes_le(cited_class(0x1::vector::borrow<FactSnapshotRef>(&v1, v5 - 1)), cited_class(0x1::vector::borrow<FactSnapshotRef>(&v1, v5)))) {
                0x1::vector::swap<FactSnapshotRef>(&mut v1, v5 - 1, v5);
                v5 = v5 - 1;
            };
            v5 = v5 + 1;
        };
        v1
    }

    public fun cited_class(arg0: &FactSnapshotRef) : &0x1::string::String {
        &arg0.class
    }

    public fun cited_hash(arg0: &FactSnapshotRef) : &0x1::string::String {
        &arg0.hash
    }

    public fun class(arg0: &VerifiedFacts) : &0x1::string::String {
        &arg0.class
    }

    fun find(arg0: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>, arg1: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg0)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_class(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg0, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_for(arg0: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec, arg2: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>) : 0x1::option::Option<u64> {
        if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_at(arg1) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::at_open()) {
            return find(arg0, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(arg1))
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>(arg2)) {
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::snapshot_class(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>(arg2, v0)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(arg1)) {
                let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::hex_of(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::snapshot_hash(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>(arg2, v0)));
                let v2 = 0;
                while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg0)) {
                    if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_class(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg0, v2)) == 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(arg1) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_entry_hash(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg0, v2)) == &v1) {
                        return 0x1::option::some<u64>(v2)
                    };
                    v2 = v2 + 1;
                };
                return 0x1::option::none<u64>()
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun fits(arg0: &0x1::string::String, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts) : bool {
        let v0 = b"pool.quote";
        let v1 = b"case.order";
        let v2 = b"sell.inventory";
        let v3 = b"sell.customer";
        if (0x1::string::as_bytes(arg0) == &v1 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_case_order(arg1)) {
            true
        } else if (0x1::string::as_bytes(arg0) == &v0 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_pool_quote(arg1)) {
            true
        } else if (0x1::string::as_bytes(arg0) == &v3 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_customer(arg1)) {
            true
        } else {
            0x1::string::as_bytes(arg0) == &v2 && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::is_sell_inventory(arg1)
        }
    }

    public fun gate(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg2: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>, arg3: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::SnapshotRefArg>, arg4: &0x1::option::Option<u64>, arg5: &0x1::string::String) : (vector<VerifiedFacts>, 0x1::option::Option<0x1::string::String>) {
        let v0 = required_for(arg0, arg1);
        let v1 = 0x1::vector::empty<VerifiedFacts>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v0)) {
            let v3 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&v0, v2);
            let v4 = find_for(arg2, v3, arg3);
            if (0x1::option::is_none<u64>(&v4)) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"NO_FACTS")))
            };
            let v5 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::FactArg>(arg2, 0x1::option::destroy_some<u64>(v4));
            let v6 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::parse_snapshot(*0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_record(v5));
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedSnapshot>(&v6)) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"BAD_FACTS")))
            };
            let v7 = 0x1::option::destroy_some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::ParsedSnapshot>(v6);
            let v8 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_record(&v7);
            let v9 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::try_hex(arg5);
            if (0x1::option::is_none<vector<u8>>(&v9)) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"BAD_FACTS")))
            };
            let v10 = 0x1::option::destroy_some<vector<u8>>(v9);
            let v11 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_signature(v8);
            if (0x1::option::is_none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v11) || !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::verify_ed25519(0x1::option::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::Sig>(v11), &v10, b"fact_snapshot/v1", 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_signed_bytes(&v7))) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"BAD_FACTS")))
            };
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_at(v3) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::at_open() && !is_fresh(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_fetched_at(v8), 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_max_age(v3), arg4)) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"STALE_FACTS")))
            };
            let v12 = *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_facts(v8);
            if (0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::snapshot_class(v8) != 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(v3) || !fits(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(v3), &v12)) {
                return (0x1::vector::empty<VerifiedFacts>(), 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"BAD_FACTS")))
            };
            let v13 = VerifiedFacts{
                class      : *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_name(v3),
                entry_hash : *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::input::fact_entry_hash(v5),
                typed      : v12,
            };
            0x1::vector::push_back<VerifiedFacts>(&mut v1, v13);
            v2 = v2 + 1;
        };
        (v1, 0x1::option::none<0x1::string::String>())
    }

    public fun is_fresh(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::option::Option<u64>) : bool {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_rfc3339(arg0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::parse_duration(arg1);
        let v2 = if (0x1::option::is_none<u64>(&v0)) {
            true
        } else if (0x1::option::is_none<u64>(&v1)) {
            true
        } else {
            0x1::option::is_none<u64>(arg2)
        };
        if (v2) {
            return false
        };
        let v3 = 0x1::option::destroy_some<u64>(v1);
        if (v3 > 18446744073709551615 / 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::ns_per_second()) {
            return false
        };
        let v4 = v3 * 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::time::ns_per_second();
        let v5 = 0x1::option::destroy_some<u64>(v0);
        if (v5 > 18446744073709551615 - v4) {
            return true
        };
        *0x1::option::borrow<u64>(arg2) <= v5 + v4
    }

    public fun required_for(arg0: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::CharterView, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind) : vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec> {
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::charter_fact_classes(arg0);
        let v1 = 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0)) {
            if (0x1::vector::contains<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::class_required_for(0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0, v2)), arg1)) {
                0x1::vector::push_back<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(&mut v1, *0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::FactClassSpec>(v0, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun typed(arg0: &VerifiedFacts) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::TypedFacts {
        &arg0.typed
    }

    // decompiled from Move bytecode v7
}

