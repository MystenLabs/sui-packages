module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors {
    struct Fors has copy, drop {
        k: u64,
        a: u8,
        t: u32,
        sig_len: u64,
    }

    public(friend) fun a(arg0: &Fors) : u8 {
        arg0.a
    }

    fun fors_leaf(arg0: &vector<u8>, arg1: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs, arg2: &vector<u8>, arg3: u64, arg4: u32) : vector<u8> {
        let v0 = *arg1;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_tree_height(&mut v0, 0);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_tree_index(&mut v0, arg4);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_slice(arg0, &v0, arg2, arg3)
    }

    public(friend) fun k(arg0: &Fors) : u64 {
        arg0.k
    }

    fun md_to_indices(arg0: &Fors, arg1: &vector<u8>) : vector<u32> {
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::bytes_to_base_u32(arg1, arg0.a, arg0.k)
    }

    public(friend) fun new(arg0: u64, arg1: u8) : Fors {
        assert!(arg1 >= 1 && arg1 < 32, 0);
        assert!(arg0 >= 1, 1);
        Fors{
            k       : arg0,
            a       : arg1,
            t       : 1 << arg1,
            sig_len : arg0 * (1 + (arg1 as u64)) * 16,
        }
    }

    public(friend) fun pk_from_sig(arg0: &Fors, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = (arg0.a as u64);
        let v1 = md_to_indices(arg0, arg3);
        let v2 = *arg5;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_type_fors_roots(&mut v2);
        let v3 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_start(arg4, &v2);
        let v4 = 0;
        while (v4 < arg0.k) {
            let v5 = (v4 as u32) * arg0.t + *0x1::vector::borrow<u32>(&v1, v4);
            let v6 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::walk_path(fors_leaf(arg4, arg5, arg1, arg2, v5), v5, arg1, arg2 + 16, v0, arg4, arg5);
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from_slice_n16(&mut v3, &v6, 0);
            arg2 = arg2 + (1 + v0) * 16;
            v4 = v4 + 1;
        };
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::tweakable_hash_finish(v3)
    }

    public(friend) fun sig_len(arg0: &Fors) : u64 {
        arg0.sig_len
    }

    // decompiled from Move bytecode v7
}

