module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::skin_type {
    struct Skin has drop {
        dummy_field: bool,
    }

    struct Container has copy, drop, store {
        fs_id: 0x1::string::String,
        guid: 0x1::string::String,
        tier: 0x1::string::String,
        champion_id: 0x1::string::String,
        skin_id: 0x1::string::String,
        effects: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun attributes(arg0: &Container) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun champion_id(arg0: &Container) : 0x1::string::String {
        arg0.champion_id
    }

    public fun effects(arg0: &Container) : 0x1::string::String {
        arg0.effects
    }

    public fun fs_id(arg0: &Container) : 0x1::string::String {
        arg0.fs_id
    }

    public fun guid(arg0: &Container) : 0x1::string::String {
        arg0.guid
    }

    public fun mint(arg0: &mut 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::Verifier, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: &0x2::clock::Clock, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) : 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<Skin, Container> {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"skin_type");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"mint");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg12)));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg9));
        let v3 = Container{
            fs_id       : arg1,
            guid        : arg2,
            tier        : arg5,
            champion_id : arg6,
            skin_id     : arg7,
            effects     : arg8,
            attributes  : arg9,
        };
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::new<Skin, Container>(arg0, v0, arg3, arg4, v3, arg10, arg11, arg12)
    }

    public fun skin_id(arg0: &Container) : 0x1::string::String {
        arg0.skin_id
    }

    public fun tier(arg0: &Container) : 0x1::string::String {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

