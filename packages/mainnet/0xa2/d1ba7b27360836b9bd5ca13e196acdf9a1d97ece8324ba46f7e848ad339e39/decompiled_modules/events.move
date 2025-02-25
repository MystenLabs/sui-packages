module 0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::events {
    struct StartSuperAdminTransfer has copy, drop {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        pos0: address,
    }

    struct NewAdmin has copy, drop {
        pos0: address,
    }

    struct RevokeAdmin has copy, drop {
        pos0: address,
    }

    struct Propose has copy, drop {
        id: 0x2::object::ID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        vote_type_titles: vector<0x1::string::String>,
    }

    struct Vote has copy, drop {
        proposal_id: 0x2::object::ID,
        sender: address,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        vote_type: u64,
    }

    struct Execute has copy, drop {
        proposal_id: 0x2::object::ID,
        result: 0x1::option::Option<0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::vote_type::VoteType>,
    }

    public(friend) fun execute(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::vote_type::VoteType>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Execute{
            proposal_id : arg0,
            result      : arg1,
        };
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<Execute>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun propose(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Propose{
            id               : arg0,
            title            : arg1,
            description      : arg2,
            start_time       : arg3,
            end_time         : arg4,
            vote_type_titles : arg5,
        };
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<Propose>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    public(friend) fun vote<T0: store + key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = Vote{
            proposal_id : arg0,
            sender      : 0x2::tx_context::sender(arg3),
            nft_id      : arg1,
            nft_type    : 0x1::type_name::get<T0>(),
            vote_type   : arg2,
        };
        0xa2d1ba7b27360836b9bd5ca13e196acdf9a1d97ece8324ba46f7e848ad339e39::event_wrapper::emit_event<Vote>(v0);
    }

    // decompiled from Move bytecode v6
}

