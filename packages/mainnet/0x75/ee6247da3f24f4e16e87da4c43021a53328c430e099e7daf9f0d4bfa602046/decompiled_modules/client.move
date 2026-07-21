module 0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::client {
    struct HeaderMeta has store {
        witness: u64,
        merkle_root: vector<u8>,
    }

    struct SwaplockLightClient has key {
        id: 0x2::object::UID,
        witnesses: 0x2::vec_map::VecMap<u64, vector<u8>>,
        metas: 0x2::table::Table<u32, HeaderMeta>,
        head_block_num: u32,
        finality_threshold: u64,
    }

    struct LightClientAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: &0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core::AdminCap, arg1: vector<u64>, arg2: vector<vector<u8>>, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        new_light_client(arg1, arg2, arg3, arg4, arg5);
    }

    public fun distinct_witnesses_above(arg0: &SwaplockLightClient, arg1: u32) : u64 {
        let v0 = 0x2::vec_map::empty<u64, bool>();
        let v1 = arg1 + 1;
        while (v1 <= arg0.head_block_num) {
            if (0x2::table::contains<u32, HeaderMeta>(&arg0.metas, v1)) {
                let v2 = 0x2::table::borrow<u32, HeaderMeta>(&arg0.metas, v1).witness;
                if (!0x2::vec_map::contains<u64, bool>(&v0, &v2)) {
                    0x2::vec_map::insert<u64, bool>(&mut v0, v2, true);
                };
            };
            v1 = v1 + 1;
        };
        0x2::vec_map::size<u64, bool>(&v0)
    }

    public fun has_root(arg0: &SwaplockLightClient, arg1: u32) : bool {
        0x2::table::contains<u32, HeaderMeta>(&arg0.metas, arg1)
    }

    public fun head(arg0: &SwaplockLightClient) : u32 {
        arg0.head_block_num
    }

    public fun is_final(arg0: &SwaplockLightClient, arg1: u32) : bool {
        0x2::table::contains<u32, HeaderMeta>(&arg0.metas, arg1) && distinct_witnesses_above(arg0, arg1) >= arg0.finality_threshold
    }

    fun new_light_client(arg0: vector<u64>, arg1: vector<vector<u8>>, arg2: u32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 1);
        let v0 = 0x2::vec_map::empty<u64, vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            0x2::vec_map::insert<u64, vector<u8>>(&mut v0, *0x1::vector::borrow<u64>(&arg0, v1), *0x1::vector::borrow<vector<u8>>(&arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = SwaplockLightClient{
            id                 : 0x2::object::new(arg4),
            witnesses          : v0,
            metas              : 0x2::table::new<u32, HeaderMeta>(arg4),
            head_block_num     : arg2,
            finality_threshold : arg3,
        };
        0x2::transfer::share_object<SwaplockLightClient>(v2);
        let v3 = LightClientAdminCap{id: 0x2::object::new(arg4)};
        0x2::transfer::public_transfer<LightClientAdminCap>(v3, 0x2::tx_context::sender(arg4));
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
        assert!(0x2::vec_map::contains<u64, vector<u8>>(&arg0.witnesses, &arg4), 1);
        assert!(0x75ee6247da3f24f4e16e87da4c43021a53328c430e099e7daf9f0d4bfa602046::light_client::verify_witness_signature(arg2, arg3, arg4, arg5, arg6, arg7, *0x2::vec_map::get<u64, vector<u8>>(&arg0.witnesses, &arg4)), 2);
        let v0 = HeaderMeta{
            witness     : arg4,
            merkle_root : arg5,
        };
        0x2::table::add<u32, HeaderMeta>(&mut arg0.metas, arg1, v0);
        arg0.head_block_num = arg1;
    }

    // decompiled from Move bytecode v7
}

