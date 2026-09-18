module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_manager {
    struct RewardsManager<phantom T0> has key {
        id: 0x2::object::UID,
        state_id: 0x2::object::ID,
    }

    struct WriterCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : RewardsManager<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = WriterCapKey{dummy_field: false};
        0x2::dynamic_field::add<WriterCapKey, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>>(&mut v0, v1, arg0);
        RewardsManager<T0>{
            id       : v0,
            state_id : arg1,
        }
    }

    public(friend) fun borrow_cap<T0>(arg0: &RewardsManager<T0>) : &0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0> {
        let v0 = WriterCapKey{dummy_field: false};
        0x2::dynamic_field::borrow<WriterCapKey, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::rewards::RewardsWriterCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun share<T0>(arg0: RewardsManager<T0>) {
        0x2::transfer::share_object<RewardsManager<T0>>(arg0);
    }

    public(friend) fun state_id<T0>(arg0: &RewardsManager<T0>) : 0x2::object::ID {
        arg0.state_id
    }

    // decompiled from Move bytecode v7
}

