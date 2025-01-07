module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::space {
    struct Space has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tiers: 0x2::linked_table::LinkedTable<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>,
    }

    public(friend) fun drop(arg0: Space) {
        let Space {
            id    : v0,
            name  : _,
            tiers : v2,
        } = arg0;
        0x2::linked_table::drop<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(v2);
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>, arg2: &mut 0x2::tx_context::TxContext) : Space {
        let v0 = 0x2::linked_table::new<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(arg2);
        let v1 = 0x1::vector::length<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(&arg1);
        let v2 = 0;
        assert!(v1 <= 3, 0);
        assert!(v1 > 0, 1);
        while (v2 < v1) {
            v2 = v2 + 1;
            let v3 = 0x1::vector::pop_back<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(&mut arg1);
            0x2::linked_table::push_front<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier>(&mut v0, *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::name(&v3), v3);
        };
        Space{
            id    : 0x2::object::new(arg2),
            name  : arg0,
            tiers : v0,
        }
    }

    public(friend) fun name(arg0: &Space) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun name_mut(arg0: &mut Space) : &mut 0x1::string::String {
        &mut arg0.name
    }

    public(friend) fun share(arg0: Space) {
        0x2::transfer::share_object<Space>(arg0);
    }

    public(friend) fun tiers(arg0: &Space) : &0x2::linked_table::LinkedTable<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier> {
        &arg0.tiers
    }

    public(friend) fun tiers_mut(arg0: &mut Space) : &mut 0x2::linked_table::LinkedTable<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier::Tier> {
        &mut arg0.tiers
    }

    // decompiled from Move bytecode v6
}

