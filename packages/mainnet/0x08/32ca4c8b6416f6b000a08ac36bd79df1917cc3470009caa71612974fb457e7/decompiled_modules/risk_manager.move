module 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::risk_manager {
    struct RiskHeap has drop, store {
        max_risk: u64,
        sum_risk: u64,
        risks: vector<u64>,
    }

    struct RiskManager has drop, store {
        total_risk: u64,
        color_heap: RiskHeap,
        parity_heap: RiskHeap,
        eighteen_heap: RiskHeap,
        twelve_heap: RiskHeap,
        column_heap: RiskHeap,
        number_heap: RiskHeap,
        split_heap: RiskHeap,
        street_heap: RiskHeap,
        corner_heap: RiskHeap,
        double_street_heap: RiskHeap,
    }

    public fun add_risk(arg0: &mut RiskManager, arg1: u8, arg2: 0x1::option::Option<u64>, arg3: u64) : (bool, u64) {
        let (v0, v1) = if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::red() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::black()) {
            let v2 = &mut arg0.color_heap;
            add_risk_to_heap(v2, (arg1 as u64) % 2, arg3)
        } else if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::even() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::odd()) {
            let v3 = &mut arg0.parity_heap;
            add_risk_to_heap(v3, (arg1 as u64) % 2, arg3)
        } else if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::first_eighteen() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::second_eighteen()) {
            let v4 = &mut arg0.eighteen_heap;
            add_risk_to_heap(v4, (arg1 as u64) % 2, arg3)
        } else if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::first_twelve() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::second_twelve() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::third_twelve()) {
            let v5 = &mut arg0.twelve_heap;
            add_risk_to_heap(v5, (arg1 as u64) % 3, arg3)
        } else if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::first_column() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::second_column() || arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::third_column()) {
            let v6 = &mut arg0.column_heap;
            add_risk_to_heap(v6, (arg1 as u64) % 3, arg3)
        } else if (arg1 == 0x832ca4c8b6416f6b000a08ac36bd79df1917cc3470009caa71612974fb457e7::bet_manager::number()) {
            let v7 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v7 < 38, 1);
            let v8 = &mut arg0.number_heap;
            add_risk_to_heap(v8, v7, arg3)
        } else if (arg1 >= 13 && arg1 <= 72) {
            let v9 = &mut arg0.split_heap;
            add_risk_to_heap(v9, (arg1 as u64) % 60, arg3)
        } else if (arg1 >= 73 && arg1 <= 87) {
            let v10 = &mut arg0.street_heap;
            add_risk_to_heap(v10, (arg1 as u64) % 15, arg3)
        } else if (arg1 >= 88 && arg1 <= 109) {
            let v11 = &mut arg0.split_heap;
            add_risk_to_heap(v11, (arg1 as u64) % 22, arg3)
        } else {
            assert!(arg1 >= 110 && arg1 <= 121, 0);
            let v12 = &mut arg0.split_heap;
            add_risk_to_heap(v12, (arg1 as u64) % 12, arg3)
        };
        if (v0) {
            arg0.total_risk = arg0.total_risk + v1;
        } else {
            arg0.total_risk = arg0.total_risk - v1;
        };
        (v0, v1)
    }

    fun add_risk_to_heap(arg0: &mut RiskHeap, arg1: u64, arg2: u64) : (bool, u64) {
        let v0 = heap_risk(arg0);
        arg0.sum_risk = arg0.sum_risk + arg2;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.risks, arg1);
        *v1 = *v1 + arg2;
        if (*v1 > arg0.max_risk) {
            arg0.max_risk = *v1;
        };
        let v2 = heap_risk(arg0);
        if (v2 > v0) {
            (true, v2 - v0)
        } else {
            (false, v0 - v2)
        }
    }

    fun heap_risk(arg0: &RiskHeap) : u64 {
        if (2 * arg0.max_risk > arg0.sum_risk) {
            2 * arg0.max_risk - arg0.sum_risk
        } else {
            0
        }
    }

    public fun new_manager() : RiskManager {
        RiskManager{
            total_risk         : 0,
            color_heap         : new_risk_heap(2),
            parity_heap        : new_risk_heap(2),
            eighteen_heap      : new_risk_heap(2),
            twelve_heap        : new_risk_heap(3),
            column_heap        : new_risk_heap(3),
            number_heap        : new_risk_heap(38),
            split_heap         : new_risk_heap(60),
            street_heap        : new_risk_heap(15),
            corner_heap        : new_risk_heap(22),
            double_street_heap : new_risk_heap(12),
        }
    }

    fun new_risk_heap(arg0: u64) : RiskHeap {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        RiskHeap{
            max_risk : 0,
            sum_risk : 0,
            risks    : v0,
        }
    }

    public fun total_risk(arg0: &RiskManager) : u64 {
        arg0.total_risk
    }

    // decompiled from Move bytecode v6
}

