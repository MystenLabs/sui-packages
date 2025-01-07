module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::trait {
    struct Trait has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    public fun name(arg0: &Trait) : &0x1::string::String {
        &arg0.name
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String) : Trait {
        Trait{
            name  : arg0,
            value : arg1,
        }
    }

    public fun new_batch(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : vector<Trait> {
        let v0 = 0x1::vector::empty<Trait>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg0);
        let v2 = 0;
        assert!(v1 == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        while (v2 < v1) {
            let v3 = Trait{
                name  : *0x1::vector::borrow<0x1::string::String>(&arg0, v2),
                value : *0x1::vector::borrow<0x1::string::String>(&arg1, v2),
            };
            0x1::vector::push_back<Trait>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun value(arg0: &Trait) : &0x1::string::String {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

