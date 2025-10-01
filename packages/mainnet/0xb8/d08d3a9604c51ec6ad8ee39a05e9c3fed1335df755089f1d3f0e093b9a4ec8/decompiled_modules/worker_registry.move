module 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry {
    struct WorkerRegistry has key {
        id: 0x2::object::UID,
        worker_infos: 0x2::table::Table<address, vector<u8>>,
    }

    struct WorkerInfoSetEvent has copy, drop {
        worker: address,
        worker_info: vector<u8>,
    }

    public fun get_worker_info(arg0: &WorkerRegistry, arg1: address) : &vector<u8> {
        let v0 = &arg0.worker_infos;
        assert!(0x2::table::contains<address, vector<u8>>(v0, arg1), 2);
        0x2::table::borrow<address, vector<u8>>(v0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerRegistry{
            id           : 0x2::object::new(arg0),
            worker_infos : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<WorkerRegistry>(v0);
    }

    public fun set_worker_info(arg0: &mut WorkerRegistry, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1);
        let v0 = &mut arg0.worker_infos;
        if (0x2::table::contains<address, vector<u8>>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1))) {
            *0x2::table::borrow_mut<address, vector<u8>>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1)) = arg2;
        } else {
            0x2::table::add<address, vector<u8>>(v0, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1), arg2);
        };
        let v1 = WorkerInfoSetEvent{
            worker      : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1),
            worker_info : arg2,
        };
        0x2::event::emit<WorkerInfoSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

