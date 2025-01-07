module 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::dao {
    struct Vote has store {
        choice: bool,
    }

    struct VoteRequest has store, key {
        id: 0x2::object::UID,
        contract_id: 0x2::object::ID,
        request: 0x1::string::String,
        yes_votes: u64,
        no_votes: u64,
        is_active: bool,
    }

    public fun end_vote(arg0: &0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::AdminCap, arg1: &mut VoteRequest) {
        arg1.is_active = false;
    }

    public fun start_vote(arg0: &mut 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::AdminCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteRequest{
            id          : 0x2::object::new(arg3),
            contract_id : arg1,
            request     : arg2,
            yes_votes   : 0,
            no_votes    : 0,
            is_active   : true,
        };
        0x2::transfer::public_share_object<VoteRequest>(v0);
    }

    public fun vote(arg0: &0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::Contract, arg1: &mut VoteRequest, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::get_contract_id(arg0), v0) == true, 0);
        assert!(arg1.is_active == true, 2);
        assert!(0x2::dynamic_field::exists_<address>(&mut arg1.id, v0) == false, 1);
        if (arg2 == true) {
            arg1.yes_votes = arg1.yes_votes + 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::get_user_shares(0x2::dynamic_field::borrow<address, 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::Shares>(0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::get_contract_id(arg0), v0));
        } else {
            arg1.no_votes = arg1.no_votes + 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::get_user_shares(0x2::dynamic_field::borrow<address, 0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::Shares>(0x4736cb3d99aad9e9856f0be783fb38908a353d44479e194a95b67110c3fad5bd::open_art_market::get_contract_id(arg0), v0));
        };
        let v1 = Vote{choice: arg2};
        0x2::dynamic_field::add<address, Vote>(&mut arg1.id, v0, v1);
    }

    // decompiled from Move bytecode v6
}

