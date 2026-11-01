module 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager {
    struct RewardsManager<phantom T0> has key {
        id: 0x2::object::UID,
        state_id: 0x2::object::ID,
    }

    struct WriterCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : RewardsManager<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = WriterCapKey{dummy_field: false};
        0x2::dynamic_field::add<WriterCapKey, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>>(&mut v0, v1, arg0);
        RewardsManager<T0>{
            id       : v0,
            state_id : arg1,
        }
    }

    public(friend) fun borrow_cap<T0>(arg0: &RewardsManager<T0>) : &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0> {
        let v0 = WriterCapKey{dummy_field: false};
        0x2::dynamic_field::borrow<WriterCapKey, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun share<T0>(arg0: RewardsManager<T0>) {
        0x2::transfer::share_object<RewardsManager<T0>>(arg0);
    }

    public(friend) fun state_id<T0>(arg0: &RewardsManager<T0>) : 0x2::object::ID {
        arg0.state_id
    }

    // decompiled from Move bytecode v7
}

