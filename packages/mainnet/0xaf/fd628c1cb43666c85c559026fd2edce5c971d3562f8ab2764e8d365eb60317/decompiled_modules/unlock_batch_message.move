module 0xaffd628c1cb43666c85c559026fd2edce5c971d3562f8ab2764e8d365eb60317::unlock_batch_message {
    struct UnlockBatchMessageItem {
        hash: address,
        chain_source: u16,
        token_in: address,
        addr_unlocker: address,
    }

    struct UnlockBatchMessage {
        items: vector<UnlockBatchMessageItem>,
    }

    public(friend) fun new(arg0: vector<UnlockBatchMessageItem>) : UnlockBatchMessage {
        UnlockBatchMessage{items: arg0}
    }

    public(friend) fun deserialize(arg0: vector<u8>) : UnlockBatchMessage {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 4, 0);
        let v1 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0);
        assert!(0x1::vector::length<u8>(&arg0) == (v1 as u64) * 98 + 1, 1);
        let v2 = 0x1::vector::empty<UnlockBatchMessageItem>();
        while (v1 > 0) {
            let v3 = UnlockBatchMessageItem{
                hash          : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
                chain_source  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
                token_in      : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
                addr_unlocker : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            };
            0x1::vector::push_back<UnlockBatchMessageItem>(&mut v2, v3);
            v1 = v1 - 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UnlockBatchMessage{items: v2}
    }

    public(friend) fun get_item(arg0: &UnlockBatchMessage, arg1: u16) : (address, u16, address, address) {
        assert!((arg1 as u64) < 0x1::vector::length<UnlockBatchMessageItem>(&arg0.items), 1);
        let v0 = 0x1::vector::borrow<UnlockBatchMessageItem>(&arg0.items, (arg1 as u64));
        (v0.hash, v0.chain_source, v0.token_in, v0.addr_unlocker)
    }

    public(friend) fun new_item(arg0: address, arg1: u16, arg2: address, arg3: address) : UnlockBatchMessageItem {
        UnlockBatchMessageItem{
            hash          : arg0,
            chain_source  : arg1,
            token_in      : arg2,
            addr_unlocker : arg3,
        }
    }

    public(friend) fun serialize(arg0: UnlockBatchMessage) : vector<u8> {
        let v0 = unpack(arg0);
        let v1 = 0x1::vector::empty<u8>();
        assert!(0x1::vector::length<UnlockBatchMessageItem>(&v0) <= 65535, 2);
        while (0x1::vector::length<UnlockBatchMessageItem>(&v0) > 0) {
            let UnlockBatchMessageItem {
                hash          : v2,
                chain_source  : v3,
                token_in      : v4,
                addr_unlocker : v5,
            } = 0x1::vector::pop_back<UnlockBatchMessageItem>(&mut v0);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v2));
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v1, v3);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v4));
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v5));
        };
        0x1::vector::destroy_empty<UnlockBatchMessageItem>(v0);
        assert!(0x1::vector::length<u8>(&v1) == (0x1::vector::length<UnlockBatchMessageItem>(&v0) as u64) * 98 + 1, 1);
        v1
    }

    public(friend) fun unpack(arg0: UnlockBatchMessage) : vector<UnlockBatchMessageItem> {
        let UnlockBatchMessage { items: v0 } = arg0;
        v0
    }

    public(friend) fun unpack_item(arg0: UnlockBatchMessageItem) : (address, u16, address, address) {
        let UnlockBatchMessageItem {
            hash          : v0,
            chain_source  : v1,
            token_in      : v2,
            addr_unlocker : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

