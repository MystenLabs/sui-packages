module 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::challenges {
    public(friend) fun add_credential(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"mpckitcore::shared::add_credential";
        derive(&v0, arg0, arg1, arg2)
    }

    public(friend) fun complete_future_sign(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"mpckitcore::shared::complete_future_sign";
        derive(&v0, arg0, arg1, arg2)
    }

    fun derive(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, u64_to_le_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x1::hash::sha2_256(v0)
    }

    public(friend) fun remove_credential(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"mpckitcore::shared::remove_credential";
        derive(&v0, arg0, arg1, arg2)
    }

    public(friend) fun request_future_sign(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"mpckitcore::shared::request_future_sign";
        derive(&v0, arg0, arg1, arg2)
    }

    public(friend) fun request_sign(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"mpckitcore::shared::request_sign";
        derive(&v0, arg0, arg1, arg2)
    }

    public(friend) fun set_threshold(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = u64_to_le_bytes(arg2);
        let v1 = b"mpckitcore::shared::set_threshold";
        derive(&v1, arg0, arg1, &v0)
    }

    public(friend) fun u64_to_le_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> (v1 as u8) * 8 & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

