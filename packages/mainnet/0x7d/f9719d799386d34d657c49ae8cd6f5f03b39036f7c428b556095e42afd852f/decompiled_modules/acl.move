module 0x7df9719d799386d34d657c49ae8cd6f5f03b39036f7c428b556095e42afd852f::acl {
    struct BranchACL has key {
        id: 0x2::object::UID,
        tree_id: 0x2::object::ID,
        branch: 0x1::string::String,
        memwal_namespace: 0x1::string::String,
        merge_authority: 0x1::option::Option<0x2::object::ID>,
    }

    public fun branch(arg0: &BranchACL) : &0x1::string::String {
        &arg0.branch
    }

    public fun create(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = BranchACL{
            id               : 0x2::object::new(arg3),
            tree_id          : arg0,
            branch           : arg1,
            memwal_namespace : arg2,
            merge_authority  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<BranchACL>(v0);
        0x2::object::id<BranchACL>(&v0)
    }

    public fun memwal_namespace(arg0: &BranchACL) : &0x1::string::String {
        &arg0.memwal_namespace
    }

    public fun merge_authority(arg0: &BranchACL) : &0x1::option::Option<0x2::object::ID> {
        &arg0.merge_authority
    }

    public fun set_merge_authority(arg0: &mut BranchACL, arg1: 0x1::option::Option<0x2::object::ID>) {
        arg0.merge_authority = arg1;
    }

    public fun tree_id(arg0: &BranchACL) : 0x2::object::ID {
        arg0.tree_id
    }

    // decompiled from Move bytecode v6
}

