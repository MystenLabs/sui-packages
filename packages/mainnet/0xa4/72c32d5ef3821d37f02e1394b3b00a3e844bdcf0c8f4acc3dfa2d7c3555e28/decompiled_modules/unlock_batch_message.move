module 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message {
    struct UnlockBatchMessageItem {
        hash: address,
        chain_source: u16,
        token_in: address,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        addr_unlocker: address,
        winner: address,
        fulfill_time: u64,
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
        deserialize_items(v0, 0x1::vector::length<u8>(&arg0) - 3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0))
    }

    public(friend) fun deserialize_items(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: u64, arg2: u16) : UnlockBatchMessage {
        assert!(arg1 == (arg2 as u64) * 172, 1);
        let v0 = 0x1::vector::empty<UnlockBatchMessageItem>();
        while (arg2 > 0) {
            let v1 = UnlockBatchMessageItem{
                hash           : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0, 32)),
                chain_source   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut arg0),
                token_in       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0, 32)),
                addr_ref       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0, 32)),
                fee_rate_ref   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut arg0),
                fee_rate_mayan : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut arg0),
                addr_unlocker  : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0, 32)),
                winner         : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut arg0, 32)),
                fulfill_time   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut arg0),
            };
            0x1::vector::push_back<UnlockBatchMessageItem>(&mut v0, v1);
            arg2 = arg2 - 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(arg0);
        UnlockBatchMessage{items: v0}
    }

    public(friend) fun get_item(arg0: &UnlockBatchMessage, arg1: u16) : (address, u16, address, address, u8, u8, address, address, u64) {
        assert!((arg1 as u64) < 0x1::vector::length<UnlockBatchMessageItem>(&arg0.items), 1);
        let v0 = 0x1::vector::borrow<UnlockBatchMessageItem>(&arg0.items, (arg1 as u64));
        (v0.hash, v0.chain_source, v0.token_in, v0.addr_ref, v0.fee_rate_ref, v0.fee_rate_mayan, v0.addr_unlocker, v0.winner, v0.fulfill_time)
    }

    public(friend) fun get_items_count(arg0: &UnlockBatchMessage) : u16 {
        (0x1::vector::length<UnlockBatchMessageItem>(&arg0.items) as u16)
    }

    public(friend) fun get_items_hashes(arg0: &UnlockBatchMessage) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::length<UnlockBatchMessageItem>(&arg0.items);
        while (v1 > 0) {
            0x1::vector::push_back<address>(&mut v0, 0x1::vector::borrow<UnlockBatchMessageItem>(&arg0.items, v1 - 1).hash);
            v1 = v1 - 1;
        };
        v0
    }

    public(friend) fun new_item(arg0: address, arg1: u16, arg2: address, arg3: address, arg4: u8, arg5: u8, arg6: address, arg7: address, arg8: u64) : UnlockBatchMessageItem {
        UnlockBatchMessageItem{
            hash           : arg0,
            chain_source   : arg1,
            token_in       : arg2,
            addr_ref       : arg3,
            fee_rate_ref   : arg4,
            fee_rate_mayan : arg5,
            addr_unlocker  : arg6,
            winner         : arg7,
            fulfill_time   : arg8,
        }
    }

    public(friend) fun serialize(arg0: UnlockBatchMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, (0x1::vector::length<UnlockBatchMessageItem>(&arg0.items) as u16));
        0x1::vector::append<u8>(&mut v0, serialize_items(arg0));
        v0
    }

    public(friend) fun serialize_items(arg0: UnlockBatchMessage) : vector<u8> {
        let v0 = unpack(arg0);
        assert!(0x1::vector::length<UnlockBatchMessageItem>(&v0) <= 65535, 2);
        let v1 = 0x1::vector::empty<u8>();
        while (0x1::vector::length<UnlockBatchMessageItem>(&v0) > 0) {
            let UnlockBatchMessageItem {
                hash           : v2,
                chain_source   : v3,
                token_in       : v4,
                addr_ref       : v5,
                fee_rate_ref   : v6,
                fee_rate_mayan : v7,
                addr_unlocker  : v8,
                winner         : v9,
                fulfill_time   : v10,
            } = 0x1::vector::pop_back<UnlockBatchMessageItem>(&mut v0);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v2));
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v1, v3);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v4));
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v5));
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v1, v6);
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v1, v7);
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v8));
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(v9));
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v1, v10);
        };
        0x1::vector::destroy_empty<UnlockBatchMessageItem>(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0x1::vector::length<UnlockBatchMessageItem>(&v0) * 172, 1);
        v1
    }

    public fun unlock_batch_message_item_len() : u64 {
        172
    }

    public(friend) fun unpack(arg0: UnlockBatchMessage) : vector<UnlockBatchMessageItem> {
        let UnlockBatchMessage { items: v0 } = arg0;
        v0
    }

    public(friend) fun unpack_item(arg0: UnlockBatchMessageItem) : (address, u16, address, address, u8, u8, address, address, u64) {
        let UnlockBatchMessageItem {
            hash           : v0,
            chain_source   : v1,
            token_in       : v2,
            addr_ref       : v3,
            fee_rate_ref   : v4,
            fee_rate_mayan : v5,
            addr_unlocker  : v6,
            winner         : v7,
            fulfill_time   : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v6
}

