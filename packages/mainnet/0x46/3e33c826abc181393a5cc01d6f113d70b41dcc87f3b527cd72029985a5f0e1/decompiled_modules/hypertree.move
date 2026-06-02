module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hypertree {
    struct Hypertree has copy, drop {
        d: u64,
        xmss: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::Xmss,
        sig_len: u64,
        leaf_mask: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::Xmss) : Hypertree {
        assert!(arg0 >= 1, 0);
        Hypertree{
            d         : arg0,
            xmss      : arg1,
            sig_len   : arg0 * 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::sig_len(&arg1),
            leaf_mask : (1 << 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::h_prime(&arg1)) - 1,
        }
    }

    public(friend) fun d(arg0: &Hypertree) : u64 {
        arg0.d
    }

    public(friend) fun xmss(arg0: &Hypertree) : &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::Xmss {
        &arg0.xmss
    }

    public(friend) fun sig_len(arg0: &Hypertree) : u64 {
        arg0.sig_len
    }

    public(friend) fun verify(arg0: &Hypertree, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: &vector<u8>, arg5: u64, arg6: u32, arg7: &vector<u8>) : bool {
        let v0 = *arg4;
        let v1 = 0;
        while (v1 < arg0.d) {
            let v2 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::new();
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_xmss_height(&mut v2, (v1 as u32));
            0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_xmss_index(&mut v2, arg5);
            let v3 = &v0;
            v0 = 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::pk_from_sig(&arg0.xmss, arg1, arg2 + v1 * 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::sig_len(&arg0.xmss), v3, arg6, arg7, &v2);
            if (v1 + 1 < arg0.d) {
                arg6 = ((arg5 & arg0.leaf_mask) as u32);
                arg5 = arg5 >> 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss::h_prime(&arg0.xmss);
            };
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u8>(arg3) != 16) {
            return false
        };
        let v4 = 0;
        while (v4 < 16) {
            if (*0x1::vector::borrow<u8>(&v0, v4) != *0x1::vector::borrow<u8>(arg3, v4)) {
                return false
            };
            v4 = v4 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

