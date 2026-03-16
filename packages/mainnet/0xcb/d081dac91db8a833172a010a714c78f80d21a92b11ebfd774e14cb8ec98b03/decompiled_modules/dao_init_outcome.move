module 0xcbd081dac91db8a833172a010a714c78f80d21a92b11ebfd774e14cb8ec98b03::dao_init_outcome {
    struct DaoInitOutcome has copy, drop, store {
        account_id: 0x2::object::ID,
        source_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun account_id(arg0: &DaoInitOutcome) : 0x2::object::ID {
        arg0.account_id
    }

    public fun is_for_raise(arg0: &DaoInitOutcome, arg1: 0x2::object::ID) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.source_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.source_id) == arg1
    }

    public fun new_for_factory(arg0: 0x2::object::ID) : DaoInitOutcome {
        DaoInitOutcome{
            account_id : arg0,
            source_id  : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun new_for_launchpad(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : DaoInitOutcome {
        DaoInitOutcome{
            account_id : arg0,
            source_id  : 0x1::option::some<0x2::object::ID>(arg1),
        }
    }

    public fun source_id(arg0: &DaoInitOutcome) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source_id
    }

    // decompiled from Move bytecode v6
}

