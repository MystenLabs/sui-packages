module 0xe519bec2434dda98f361455e11fb3f69cf2d48ffd32d6b1af954199923eb34e9::commonLib {
    struct IpfsHash has copy, drop, store {
        hash: vector<u8>,
        hash2: vector<u8>,
    }

    public fun compose_messenger_sender_property(arg0: u8, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun getErrorInvalidIpfsHash() : u64 {
        30
    }

    public fun getIpfsDoc(arg0: vector<u8>, arg1: vector<u8>) : IpfsHash {
        IpfsHash{
            hash  : arg0,
            hash2 : arg1,
        }
    }

    public fun getIpfsHash(arg0: IpfsHash) : vector<u8> {
        arg0.hash
    }

    public fun getTimestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun getZeroId() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun get_bot_id() : 0x2::object::ID {
        0x2::object::id_from_bytes(x"0000000000000000000000000000000000000000000000000000000000000001")
    }

    public fun isEmptyIpfs(arg0: vector<u8>) : bool {
        arg0 == 0x1::vector::empty<u8>()
    }

    // decompiled from Move bytecode v6
}

