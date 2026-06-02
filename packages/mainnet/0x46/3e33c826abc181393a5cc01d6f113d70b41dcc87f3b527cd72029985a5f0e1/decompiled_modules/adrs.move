module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::adrs {
    struct Adrs has copy, drop {
        w0: u32,
        w1: u32,
        w2: u32,
        w3: u32,
        w4: u32,
        w5: u32,
        w6: u32,
        w7: u32,
    }

    public(friend) fun new() : Adrs {
        Adrs{
            w0 : 0,
            w1 : 0,
            w2 : 0,
            w3 : 0,
            w4 : 0,
            w5 : 0,
            w6 : 0,
            w7 : 0,
        }
    }

    public(friend) fun push_compressed(arg0: &Adrs, arg1: &mut vector<u8>) {
        0x1::vector::push_back<u8>(arg1, ((arg0.w0 & 255) as u8));
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(arg1, arg0.w2);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(arg1, arg0.w3);
        0x1::vector::push_back<u8>(arg1, ((arg0.w4 & 255) as u8));
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(arg1, arg0.w5);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(arg1, arg0.w6);
        0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils::push_u32_be(arg1, arg0.w7);
    }

    public(friend) fun push_compressed_no_w6_w7(arg0: &Adrs, arg1: &mut vector<u8>) {
        let v0 = arg0.w2;
        let v1 = arg0.w3;
        let v2 = arg0.w5;
        0x1::vector::push_back<u8>(arg1, ((arg0.w0 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((arg0.w4 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 & 255) as u8));
    }

    public(friend) fun push_compressed_no_w7(arg0: &Adrs, arg1: &mut vector<u8>) {
        let v0 = arg0.w2;
        let v1 = arg0.w3;
        let v2 = arg0.w5;
        let v3 = arg0.w6;
        0x1::vector::push_back<u8>(arg1, ((arg0.w0 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v0 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v1 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((arg0.w4 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v2 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v3 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v3 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v3 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg1, ((v3 & 255) as u8));
    }

    public(friend) fun set_chain_address(arg0: &mut Adrs, arg1: u32) {
        arg0.w6 = arg1;
    }

    public(friend) fun set_hash_address(arg0: &mut Adrs, arg1: u32) {
        arg0.w7 = arg1;
    }

    public(friend) fun set_key_pair_address(arg0: &mut Adrs, arg1: u32) {
        arg0.w5 = arg1;
    }

    public(friend) fun set_tree_height(arg0: &mut Adrs, arg1: u32) {
        arg0.w6 = arg1;
    }

    public(friend) fun set_tree_index(arg0: &mut Adrs, arg1: u32) {
        arg0.w7 = arg1;
    }

    public(friend) fun set_type_fors_roots(arg0: &mut Adrs) {
        arg0.w4 = (4 as u32);
        arg0.w6 = 0;
        arg0.w7 = 0;
    }

    public(friend) fun set_type_fors_tree(arg0: &mut Adrs) {
        arg0.w4 = (3 as u32);
        arg0.w5 = 0;
        arg0.w6 = 0;
        arg0.w7 = 0;
    }

    public(friend) fun set_type_tree(arg0: &mut Adrs) {
        arg0.w4 = (2 as u32);
        arg0.w5 = 0;
        arg0.w6 = 0;
        arg0.w7 = 0;
    }

    public(friend) fun set_type_wots_hash(arg0: &mut Adrs) {
        arg0.w4 = (0 as u32);
        arg0.w6 = 0;
        arg0.w7 = 0;
    }

    public(friend) fun set_type_wots_pk(arg0: &mut Adrs) {
        arg0.w4 = (1 as u32);
        arg0.w6 = 0;
        arg0.w7 = 0;
    }

    public(friend) fun set_xmss_height(arg0: &mut Adrs, arg1: u32) {
        arg0.w0 = arg1;
    }

    public(friend) fun set_xmss_index(arg0: &mut Adrs, arg1: u64) {
        arg0.w1 = 0;
        arg0.w2 = ((arg1 >> 32) as u32);
        arg0.w3 = ((arg1 & 4294967295) as u32);
    }

    // decompiled from Move bytecode v7
}

