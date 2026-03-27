module 0x52c075ec1a069700af31f3c653a70e202f8625efe5e1db686f13c4b3ae484a30::dao_init_outcome {
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

