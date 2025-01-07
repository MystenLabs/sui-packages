module 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::cross {
    struct NormalizedSoData has copy, drop {
        transaction_id: vector<u8>,
        receiver: vector<u8>,
        source_chain_id: u16,
        sending_asset_id: vector<u8>,
        destination_chain_id: u16,
        receiving_asset_id: vector<u8>,
        amount: u256,
    }

    struct NormalizedSwapData has copy, drop {
        call_to: vector<u8>,
        approve_to: vector<u8>,
        sending_asset_id: vector<u8>,
        receiving_asset_id: vector<u8>,
        from_amount: u256,
        call_data: vector<u8>,
    }

    public fun decode_normalized_so_data(arg0: &vector<u8>) : NormalizedSoData {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 0);
        let v1 = 0;
        let v2 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v1, v1 + 8);
        let v3 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v2);
        let v4 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v1, v1 + v3);
        let v5 = v1 + v3;
        let v6 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v5, v5 + 8);
        let v7 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v6);
        let v8 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v5, v5 + v7);
        let v9 = v5 + v7;
        let v10 = 2;
        let v11 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v9, v9 + v10);
        let v12 = v9 + v10;
        let v13 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v12, v12 + 8);
        let v14 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v13);
        let v15 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v12, v12 + v14);
        let v16 = v12 + v14;
        let v17 = 2;
        let v18 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v16, v16 + v17);
        let v19 = v16 + v17;
        let v20 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v19, v19 + 8);
        let v21 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v20);
        let v22 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v19, v19 + v21);
        let v23 = v19 + v21;
        let v24 = 32;
        let v25 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v23, v23 + v24);
        assert!(v23 + v24 == v0, 0);
        NormalizedSoData{
            transaction_id       : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v4),
            receiver             : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v8),
            source_chain_id      : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u16(&v11),
            sending_asset_id     : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v15),
            destination_chain_id : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u16(&v18),
            receiving_asset_id   : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v22),
            amount               : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256(&v25),
        }
    }

    public fun decode_normalized_swap_data(arg0: &vector<u8>) : vector<NormalizedSwapData> {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 0);
        let v1 = 0;
        let v2 = 0x1::vector::empty<NormalizedSwapData>();
        let v3 = 8;
        let v4 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v1, v1 + v3);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u64(&v4);
        let v5 = v1 + v3;
        while (v5 < v0) {
            let v6 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v5, v5 + 8);
            let v7 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v6);
            let v8 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v5, v5 + v7);
            let v9 = v5 + v7;
            let v10 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v9, v9 + 8);
            let v11 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v10);
            let v12 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v9, v9 + v11);
            let v13 = v9 + v11;
            let v14 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v13, v13 + 8);
            let v15 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v14);
            let v16 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v13, v13 + v15);
            let v17 = v13 + v15;
            let v18 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v17, v17 + 8);
            let v19 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v18);
            let v20 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v17, v17 + v19);
            let v21 = v17 + v19;
            let v22 = 32;
            let v23 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v21, v21 + v22);
            let v24 = v21 + v22;
            let v25 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v24, v24 + 8);
            let v26 = 8 + 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::get_vector_length(&mut v25);
            let v27 = 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::vector_slice<u8>(arg0, v24, v24 + v26);
            v5 = v24 + v26;
            let v28 = NormalizedSwapData{
                call_to            : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v8),
                approve_to         : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v12),
                sending_asset_id   : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v16),
                receiving_asset_id : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v20),
                from_amount        : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_u256(&v23),
                call_data          : 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::deserialize_vector_with_length(&v27),
            };
            0x1::vector::push_back<NormalizedSwapData>(&mut v2, v28);
        };
        assert!(v5 == v0, 0);
        v2
    }

    public fun encode_normalized_so_data(arg0: NormalizedSoData) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, arg0.transaction_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, arg0.receiver);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u16(&mut v0, arg0.source_chain_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, arg0.sending_asset_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u16(&mut v0, arg0.destination_chain_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, arg0.receiving_asset_id);
        0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256(&mut v0, arg0.amount);
        v0
    }

    public fun encode_normalized_swap_data(arg0: vector<NormalizedSwapData>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::reverse<NormalizedSwapData>(&mut arg0);
        let v1 = 0x1::vector::length<NormalizedSwapData>(&arg0);
        if (v1 > 0) {
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u64(&mut v0, v1);
        };
        while (!0x1::vector::is_empty<NormalizedSwapData>(&arg0)) {
            let v2 = 0x1::vector::pop_back<NormalizedSwapData>(&mut arg0);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, v2.call_to);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, v2.approve_to);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, v2.sending_asset_id);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, v2.receiving_asset_id);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_u256(&mut v0, v2.from_amount);
            0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::serde::serialize_vector_with_length(&mut v0, v2.call_data);
        };
        v0
    }

    public fun padding_so_data(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : NormalizedSoData {
        NormalizedSoData{
            transaction_id       : arg0,
            receiver             : arg1,
            source_chain_id      : 0,
            sending_asset_id     : 0x1::vector::empty<u8>(),
            destination_chain_id : 0,
            receiving_asset_id   : arg2,
            amount               : 0,
        }
    }

    public fun padding_swap_data(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : NormalizedSwapData {
        NormalizedSwapData{
            call_to            : arg0,
            approve_to         : arg0,
            sending_asset_id   : arg1,
            receiving_asset_id : arg2,
            from_amount        : 0,
            call_data          : arg3,
        }
    }

    public fun so_amount(arg0: NormalizedSoData) : u256 {
        arg0.amount
    }

    public fun so_receiver(arg0: NormalizedSoData) : vector<u8> {
        arg0.receiver
    }

    public fun so_receiving_asset_id(arg0: NormalizedSoData) : vector<u8> {
        arg0.receiving_asset_id
    }

    public fun so_sending_asset_id(arg0: NormalizedSoData) : vector<u8> {
        arg0.sending_asset_id
    }

    public fun so_transaction_id(arg0: NormalizedSoData) : vector<u8> {
        arg0.transaction_id
    }

    public fun swap_call_data(arg0: NormalizedSwapData) : vector<u8> {
        arg0.call_data
    }

    public fun swap_call_to(arg0: NormalizedSwapData) : vector<u8> {
        arg0.call_to
    }

    public fun swap_from_amount(arg0: NormalizedSwapData) : u256 {
        arg0.from_amount
    }

    public fun swap_receiving_asset_id(arg0: NormalizedSwapData) : vector<u8> {
        arg0.receiving_asset_id
    }

    public fun swap_sending_asset_id(arg0: NormalizedSwapData) : vector<u8> {
        arg0.sending_asset_id
    }

    // decompiled from Move bytecode v6
}

