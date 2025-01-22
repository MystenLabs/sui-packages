module 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control {
    struct VersionControl has copy, drop, store {
        allowed_functions: vector<0x2::vec_set::VecSet<0x1::ascii::String>>,
    }

    public fun push_back(arg0: &mut VersionControl, arg1: vector<0x1::ascii::String>) {
        0x1::vector::push_back<0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.allowed_functions, 0x2::vec_set::from_keys<0x1::ascii::String>(arg1));
    }

    public fun allow_function(arg0: &mut VersionControl, arg1: u64, arg2: 0x1::ascii::String) {
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(0x1::vector::borrow<0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.allowed_functions, arg1), &arg2), 9223372423401963523);
        0x2::vec_set::insert<0x1::ascii::String>(0x1::vector::borrow_mut<0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.allowed_functions, arg1), arg2);
    }

    public fun allowed_functions(arg0: &mut VersionControl) : &mut vector<0x2::vec_set::VecSet<0x1::ascii::String>> {
        &mut arg0.allowed_functions
    }

    public fun check(arg0: &VersionControl, arg1: u64, arg2: 0x1::ascii::String) {
        assert!(0x2::vec_set::contains<0x1::ascii::String>(0x1::vector::borrow<0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.allowed_functions, arg1), &arg2), 9223372539365949441);
    }

    public fun disallow_function(arg0: &mut VersionControl, arg1: u64, arg2: 0x1::ascii::String) {
        assert!(0x2::vec_set::contains<0x1::ascii::String>(0x1::vector::borrow<0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.allowed_functions, arg1), &arg2), 9223372474941702149);
        0x2::vec_set::remove<0x1::ascii::String>(0x1::vector::borrow_mut<0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.allowed_functions, arg1), &arg2);
    }

    public fun latest_version(arg0: &VersionControl) : u64 {
        0x1::vector::length<0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.allowed_functions) - 1
    }

    public fun new(arg0: vector<vector<0x1::ascii::String>>) : VersionControl {
        let v0 = 0x1::vector::empty<0x2::vec_set::VecSet<0x1::ascii::String>>();
        0x1::vector::reverse<vector<0x1::ascii::String>>(&mut arg0);
        while (0x1::vector::length<vector<0x1::ascii::String>>(&arg0) != 0) {
            0x1::vector::push_back<0x2::vec_set::VecSet<0x1::ascii::String>>(&mut v0, 0x2::vec_set::from_keys<0x1::ascii::String>(0x1::vector::pop_back<vector<0x1::ascii::String>>(&mut arg0)));
        };
        0x1::vector::destroy_empty<vector<0x1::ascii::String>>(arg0);
        VersionControl{allowed_functions: v0}
    }

    // decompiled from Move bytecode v6
}

