module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::builder_code_events {
    struct BuilderCodeCreated has copy, drop, store {
        builder_code_id: 0x2::object::ID,
        owner: address,
        builder_code_index: u64,
    }

    struct BuilderCodeSet has copy, drop, store {
        account_id: 0x2::object::ID,
        owner: address,
        builder_code_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BuilderFeesClaimed has copy, drop, store {
        builder_code_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    public(friend) fun emit_builder_code_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = BuilderCodeCreated{
            builder_code_id    : arg0,
            owner              : arg1,
            builder_code_index : arg2,
        };
        0x2::event::emit<BuilderCodeCreated>(v0);
    }

    public(friend) fun emit_builder_code_set(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BuilderCodeSet{
            account_id      : arg0,
            owner           : arg1,
            builder_code_id : arg2,
        };
        0x2::event::emit<BuilderCodeSet>(v0);
    }

    public(friend) fun emit_builder_fees_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = BuilderFeesClaimed{
            builder_code_id : arg0,
            owner           : arg1,
            amount          : arg2,
        };
        0x2::event::emit<BuilderFeesClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

