module 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::lp {
    struct Claim has drop, store {
        owner: address,
        account_id: 0x2::object::ID,
        net: u64,
        fee: u64,
        position_id: u64,
        builder_id: 0x1::option::Option<u32>,
        on_top: u64,
        profit_base: u64,
        wash: bool,
        fee_origin: u64,
        paired_fee: u64,
        credit_booked: u64,
    }

    struct FeeSplitProgress has drop, store {
        fee: u64,
        paid: u64,
        keep: u64,
        discount_left: u64,
        direct_left: u64,
        second_left: u64,
    }

    public fun front(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : (u64, 0x2::object::ID, u64, u64) {
        let v0 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0));
        let v1 = 0x2::linked_table::borrow<u64, Claim>(arg0, v0);
        (v0, v1.account_id, v1.net, v1.fee)
    }

    public fun pop_front(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>) : (u64, address, 0x2::object::ID, u64, u64) {
        let (v0, v1) = 0x2::linked_table::pop_front<u64, Claim>(arg0);
        let Claim {
            owner         : v2,
            account_id    : v3,
            net           : v4,
            fee           : v5,
            position_id   : _,
            builder_id    : _,
            on_top        : _,
            profit_base   : _,
            wash          : _,
            fee_origin    : _,
            paired_fee    : _,
            credit_booked : _,
        } = v1;
        (v0, v2, v3, v4, v5)
    }

    public fun head_cost(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : u64 {
        if (0x2::linked_table::length<u64, Claim>(arg0) == 0) {
            return 0
        };
        let v0 = 0x2::linked_table::borrow<u64, Claim>(arg0, *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0)));
        v0.net + v0.on_top + v0.fee
    }

    public fun head_fee(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : u64 {
        0x2::linked_table::borrow<u64, Claim>(arg0, *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0))).fee
    }

    public fun len(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : u64 {
        0x2::linked_table::length<u64, Claim>(arg0)
    }

    public fun max_entries() : u64 {
        128
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun new_fee_split_progress(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : FeeSplitProgress {
        let v0 = min(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::bps_of(arg0, arg1), arg0);
        let v1 = min(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::bps_of(arg0, arg2), arg0 - v0);
        let v2 = min(0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::bps_of(arg0, arg3), arg0 - v0 - v1);
        FeeSplitProgress{
            fee           : arg0,
            paid          : 0,
            keep          : arg0 - v0 - v1 - v2,
            discount_left : v0,
            direct_left   : v1,
            second_left   : v2,
        }
    }

    public fun push(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64) {
        push_with_builder(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u32>(), 0, 0);
    }

    public fun push_with_builder(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u64, arg9: u64) {
        assert!(arg4 + arg5 + arg8 > 0, 13835058373109743617);
        let v0 = Claim{
            owner         : arg2,
            account_id    : arg3,
            net           : arg4,
            fee           : arg5,
            position_id   : arg6,
            builder_id    : arg7,
            on_top        : arg8,
            profit_base   : arg9,
            wash          : true,
            fee_origin    : arg5,
            paired_fee    : 0,
            credit_booked : 0,
        };
        0x2::linked_table::push_back<u64, Claim>(arg0, arg1, v0);
    }

    public fun recommended_batch() : u64 {
        32
    }

    public fun retained_so_far(arg0: &FeeSplitProgress) : u64 {
        if (arg0.fee == 0) {
            return 0
        };
        (((arg0.keep as u128) * (arg0.paid as u128) / (arg0.fee as u128)) as u64)
    }

    public fun set_close_meta(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: bool, arg3: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, Claim>(arg0, arg1);
        v0.wash = arg2;
        v0.paired_fee = arg3;
    }

    public fun set_credit_booked(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: u64) {
        0x2::linked_table::borrow_mut<u64, Claim>(arg0, arg1).credit_booked = arg2;
    }

    public fun split_slice(arg0: &mut FeeSplitProgress, arg1: u64) : (u64, u64, u64, u64) {
        arg0.paid = arg0.paid + arg1;
        let v0 = retained_so_far(arg0) - retained_so_far(arg0);
        let v1 = arg1 - v0;
        let v2 = min(arg0.discount_left, v1);
        arg0.discount_left = arg0.discount_left - v2;
        let v3 = v1 - v2;
        let v4 = min(arg0.direct_left, v3);
        arg0.direct_left = arg0.direct_left - v4;
        let v5 = v3 - v4;
        let v6 = min(arg0.second_left, v5);
        arg0.second_left = arg0.second_left - v6;
        (v2, v4, v6, v0 + v5 - v6)
    }

    public fun take_fitting(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<address>, vector<0x2::object::ID>, u64) {
        let (v0, v1, v2, v3, v4, _, _, _, _, v9, _, _, _, _, _) = take_fitting_full(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v9)
    }

    public fun take_fitting_full(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<address>, vector<0x2::object::ID>, vector<0x1::option::Option<u32>>, vector<u64>, vector<u64>, vector<u64>, u64, vector<bool>, vector<u64>, vector<u64>, vector<u64>, vector<bool>) {
        if (arg2 > 128) {
            arg2 = 128;
        };
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0x1::vector::empty<0x1::option::Option<u32>>();
        let v6 = vector[];
        let v7 = vector[];
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = vector[];
        let v14 = 0;
        let v15 = 0;
        while (v15 < arg2 && 0x2::linked_table::length<u64, Claim>(arg0) > 0) {
            let v16 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0));
            let v17 = 0x2::linked_table::borrow<u64, Claim>(arg0, v16);
            let v18 = v17.net + v17.on_top + v17.fee;
            let v19 = arg1 - v14;
            if (v19 == 0) {
                break
            };
            if (v18 > v19) {
                let v20 = 0x2::linked_table::borrow_mut<u64, Claim>(arg0, v16);
                let v21 = if (v20.net < v19) {
                    v20.net
                } else {
                    v19
                };
                let v22 = v19 - v21;
                let v23 = if (v20.on_top < v22) {
                    v20.on_top
                } else {
                    v22
                };
                let v24 = v22 - v23;
                v20.net = v20.net - v21;
                v20.on_top = v20.on_top - v23;
                v20.fee = v20.fee - v24;
                0x1::vector::push_back<u64>(&mut v0, v16);
                0x1::vector::push_back<u64>(&mut v1, v21);
                0x1::vector::push_back<u64>(&mut v2, v24);
                0x1::vector::push_back<address>(&mut v3, v20.owner);
                0x1::vector::push_back<0x2::object::ID>(&mut v4, v20.account_id);
                0x1::vector::push_back<0x1::option::Option<u32>>(&mut v5, v20.builder_id);
                0x1::vector::push_back<u64>(&mut v6, v20.position_id);
                0x1::vector::push_back<u64>(&mut v7, v23);
                0x1::vector::push_back<u64>(&mut v8, v20.profit_base);
                0x1::vector::push_back<bool>(&mut v9, v20.wash);
                0x1::vector::push_back<u64>(&mut v10, v20.fee_origin);
                0x1::vector::push_back<u64>(&mut v11, v20.paired_fee);
                0x1::vector::push_back<u64>(&mut v12, v20.credit_booked);
                0x1::vector::push_back<bool>(&mut v13, false);
                v14 = arg1;
                break
            };
            let (_, v26) = 0x2::linked_table::pop_front<u64, Claim>(arg0);
            let Claim {
                owner         : v27,
                account_id    : v28,
                net           : v29,
                fee           : v30,
                position_id   : v31,
                builder_id    : v32,
                on_top        : v33,
                profit_base   : v34,
                wash          : v35,
                fee_origin    : v36,
                paired_fee    : v37,
                credit_booked : v38,
            } = v26;
            0x1::vector::push_back<u64>(&mut v0, v16);
            0x1::vector::push_back<u64>(&mut v1, v29);
            0x1::vector::push_back<u64>(&mut v2, v30);
            0x1::vector::push_back<address>(&mut v3, v27);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, v28);
            0x1::vector::push_back<0x1::option::Option<u32>>(&mut v5, v32);
            0x1::vector::push_back<u64>(&mut v6, v31);
            0x1::vector::push_back<u64>(&mut v7, v33);
            0x1::vector::push_back<u64>(&mut v8, v34);
            0x1::vector::push_back<bool>(&mut v9, v35);
            0x1::vector::push_back<u64>(&mut v10, v36);
            0x1::vector::push_back<u64>(&mut v11, v37);
            0x1::vector::push_back<u64>(&mut v12, v38);
            0x1::vector::push_back<bool>(&mut v13, true);
            v14 = v14 + v18;
            v15 = v15 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v14, v9, v10, v11, v12, v13)
    }

    // decompiled from Move bytecode v7
}

