module 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::company {
    struct Company has store, key {
        id: 0x2::object::UID,
    }

    struct CompanyDataV1 has store {
        name: 0x1::string::String,
        completed_payouts: u64,
    }

    struct CompanyCreatedV1 has copy, drop {
        id: 0x2::object::ID,
    }

    entry fun new(arg0: &mut 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::Platform, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::assert_current_version(arg0);
        let v0 = Company{id: 0x2::object::new(arg2)};
        let v1 = CompanyDataV1{
            name              : arg1,
            completed_payouts : 0,
        };
        let v2 = 0x2::object::uid_to_inner(&v0.id);
        let v3 = CompanyCreatedV1{id: v2};
        0x2::event::emit<CompanyCreatedV1>(v3);
        0x2::dynamic_field::add<vector<u8>, CompanyDataV1>(&mut v0.id, b"data_v1", v1);
        0x2::dynamic_field::add<0x2::object::ID, Company>(0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::uid_mut(arg0), v2, v0);
    }

    public(friend) fun self(arg0: &0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::Platform, arg1: 0x2::object::ID) : &Company {
        0x2::dynamic_field::borrow<0x2::object::ID, Company>(0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::uid(arg0), arg1)
    }

    public(friend) fun self_mut(arg0: &mut 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::Platform, arg1: 0x2::object::ID) : &mut Company {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, Company>(0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform::uid_mut(arg0), arg1)
    }

    public(friend) fun uid(arg0: &Company) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Company) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_completed_payouts(arg0: &mut Company) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, CompanyDataV1>(uid_mut(arg0), b"data_v1");
        v0.completed_payouts = v0.completed_payouts + 1;
    }

    // decompiled from Move bytecode v6
}

