module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::slh_dsa {
    struct SlhDsa has copy, drop {
        pk_len: u64,
        sig_len: u64,
        m_digest: u64,
        md_bytes: u64,
        tree_bytes: u64,
        leaf_bytes: u64,
        tree_mask: u64,
        leaf_mask: u32,
        fors: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors::Fors,
        ht: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hypertree::Hypertree,
    }

    public fun sig_len(arg0: &SlhDsa) : u64 {
        arg0.sig_len
    }

    public fun verify(arg0: &SlhDsa, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = x"0000";
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v0, arg2);
        verify_internal(arg0, arg1, &v0, arg3)
    }

    public fun params_sha2_128s() : SlhDsa {
        let v0 = 9;
        let v1 = 7;
        let v2 = 12;
        let v3 = 14;
        let v4 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hypertree::new(v1, 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::new((v0 as u8), 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::new(4)));
        let v5 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors::new(v3, (v2 as u8));
        let v6 = v1 * v0;
        let v7 = (v3 * v2 + 7) / 8;
        let v8 = (v6 - v0 + 7) / 8;
        let v9 = (v0 + 7) / 8;
        assert!(v8 <= 8, 0);
        SlhDsa{
            pk_len     : 2 * 16,
            sig_len    : 16 + 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors::sig_len(&v5) + 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hypertree::sig_len(&v4),
            m_digest   : v7 + v8 + v9,
            md_bytes   : v7,
            tree_bytes : v8,
            leaf_bytes : v9,
            tree_mask  : (1 << ((v6 - v0) as u8)) - 1,
            leaf_mask  : (1 << (v0 as u8)) - 1,
            fors       : v5,
            ht         : v4,
        }
    }

    fun parse_digest(arg0: &SlhDsa, arg1: &vector<u8>) : (vector<u8>, u64, u32) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.tree_bytes) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg1, arg0.md_bytes + v1) as u64);
            v1 = v1 + 1;
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < arg0.leaf_bytes) {
            let v5 = v3 << 8;
            v3 = v5 | (*0x1::vector::borrow<u8>(arg1, arg0.md_bytes + arg0.tree_bytes + v4) as u32);
            v4 = v4 + 1;
        };
        (0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice(arg1, 0, arg0.md_bytes), v0 & arg0.tree_mask, v3 & arg0.leaf_mask)
    }

    public fun pk_len(arg0: &SlhDsa) : u64 {
        arg0.pk_len
    }

    public(friend) fun verify_internal(arg0: &SlhDsa, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg1) != arg0.pk_len) {
            return false
        };
        if (0x1::vector::length<u8>(arg3) != arg0.sig_len) {
            return false
        };
        let v0 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice_n16(arg1, 0);
        let v1 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice_n16(arg1, 16);
        let v2 = 0;
        while (v2 < 64 - 16) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v2 = v2 + 1;
        };
        let v3 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::slice_n16(arg3, 0);
        let v4 = 16;
        let v5 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::h_msg(&v3, &v0, &v1, arg2, arg0.m_digest);
        let (v6, v7, v8) = parse_digest(arg0, &v5);
        let v9 = v6;
        let v10 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::new();
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_xmss_index(&mut v10, v7);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_type_fors_tree(&mut v10);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_key_pair_address(&mut v10, v8);
        let v11 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors::pk_from_sig(&arg0.fors, arg3, v4, &v9, &v0, &v10);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hypertree::verify(&arg0.ht, arg3, v4 + 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::fors::sig_len(&arg0.fors), &v1, &v11, v7, v8, &v0)
    }

    public fun verify_or_abort(arg0: &SlhDsa, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(verify(arg0, &arg1, &arg2, &arg3), 0);
    }

    public(friend) fun verify_with_ctx(arg0: &SlhDsa, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg2);
        if (v0 > 255) {
            return false
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 0);
        0x1::vector::push_back<u8>(v2, (v0 as u8));
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v1, arg2);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::extend_from(&mut v1, arg3);
        verify_internal(arg0, arg1, &v1, arg4)
    }

    // decompiled from Move bytecode v7
}

