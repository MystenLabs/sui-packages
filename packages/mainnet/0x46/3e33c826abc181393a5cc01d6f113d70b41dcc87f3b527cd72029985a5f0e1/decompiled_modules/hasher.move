module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher {
    public(friend) fun h_msg(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u64) : vector<u8> {
        let v0 = b"";
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg0);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg1);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg2);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg3);
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = b"";
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v2, arg0);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v2, arg1);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v2, &v1);
        let v3 = b"";
        let v4 = 0;
        while (0x1::vector::length<u8>(&v3) < arg4) {
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(&mut v2, v4);
            let v5 = 0x1::hash::sha2_256(v2);
            let v6 = 0;
            while (v6 < 0x1::vector::length<u8>(&v5) && 0x1::vector::length<u8>(&v3) < arg4) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v5, v6));
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        v3
    }

    public(friend) fun tweakable_hash(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg2: &vector<u8>) : vector<u8> {
        let v0 = tweakable_hash_start(arg0, arg1);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg2);
        tweakable_hash_finish(v0)
    }

    public(friend) fun tweakable_hash_finish(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public(friend) fun tweakable_hash_slice(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg2: &vector<u8>, arg3: u64) : vector<u8> {
        let v0 = tweakable_hash_start(arg0, arg1);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice_n16(&mut v0, arg2, arg3);
        tweakable_hash_finish(v0)
    }

    public(friend) fun tweakable_hash_start(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = *arg0;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::push_compressed(arg1, &mut v0);
        v0
    }

    public(friend) fun tweakable_hash_start_no_w6_w7(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = *arg0;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::push_compressed_no_w6_w7(arg1, &mut v0);
        v0
    }

    public(friend) fun tweakable_hash_start_no_w7(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = *arg0;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::push_compressed_no_w7(arg1, &mut v0);
        v0
    }

    public(friend) fun walk_path(arg0: vector<u8>, arg1: u32, arg2: &vector<u8>, arg3: u64, arg4: u64, arg5: &vector<u8>, arg6: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < arg4) {
            let v2 = arg1 % 2 == 0;
            let v3 = arg1 / 2;
            arg1 = v3;
            let v4 = tweakable_hash_start_no_w6_w7(arg5, arg6);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, ((v1 + 1) as u8));
            0x1::vector::push_back<u8>(&mut v4, ((v3 >> 24 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v4, ((v3 >> 16 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v4, ((v3 >> 8 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v4, ((v3 & 255) as u8));
            if (v2) {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 0));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 1));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 2));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 4));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 5));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 6));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 7));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 8));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 9));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 10));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 11));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 12));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 13));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 14));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 15));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 1));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 2));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 4));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 5));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 6));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 7));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 8));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 9));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 10));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 11));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 12));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 13));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 14));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 15));
            } else {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 1));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 2));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 4));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 5));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 6));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 7));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 8));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 9));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 10));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 11));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 12));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 13));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 14));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg2, arg3 + 15));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 0));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 1));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 2));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 3));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 4));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 5));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 6));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 7));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 8));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 9));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 10));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 11));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 12));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 13));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 14));
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, 15));
            };
            v0 = tweakable_hash_finish(v4);
            arg3 = arg3 + 16;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun walk_path_original(arg0: vector<u8>, arg1: u32, arg2: &vector<u8>, arg3: u64, arg4: u64, arg5: &vector<u8>, arg6: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg7: u64) : vector<u8> {
        let v0 = *arg6;
        let v1 = arg0;
        let v2 = 0;
        while (v2 < arg4) {
            let v3 = arg1 % 2 == 0;
            let v4 = arg1 / 2;
            arg1 = v4;
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_tree_height(&mut v0, ((v2 + 1) as u32));
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_tree_index(&mut v0, v4);
            let v5 = b"";
            if (v3) {
                0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice(&mut v5, &v1, 0, arg7);
                0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice(&mut v5, arg2, arg3, arg7);
            } else {
                0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice(&mut v5, arg2, arg3, arg7);
                0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice(&mut v5, &v1, 0, arg7);
            };
            v1 = tweakable_hash(arg5, &v0, &v5);
            arg3 = arg3 + arg7;
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

