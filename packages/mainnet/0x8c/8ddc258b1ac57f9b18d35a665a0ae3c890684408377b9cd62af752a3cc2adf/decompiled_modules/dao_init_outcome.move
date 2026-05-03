module 0x8c8ddc258b1ac57f9b18d35a665a0ae3c890684408377b9cd62af752a3cc2adf::dao_init_outcome {
    struct DaoInitOutcome has copy, drop, store {
        account_id: 0x2::object::ID,
        source_id: 0x1::option::Option<0x2::object::ID>,
        kind: u8,
    }

    public fun account_id(arg0: &DaoInitOutcome) : 0x2::object::ID {
        arg0.account_id
    }

    public fun is_factory(arg0: &DaoInitOutcome) : bool {
        arg0.kind == 0 && 0x1::option::is_none<0x2::object::ID>(&arg0.source_id)
    }

    public fun is_for_raise(arg0: &DaoInitOutcome, arg1: 0x2::object::ID) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.source_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.source_id) == arg1
    }

    public fun is_launchpad_failure_for_raise(arg0: &DaoInitOutcome, arg1: 0x2::object::ID) : bool {
        arg0.kind == 2 && is_for_raise(arg0, arg1)
    }

    public fun is_launchpad_success_for_raise(arg0: &DaoInitOutcome, arg1: 0x2::object::ID) : bool {
        arg0.kind == 1 && is_for_raise(arg0, arg1)
    }

    public fun kind(arg0: &DaoInitOutcome) : u8 {
        arg0.kind
    }

    public fun kind_factory() : u8 {
        0
    }

    public fun kind_launchpad_failure() : u8 {
        2
    }

    public fun kind_launchpad_success() : u8 {
        1
    }

    public fun new_for_factory(arg0: 0x2::object::ID) : DaoInitOutcome {
        DaoInitOutcome{
            account_id : arg0,
            source_id  : 0x1::option::none<0x2::object::ID>(),
            kind       : 0,
        }
    }

    public fun new_for_launchpad_failure(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : DaoInitOutcome {
        DaoInitOutcome{
            account_id : arg0,
            source_id  : 0x1::option::some<0x2::object::ID>(arg1),
            kind       : 2,
        }
    }

    public fun new_for_launchpad_success(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : DaoInitOutcome {
        DaoInitOutcome{
            account_id : arg0,
            source_id  : 0x1::option::some<0x2::object::ID>(arg1),
            kind       : 1,
        }
    }

    public fun source_id(arg0: &DaoInitOutcome) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source_id
    }

    // decompiled from Move bytecode v6
}

