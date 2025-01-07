module 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::info_type {
    struct Info has drop {
        dummy_field: bool,
    }

    struct Container has copy, drop, store {
        tier: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun attributes(arg0: &Container) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun mint(arg0: &mut 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::verification::Verifier, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::Stamp<Info, Container> {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"info_type");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"mint");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg7)));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg4));
        let v3 = Container{
            tier       : arg3,
            attributes : arg4,
        };
        0x6f6f312aab883a9f2b11b76a6a443bbc42d1c3a8b13ca373449da71393715f45::stamp::new<Info, Container>(arg0, v0, arg1, arg2, v3, arg5, arg6, arg7)
    }

    public fun tier(arg0: &Container) : 0x1::string::String {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

