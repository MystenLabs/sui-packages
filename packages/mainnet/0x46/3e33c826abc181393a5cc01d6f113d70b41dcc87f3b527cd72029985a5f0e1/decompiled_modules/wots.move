module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots {
    struct Wots has copy, drop {
        lg_w: u8,
        w: u64,
        len_wots: u64,
        sig_len: u64,
        num_checksum_digits: u8,
        max_checksum: u32,
    }

    fun chain(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg2: &vector<u8>, arg3: u64, arg4: u64, arg5: u64) : vector<u8> {
        if (arg5 == 0) {
            return 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice_n16(arg2, arg3)
        };
        let v0 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_start_no_w7(arg0, arg1);
        let v1 = v0;
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::push_back<u8>(&mut v1, (arg4 as u8));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 1));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 2));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 3));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 4));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 5));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 6));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 7));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 8));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 9));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 10));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 11));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 12));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 13));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 14));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, arg3 + 15));
        let v2 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_finish(v1);
        let v3 = arg4 + 1;
        while (v3 < arg4 + arg5) {
            let v4 = v0;
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, 0);
            0x1::vector::push_back<u8>(&mut v4, (v3 as u8));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 0));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 1));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 2));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 3));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 4));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 5));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 6));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 7));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 8));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 9));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 10));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 11));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 12));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 13));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 14));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, 15));
            v2 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_finish(v4);
            v3 = v3 + 1;
        };
        v2
    }

    fun chain_original(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg2: &vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = *arg1;
        let v1 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice(arg2, arg3, arg6);
        while (arg4 < arg4 + arg5) {
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_hash_address(&mut v0, (arg4 as u32));
            let v2 = &v1;
            v1 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash(arg0, &v0, v2);
            arg4 = arg4 + 1;
        };
        v1
    }

    fun encode_message(arg0: &Wots, arg1: &vector<u8>) : vector<u32> {
        let v0 = arg0.len_wots - (arg0.num_checksum_digits as u64);
        let v1 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::bytes_to_base_u32(arg1, arg0.lg_w, v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + *0x1::vector::borrow<u32>(&v1, v3);
            v3 = v3 + 1;
        };
        let v4 = arg0.num_checksum_digits;
        while (v4 > 0) {
            v4 = v4 - 1;
            0x1::vector::push_back<u32>(&mut v1, arg0.max_checksum - v2 >> v4 * arg0.lg_w & ((arg0.w - 1) as u32));
        };
        v1
    }

    public(friend) fun len_wots(arg0: &Wots) : u64 {
        arg0.len_wots
    }

    public(friend) fun lg_w(arg0: &Wots) : u8 {
        arg0.lg_w
    }

    public(friend) fun new(arg0: u8) : Wots {
        assert!(arg0 >= 1 && arg0 <= 8, 0);
        let v0 = 8 * 16;
        assert!(v0 % (arg0 as u64) == 0, 1);
        let v1 = 1 << arg0;
        let v2 = v0 / (arg0 as u64);
        let v3 = (((v1 - 1) * v2) as u32);
        let v4 = 0;
        while (v3 > 0) {
            v4 = v4 + 1;
            v3 = v3 / (v1 as u32);
        };
        let v5 = v2 + (v4 as u64);
        Wots{
            lg_w                : arg0,
            w                   : v1,
            len_wots            : v5,
            sig_len             : v5 * 16,
            num_checksum_digits : v4,
            max_checksum        : v3,
        }
    }

    public(friend) fun pk_from_sig(arg0: &Wots, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = *arg5;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_type_wots_hash(&mut v0);
        let v1 = *arg5;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_type_wots_pk(&mut v1);
        let v2 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_start(arg4, &v1);
        let v3 = encode_message(arg0, arg3);
        let v4 = 0;
        while (v4 < arg0.len_wots) {
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_chain_address(&mut v0, (v4 as u32));
            let v5 = (*0x1::vector::borrow<u32>(&v3, v4) as u64);
            let v6 = chain(arg4, &v0, arg1, arg2 + v4 * 16, v5, arg0.w - 1 - v5);
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice_n16(&mut v2, &v6, 0);
            v4 = v4 + 1;
        };
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_finish(v2)
    }

    public(friend) fun sig_len(arg0: &Wots) : u64 {
        arg0.sig_len
    }

    public(friend) fun w(arg0: &Wots) : u64 {
        arg0.w
    }

    // decompiled from Move bytecode v7
}

