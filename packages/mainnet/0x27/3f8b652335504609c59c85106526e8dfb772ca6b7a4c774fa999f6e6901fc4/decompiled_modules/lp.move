module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::lp {
    struct Claim has drop, store {
        owner: address,
        account_id: 0x2::object::ID,
        net: u64,
        fee: u64,
        position_id: u64,
        builder_id: 0x1::option::Option<u32>,
        share_bps: u16,
    }

    public(friend) fun front(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : (u64, 0x2::object::ID, u64, u64) {
        let v0 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0));
        let v1 = 0x2::linked_table::borrow<u64, Claim>(arg0, v0);
        (v0, v1.account_id, v1.net, v1.fee)
    }

    public(friend) fun pop_front(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>) : (u64, address, 0x2::object::ID, u64, u64) {
        let (v0, v1) = 0x2::linked_table::pop_front<u64, Claim>(arg0);
        let Claim {
            owner       : v2,
            account_id  : v3,
            net         : v4,
            fee         : v5,
            position_id : _,
            builder_id  : _,
            share_bps   : _,
        } = v1;
        (v0, v2, v3, v4, v5)
    }

    public(friend) fun head_cost(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : u64 {
        if (0x2::linked_table::length<u64, Claim>(arg0) == 0) {
            return 0
        };
        let v0 = 0x2::linked_table::borrow<u64, Claim>(arg0, *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0)));
        v0.net + v0.fee
    }

    public(friend) fun len(arg0: &0x2::linked_table::LinkedTable<u64, Claim>) : u64 {
        0x2::linked_table::length<u64, Claim>(arg0)
    }

    public fun max_entries() : u64 {
        128
    }

    public(friend) fun push(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64) {
        push_with_builder(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u32>(), 0);
    }

    public(friend) fun push_with_builder(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u32>, arg8: u16) {
        assert!(arg4 + arg5 > 0, 13835058304390266881);
        let v0 = Claim{
            owner       : arg2,
            account_id  : arg3,
            net         : arg4,
            fee         : arg5,
            position_id : arg6,
            builder_id  : arg7,
            share_bps   : arg8,
        };
        0x2::linked_table::push_back<u64, Claim>(arg0, arg1, v0);
    }

    public fun recommended_batch() : u64 {
        32
    }

    public(friend) fun take_fitting(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<address>, vector<0x2::object::ID>, u64) {
        let (v0, v1, v2, v3, v4, _, _, _, v8) = take_fitting_full(arg0, arg1, arg2);
        (v0, v1, v2, v3, v4, v8)
    }

    public(friend) fun take_fitting_full(arg0: &mut 0x2::linked_table::LinkedTable<u64, Claim>, arg1: u64, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<address>, vector<0x2::object::ID>, vector<0x1::option::Option<u32>>, vector<u16>, vector<u64>, u64) {
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
        let v8 = 0;
        let v9 = 0;
        while (v9 < arg2 && 0x2::linked_table::length<u64, Claim>(arg0) > 0) {
            let v10 = *0x1::option::borrow<u64>(0x2::linked_table::front<u64, Claim>(arg0));
            let v11 = 0x2::linked_table::borrow<u64, Claim>(arg0, v10);
            let v12 = v11.net + v11.fee;
            let v13 = arg1 - v8;
            if (v13 == 0) {
                break
            };
            if (v12 > v13) {
                let v14 = 0x2::linked_table::borrow_mut<u64, Claim>(arg0, v10);
                let v15 = if (v14.net < v13) {
                    v14.net
                } else {
                    v13
                };
                let v16 = v13 - v15;
                v14.net = v14.net - v15;
                v14.fee = v14.fee - v16;
                0x1::vector::push_back<u64>(&mut v0, v10);
                0x1::vector::push_back<u64>(&mut v1, v15);
                0x1::vector::push_back<u64>(&mut v2, v16);
                0x1::vector::push_back<address>(&mut v3, v14.owner);
                0x1::vector::push_back<0x2::object::ID>(&mut v4, v14.account_id);
                0x1::vector::push_back<0x1::option::Option<u32>>(&mut v5, v14.builder_id);
                0x1::vector::push_back<u16>(&mut v6, v14.share_bps);
                0x1::vector::push_back<u64>(&mut v7, v14.position_id);
                v8 = arg1;
                break
            };
            let (_, v18) = 0x2::linked_table::pop_front<u64, Claim>(arg0);
            let Claim {
                owner       : v19,
                account_id  : v20,
                net         : v21,
                fee         : v22,
                position_id : v23,
                builder_id  : v24,
                share_bps   : v25,
            } = v18;
            0x1::vector::push_back<u64>(&mut v0, v10);
            0x1::vector::push_back<u64>(&mut v1, v21);
            0x1::vector::push_back<u64>(&mut v2, v22);
            0x1::vector::push_back<address>(&mut v3, v19);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, v20);
            0x1::vector::push_back<0x1::option::Option<u32>>(&mut v5, v24);
            0x1::vector::push_back<u16>(&mut v6, v25);
            0x1::vector::push_back<u64>(&mut v7, v23);
            v8 = v8 + v12;
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v7
}

