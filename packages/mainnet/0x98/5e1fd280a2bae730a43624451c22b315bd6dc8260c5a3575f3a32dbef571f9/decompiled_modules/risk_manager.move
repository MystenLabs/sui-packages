module 0x985e1fd280a2bae730a43624451c22b315bd6dc8260c5a3575f3a32dbef571f9::risk_manager {
    struct RiskHeap has drop, store {
        max_risk: u64,
        sum_risk: u64,
        risks: 0x2::vec_map::VecMap<u64, u64>,
    }

    struct RiskManager has store {
        total_risks: 0x1::option::Option<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>,
        rank_risk_map: 0x1::option::Option<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>,
        marble_ids: vector<u64>,
    }

    public(friend) fun add_risk(arg0: &mut RiskManager, arg1: 0x1::type_name::TypeName, arg2: vector<0x985e1fd280a2bae730a43624451c22b315bd6dc8260c5a3575f3a32dbef571f9::bet_manager::Placement>, arg3: u64) {
        let v0 = 0x1::vector::length<u64>(&arg0.marble_ids);
        assert!(0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks), 2);
        assert!(0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(&arg0.rank_risk_map), 3);
        let v1 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(&mut arg0.rank_risk_map);
        let v2 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&mut arg0.total_risks);
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u64>(v2, arg1)) {
            0x2::linked_table::push_back<0x1::type_name::TypeName, u64>(v2, arg1, 0);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x985e1fd280a2bae730a43624451c22b315bd6dc8260c5a3575f3a32dbef571f9::bet_manager::Placement>(&arg2)) {
            let (v4, v5) = 0x985e1fd280a2bae730a43624451c22b315bd6dc8260c5a3575f3a32dbef571f9::bet_manager::get_placement_data(0x1::vector::borrow<0x985e1fd280a2bae730a43624451c22b315bd6dc8260c5a3575f3a32dbef571f9::bet_manager::Placement>(&arg2, v3));
            assert!(v5 < (v0 as u8), 1);
            let (v6, v7) = if (!0x2::linked_table::contains<0x1::type_name::TypeName, vector<RiskHeap>>(v1, arg1)) {
                let v8 = 0x1::vector::empty<RiskHeap>();
                let v9 = 0;
                while (v9 < v0) {
                    0x1::vector::push_back<RiskHeap>(&mut v8, new_risk_heap(&arg0.marble_ids));
                    v9 = v9 + 1;
                };
                let v10 = 0x1::vector::borrow_mut<RiskHeap>(&mut v8, (v5 as u64));
                let (v11, v12) = add_risk_to_heap(v10, v4, arg3, v0);
                0x2::linked_table::push_back<0x1::type_name::TypeName, vector<RiskHeap>>(v1, arg1, v8);
                (v12, v11)
            } else {
                let v13 = 0x1::vector::borrow_mut<RiskHeap>(0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<RiskHeap>>(v1, arg1), (v5 as u64));
                let (v14, v15) = add_risk_to_heap(v13, v4, arg3, v0);
                (v15, v14)
            };
            let v16 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, u64>(v2, arg1);
            if (v7) {
                *v16 = *v16 + v6;
            } else {
                *v16 = *v16 - v6;
            };
            v3 = v3 + 1;
        };
    }

    fun add_risk_to_heap(arg0: &mut RiskHeap, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        let v0 = heap_risk(arg0, arg3);
        arg0.sum_risk = arg0.sum_risk + arg2;
        let v1 = 0x2::vec_map::get_mut<u64, u64>(&mut arg0.risks, &arg1);
        *v1 = *v1 + arg2;
        if (*v1 > arg0.max_risk) {
            arg0.max_risk = *v1;
        };
        let v2 = heap_risk(arg0, arg3);
        if (v2 > v0) {
            (true, v2 - v0)
        } else {
            (false, v0 - v2)
        }
    }

    public(friend) fun destroy_manager(arg0: RiskManager) {
        let RiskManager {
            total_risks   : v0,
            rank_risk_map : v1,
            marble_ids    : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&v4)) {
            let v5 = 0x1::option::extract<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&mut v4);
            if (!0x2::linked_table::is_empty<0x1::type_name::TypeName, u64>(&v5)) {
                while (0x2::linked_table::length<0x1::type_name::TypeName, u64>(&v5) > 0) {
                    let (_, _) = 0x2::linked_table::pop_back<0x1::type_name::TypeName, u64>(&mut v5);
                };
            };
            0x2::linked_table::destroy_empty<0x1::type_name::TypeName, u64>(v5);
        };
        0x1::option::destroy_none<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(v4);
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(&v3)) {
            let v8 = 0x1::option::extract<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(&mut v3);
            if (!0x2::linked_table::is_empty<0x1::type_name::TypeName, vector<RiskHeap>>(&v8)) {
                while (0x2::linked_table::length<0x1::type_name::TypeName, vector<RiskHeap>>(&v8) > 0) {
                    let (_, _) = 0x2::linked_table::pop_back<0x1::type_name::TypeName, vector<RiskHeap>>(&mut v8);
                };
            };
            0x2::linked_table::destroy_empty<0x1::type_name::TypeName, vector<RiskHeap>>(v8);
        };
        0x1::option::destroy_none<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(v3);
    }

    fun heap_risk(arg0: &RiskHeap, arg1: u64) : u64 {
        if (arg1 * arg0.max_risk > arg0.sum_risk) {
            arg1 * arg0.max_risk - arg0.sum_risk
        } else {
            0
        }
    }

    public fun marble_ids(arg0: &RiskManager) : vector<u64> {
        arg0.marble_ids
    }

    public fun marble_ids_length(arg0: &RiskManager) : u64 {
        0x1::vector::length<u64>(&arg0.marble_ids)
    }

    public(friend) fun new_manager(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) : RiskManager {
        RiskManager{
            total_risks   : 0x1::option::some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(0x2::linked_table::new<0x1::type_name::TypeName, u64>(arg1)),
            rank_risk_map : 0x1::option::some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<RiskHeap>>>(0x2::linked_table::new<0x1::type_name::TypeName, vector<RiskHeap>>(arg1)),
            marble_ids    : arg0,
        }
    }

    fun new_risk_heap(arg0: &vector<u64>) : RiskHeap {
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x2::vec_map::insert<u64, u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1), 0);
            v1 = v1 + 1;
        };
        RiskHeap{
            max_risk : 0,
            sum_risk : 0,
            risks    : v0,
        }
    }

    public fun total_risk(arg0: &RiskManager, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u64>(0x1::option::borrow<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks), arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

