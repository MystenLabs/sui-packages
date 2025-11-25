module 0xa598f3c216cf5d3d36c383b54d4163dbfed8ffaff6a2cb379e4ce85c796c8930::e {
    struct Ipid has copy, drop, store {
        i: 0x1::string::String,
    }

    public fun ipie(arg0: 0x1::string::String) {
        let v0 = Ipid{i: arg0};
        0x2::event::emit<Ipid>(v0);
    }

    // decompiled from Move bytecode v6
}

