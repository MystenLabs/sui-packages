module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::xmss {
    struct Xmss has copy, drop {
        h_prime: u8,
        wots: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::Wots,
        sig_len: u64,
    }

    public(friend) fun wots(arg0: &Xmss) : &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::Wots {
        &arg0.wots
    }

    public(friend) fun pk_from_sig(arg0: &Xmss, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u32, arg5: &vector<u8>, arg6: &0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::Adrs) : vector<u8> {
        let v0 = *arg6;
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_key_pair_address(&mut v0, arg4);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs::set_type_tree(&mut v0);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::hasher::walk_path(0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::pk_from_sig(&arg0.wots, arg1, arg2, arg3, arg5, &v0), arg4, arg1, arg2 + 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::sig_len(&arg0.wots), (arg0.h_prime as u64), arg5, &v0)
    }

    public(friend) fun sig_len(arg0: &Xmss) : u64 {
        arg0.sig_len
    }

    public(friend) fun h_prime(arg0: &Xmss) : u8 {
        arg0.h_prime
    }

    public(friend) fun new(arg0: u8, arg1: 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::Wots) : Xmss {
        assert!(arg0 >= 1 && arg0 < 64, 0);
        Xmss{
            h_prime : arg0,
            wots    : arg1,
            sig_len : 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::wots::sig_len(&arg1) + (arg0 as u64) * 16,
        }
    }

    // decompiled from Move bytecode v7
}

