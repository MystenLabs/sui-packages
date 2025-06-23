module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::persistent_message {
    struct PersistentMessage has drop {
        data: vector<u8>,
    }

    public fun encode(arg0: PersistentMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.data));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : PersistentMessage {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        PersistentMessage{data: *0x1::vector::borrow<vector<u8>>(&v0, 0)}
    }

    public fun get_data(arg0: &PersistentMessage) {
    }

    public fun msg_type() : u8 {
        2
    }

    public fun new(arg0: vector<u8>) : PersistentMessage {
        PersistentMessage{data: arg0}
    }

    // decompiled from Move bytecode v6
}

