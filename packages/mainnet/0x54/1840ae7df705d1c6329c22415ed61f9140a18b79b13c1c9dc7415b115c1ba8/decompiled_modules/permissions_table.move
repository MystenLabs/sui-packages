module 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissions_table {
    struct PermissionsTable has store, key {
        id: 0x2::object::UID,
        length: u64,
    }

    public(friend) fun length(arg0: &PermissionsTable) : u64 {
        arg0.length
    }

    public fun destroy_empty(arg0: PermissionsTable) {
        let PermissionsTable {
            id     : v0,
            length : v1,
        } = arg0;
        assert!(v1 == 0, 1);
        0x2::object::delete(v0);
    }

    public(friend) fun add_member(arg0: &mut PermissionsTable, arg1: address, arg2: 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        0x2::dynamic_field::add<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1, arg2);
        arg0.length = arg0.length + 1;
    }

    public(friend) fun add_permission(arg0: &mut PermissionsTable, arg1: address, arg2: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::dynamic_field::borrow_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1), arg2);
    }

    public(friend) fun has_permission(arg0: &PermissionsTable, arg1: address, arg2: &0x1::type_name::TypeName) : bool {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return false
        };
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, arg1), arg2)
    }

    public fun is_member(arg0: &PermissionsTable, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.id, arg1)
    }

    public(friend) fun new_derived(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String) : PermissionsTable {
        assert!(!0x2::derived_object::exists<0x1::string::String>(arg0, arg1), 0);
        PermissionsTable{
            id     : 0x2::derived_object::claim<0x1::string::String>(arg0, arg1),
            length : 0,
        }
    }

    public fun remove_member(arg0: &mut PermissionsTable, arg1: address) {
        0x2::dynamic_field::remove<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1);
        arg0.length = arg0.length - 1;
    }

    public(friend) fun remove_permission(arg0: &mut PermissionsTable, arg1: address, arg2: &0x1::type_name::TypeName) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let v0 = 0x2::dynamic_field::borrow_mut<address, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.id, arg1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(v0, arg2);
        v0
    }

    // decompiled from Move bytecode v6
}

