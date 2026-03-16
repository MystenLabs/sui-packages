module 0xd82616311d6b5e32b628973f3981cc28685537f2bad022177ce630df5c9c230d::portfolio {
    struct Portfolio has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        title: 0x1::string::String,
        bio: 0x1::string::String,
        github_url: 0x1::string::String,
        linkedin_url: 0x1::string::String,
    }

    struct PortfolioUpdated has copy, drop {
        portfolio_id: 0x2::object::ID,
        owner: address,
    }

    public entry fun create_portfolio(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Portfolio{
            id           : v0,
            owner        : v1,
            name         : 0x1::string::utf8(arg0),
            title        : 0x1::string::utf8(arg1),
            bio          : 0x1::string::utf8(arg2),
            github_url   : 0x1::string::utf8(arg3),
            linkedin_url : 0x1::string::utf8(arg4),
        };
        let v3 = PortfolioUpdated{
            portfolio_id : 0x2::object::uid_to_inner(&v0),
            owner        : v1,
        };
        0x2::event::emit<PortfolioUpdated>(v3);
        0x2::transfer::public_transfer<Portfolio>(v2, v1);
    }

    public entry fun update_portfolio(arg0: &mut Portfolio, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.title = 0x1::string::utf8(arg2);
        arg0.bio = 0x1::string::utf8(arg3);
        arg0.github_url = 0x1::string::utf8(arg4);
        arg0.linkedin_url = 0x1::string::utf8(arg5);
        let v0 = PortfolioUpdated{
            portfolio_id : 0x2::object::id<Portfolio>(arg0),
            owner        : arg0.owner,
        };
        0x2::event::emit<PortfolioUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

