module 0x5a4151b35fa8df97d9dedbff9880e7926bec8f8b4dcf6f2ee4f0e4fc07b7dc26::deallocations {
    struct Deallocations has copy, drop {
        deallocations: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Deallocation>,
    }

    struct Deallocation has copy, drop {
        amount: u64,
        is_taken: bool,
    }

    public(friend) fun contains(arg0: &Deallocations, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, Deallocation>(&arg0.deallocations, &arg1)
    }

    public(friend) fun size(arg0: &Deallocations) : u64 {
        0x2::vec_map::size<0x1::type_name::TypeName, Deallocation>(&arg0.deallocations)
    }

    public(friend) fun amount(arg0: &Deallocations, arg1: 0x1::type_name::TypeName) : u64 {
        if (!contains(arg0, arg1)) {
            return 0
        };
        0x2::vec_map::get<0x1::type_name::TypeName, Deallocation>(&arg0.deallocations, &arg1).amount
    }

    public(friend) fun deallocate(arg0: &mut Deallocations, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: bool) {
        assert!(arg2 > 0, 0);
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, Deallocation>(&arg0.deallocations, &arg1), 1);
        let v0 = Deallocation{
            amount   : arg2,
            is_taken : arg3,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Deallocation>(&mut arg0.deallocations, arg1, v0);
    }

    public(friend) fun has_all_taken(arg0: &Deallocations) : bool {
        let (_, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, Deallocation>(arg0.deallocations);
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Deallocation>(&v2)) {
            if (!0x1::vector::borrow<Deallocation>(&v2, v3).is_taken) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public(friend) fun is_taken(arg0: &Deallocations, arg1: 0x1::type_name::TypeName) : bool {
        if (!contains(arg0, arg1)) {
            return false
        };
        0x2::vec_map::get<0x1::type_name::TypeName, Deallocation>(&arg0.deallocations, &arg1).is_taken
    }

    public(friend) fun new() : Deallocations {
        Deallocations{deallocations: 0x2::vec_map::empty<0x1::type_name::TypeName, Deallocation>()}
    }

    public(friend) fun taken(arg0: &mut Deallocations, arg1: 0x1::type_name::TypeName) {
        0x2::vec_map::get_mut<0x1::type_name::TypeName, Deallocation>(&mut arg0.deallocations, &arg1).is_taken = true;
    }

    // decompiled from Move bytecode v6
}

