module 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::client {
    struct HeaderMeta has store {
        witness: u64,
        key: vector<u8>,
        merkle_root: vector<u8>,
        block_id: vector<u8>,
        verified: bool,
    }

    struct SwaplockLightClient has key {
        id: 0x2::object::UID,
        witnesses: 0x2::vec_map::VecMap<u64, vector<u8>>,
        metas: 0x2::table::Table<u32, HeaderMeta>,
        head_block_num: u32,
        head_id: vector<u8>,
        verified_head: u32,
        anchor_block_num: u32,
        anchor_id: vector<u8>,
        tail_next: u32,
        finality_threshold: u64,
        retention_blocks: u32,
    }

    struct LightClientAdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun compute_block_id(arg0: u32, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = *arg1;
        0x1::vector::append<u8>(&mut v0, *arg2);
        let v1 = 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::sha224::hash(v0);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v2, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v2, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v2, ((arg0 & 255) as u8));
        let v3 = 4;
        while (v3 < 20) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public fun create(arg0: &0x9d21d4a7bba0666f36ddd4a8246aa7327c028ba587eb6f18861011e4f8ce1bc4::core::AdminCap, arg1: vector<u64>, arg2: vector<vector<u8>>, arg3: u32, arg4: vector<u8>, arg5: u64, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        new_light_client(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun distinct_witnesses_above(arg0: &SwaplockLightClient, arg1: u32) : u64 {
        let v0 = 0x2::vec_map::empty<u64, bool>();
        let v1 = arg1 + 1;
        while (v1 <= arg0.head_block_num) {
            if (0x2::table::contains<u32, HeaderMeta>(&arg0.metas, v1)) {
                let v2 = 0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, v1);
                if (v2.verified && !0x2::vec_map::contains<u64, bool>(&v0, &v2.witness)) {
                    0x2::vec_map::insert<u64, bool>(&mut v0, v2.witness, true);
                };
            };
            v1 = v1 + 1;
        };
        0x2::vec_map::size<u64, bool>(&v0)
    }

    public fun evict_unverified_tip(arg0: &mut SwaplockLightClient, arg1: u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < arg1 && arg0.head_block_num > arg0.verified_head) {
            let v2 = arg0.head_block_num;
            if (0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, v2).verified) {
                break
            };
            let HeaderMeta {
                witness     : _,
                key         : _,
                merkle_root : _,
                block_id    : _,
                verified    : _,
            } = 0x2::table::remove<u32, HeaderMeta>(&mut arg0.metas, v2);
            arg0.head_block_num = v2 - 1;
            v1 = true;
            v0 = v0 + 1;
        };
        assert!(v1, 6);
        let v8 = if (arg0.head_block_num == arg0.anchor_block_num) {
            arg0.anchor_id
        } else {
            0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, arg0.head_block_num).block_id
        };
        arg0.head_id = v8;
    }

    public fun has_root(arg0: &SwaplockLightClient, arg1: u32) : bool {
        0x2::table::contains<u32, HeaderMeta>(&arg0.metas, arg1)
    }

    public fun has_witness(arg0: &SwaplockLightClient, arg1: u64) : bool {
        0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &arg1)
    }

    public fun head(arg0: &SwaplockLightClient) : u32 {
        arg0.head_block_num
    }

    public fun is_final(arg0: &SwaplockLightClient, arg1: u32) : bool {
        if (0x2::table::contains<u32, HeaderMeta>(&arg0.metas, arg1)) {
            if (0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, arg1).verified) {
                distinct_witnesses_above(arg0, arg1) >= arg0.finality_threshold
            } else {
                false
            }
        } else {
            false
        }
    }

    fun new_light_client(arg0: vector<u64>, arg1: vector<vector<u8>>, arg2: u32, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 1);
        assert!(0x1::vector::length<u8>(&arg3) == 20, 5);
        assert!((arg5 as u64) >= arg4 * 4, 7);
        let v0 = 0x2::vec_map::empty<u64, vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x2::vec_map::insert<u64, vector<u8>>(&mut v0, *0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<vector<u8>>(&arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = SwaplockLightClient{
            id                 : 0x2::object::new(arg6),
            witnesses          : v0,
            metas              : 0x2::table::new<u32, HeaderMeta>(arg6),
            head_block_num     : arg2,
            head_id            : arg3,
            verified_head      : arg2,
            anchor_block_num   : arg2,
            anchor_id          : arg3,
            tail_next          : arg2 + 1,
            finality_threshold : arg4,
            retention_blocks   : arg5,
        };
        0x2::transfer::share_object<SwaplockLightClient>(v2);
        let v3 = LightClientAdminCap{id: 0x2::object::new(arg6)};
        0x2::transfer::public_transfer<LightClientAdminCap>(v3, 0x2::tx_context::sender(arg6));
    }

    public fun promote(arg0: &mut SwaplockLightClient, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1 && arg0.verified_head < arg0.head_block_num) {
            let v1 = arg0.verified_head + 1;
            let v2 = 0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, v1);
            let v3 = v2.key;
            let v4 = v2.witness;
            if (v2.verified) {
                arg0.verified_head = v1;
            } else if (0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &v4) && *0x2::vec_map::get<u64, vector<u8>>(&arg0.witnesses, &v4) == v3) {
                0x2::table::borrow_mut<u32, HeaderMeta>(&mut arg0.metas, v1).verified = true;
                arg0.verified_head = v1;
            } else if (distinct_witnesses_above(arg0, v1) >= arg0.finality_threshold) {
                if (0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &v4)) {
                    *0x2::vec_map::get_mut<u64, vector<u8>>(&mut arg0.witnesses, &v4) = v3;
                } else {
                    0x2::vec_map::insert<u64, vector<u8>>(&mut arg0.witnesses, v4, v3);
                };
                0x2::table::borrow_mut<u32, HeaderMeta>(&mut arg0.metas, v1).verified = true;
                arg0.verified_head = v1;
            } else {
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun prune(arg0: &mut SwaplockLightClient, arg1: u64) {
        let v0 = 0;
        loop {
            let v1 = if (v0 < arg1) {
                if (arg0.verified_head > arg0.retention_blocks) {
                    arg0.tail_next < arg0.verified_head - arg0.retention_blocks
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                let HeaderMeta {
                    witness     : _,
                    key         : _,
                    merkle_root : _,
                    block_id    : _,
                    verified    : _,
                } = 0x2::table::remove<u32, HeaderMeta>(&mut arg0.metas, arg0.tail_next);
                arg0.tail_next = arg0.tail_next + 1;
                v0 = v0 + 1;
            } else {
                break
            };
        };
    }

    public fun remove_witness(arg0: &mut SwaplockLightClient, arg1: &LightClientAdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &arg2), 1);
        let (_, _) = 0x2::vec_map::remove<u64, vector<u8>>(&mut arg0.witnesses, &arg2);
    }

    public fun root_at(arg0: &SwaplockLightClient, arg1: u32) : vector<u8> {
        0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, arg1).merkle_root
    }

    public fun set_witness(arg0: &mut SwaplockLightClient, arg1: &LightClientAdminCap, arg2: u64, arg3: vector<u8>) {
        if (0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &arg2)) {
            *0x2::vec_map::get_mut<u64, vector<u8>>(&mut arg0.witnesses, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u64, vector<u8>>(&mut arg0.witnesses, arg2, arg3);
        };
    }

    public fun submit_header(arg0: &mut SwaplockLightClient, arg1: u32, arg2: vector<u8>, arg3: u32, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: vector<u8>) {
        assert!(arg1 == arg0.head_block_num + 1, 3);
        assert!(arg2 == arg0.head_id, 4);
        let v0 = 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::light_client::serialize_header(arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xef1b91c41b15a653b1253f66f909211f4f13754e2eb0aefc2426ed45aff0da26::light_client::recover_witness_key(&v0, &arg7);
        let v2 = 0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &arg4) && *0x2::vec_map::get<u64, vector<u8>>(&arg0.witnesses, &arg4) == v1;
        let v3 = compute_block_id(arg1, &v0, &arg7);
        let v4 = HeaderMeta{
            witness     : arg4,
            key         : v1,
            merkle_root : arg5,
            block_id    : v3,
            verified    : v2,
        };
        0x2::table::add<u32, HeaderMeta>(&mut arg0.metas, arg1, v4);
        arg0.head_block_num = arg1;
        arg0.head_id = v3;
        if (v2 && arg0.verified_head == arg1 - 1) {
            arg0.verified_head = arg1;
        };
    }

    public fun verified_head(arg0: &SwaplockLightClient) : u32 {
        arg0.verified_head
    }

    public fun witness_key(arg0: &SwaplockLightClient, arg1: u64) : vector<u8> {
        *0x2::vec_map::get<u64, vector<u8>>(&arg0.witnesses, &arg1)
    }

    // decompiled from Move bytecode v7
}

