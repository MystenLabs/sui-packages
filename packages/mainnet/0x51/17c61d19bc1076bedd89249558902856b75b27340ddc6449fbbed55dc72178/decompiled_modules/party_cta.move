module 0x5117c61d19bc1076bedd89249558902856b75b27340ddc6449fbbed55dc72178::party_cta {
    struct CtasKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Cta has copy, drop, store {
        label: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CtasSetEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        existed_before: bool,
        previous_count: u64,
        count: u64,
    }

    struct CtasClearedEvent has copy, drop {
        party_id: address,
        admin_cap_id: address,
        previous_count: u64,
    }

    public fun clear_ctas(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = CtasKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CtasKey>(v2, v3)) {
            let v4 = CtasKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::remove<CtasKey, vector<Cta>>(v2, v4);
            let v6 = CtasClearedEvent{
                party_id       : 0x2::object::id_to_address(&v0),
                admin_cap_id   : 0x2::object::id_to_address(&v1),
                previous_count : 0x1::vector::length<Cta>(&v5),
            };
            0x2::event::emit<CtasClearedEvent>(v6);
        };
    }

    public fun ctas(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : vector<Cta> {
        let v0 = CtasKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CtasKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)) {
            return 0x1::vector::empty<Cta>()
        };
        let v1 = CtasKey{dummy_field: false};
        *0x2::dynamic_field::borrow<CtasKey, vector<Cta>>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v1)
    }

    public fun has_ctas(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        let v0 = CtasKey{dummy_field: false};
        0x2::dynamic_field::exists<CtasKey>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0), v0)
    }

    public fun label(arg0: &Cta) : 0x1::string::String {
        arg0.label
    }

    public fun new_cta(arg0: 0x1::string::String, arg1: 0x1::string::String) : Cta {
        assert!(!0x1::string::is_empty(&arg0), 0);
        assert!(0x1::string::length(&arg0) <= 60, 1);
        assert!(!0x1::string::is_empty(&arg1), 2);
        assert!(0x1::string::length(&arg1) <= 2000, 3);
        Cta{
            label : arg0,
            url   : arg1,
        }
    }

    public fun set_ctas(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: vector<Cta>) {
        assert!(0x1::vector::length<Cta>(&arg2) <= 20, 4);
        let v0 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg0);
        let v1 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap>(arg1);
        let v2 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        let v3 = CtasKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<CtasKey>(v2, v3);
        let v5 = if (v4) {
            let v6 = CtasKey{dummy_field: false};
            0x1::vector::length<Cta>(0x2::dynamic_field::borrow<CtasKey, vector<Cta>>(v2, v6))
        } else {
            0
        };
        let v7 = if (v4) {
            let v8 = CtasKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CtasKey, vector<Cta>>(v2, v8) != arg2
        } else {
            true
        };
        if (v4) {
            let v9 = CtasKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CtasKey, vector<Cta>>(v2, v9) = arg2;
        } else {
            let v10 = CtasKey{dummy_field: false};
            0x2::dynamic_field::add<CtasKey, vector<Cta>>(v2, v10, arg2);
        };
        if (v7) {
            let v11 = CtasSetEvent{
                party_id       : 0x2::object::id_to_address(&v0),
                admin_cap_id   : 0x2::object::id_to_address(&v1),
                existed_before : v4,
                previous_count : v5,
                count          : 0x1::vector::length<Cta>(&arg2),
            };
            0x2::event::emit<CtasSetEvent>(v11);
        };
    }

    public fun url(arg0: &Cta) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v7
}

