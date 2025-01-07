module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::tier {
    struct Tier has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        benefits: 0x2::vec_map::VecMap<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>,
    }

    public(friend) fun name(arg0: &Tier) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun benefits(arg0: &Tier) : &0x2::vec_map::VecMap<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit> {
        &arg0.benefits
    }

    public(friend) fun benefits_mut(arg0: &mut Tier) : &mut 0x2::vec_map::VecMap<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit> {
        &mut arg0.benefits
    }

    public(friend) fun description(arg0: &Tier) : &0x1::string::String {
        &arg0.description
    }

    public(friend) fun description_mut(arg0: &mut Tier) : &mut 0x1::string::String {
        &mut arg0.description
    }

    public(friend) fun name_mut(arg0: &mut Tier) : &mut 0x1::string::String {
        &mut arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>) : Tier {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>(&arg2)) {
            0x2::vec_map::insert<0x1::string::String, 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>(&mut v0, *0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::name(0x1::vector::borrow<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>(&arg2, v1)), *0x1::vector::borrow<0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit::Benefit>(&arg2, v1));
            v1 = v1 + 1;
        };
        Tier{
            name        : arg0,
            description : arg1,
            benefits    : v0,
        }
    }

    // decompiled from Move bytecode v6
}

