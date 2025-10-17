module 0x1afb154e3f6af88dbddb258518c6ff50ab50993abdf692506eecc81533430198::gas_exhaustion {
    struct TrapObject has store, key {
        id: 0x2::object::UID,
        trap_count: u64,
        total_gas_consumed: u64,
        creator: address,
    }

    struct TrapRegistry has key {
        id: 0x2::object::UID,
        traps: 0x2::table::Table<0x1::string::String, TrapObject>,
        total_traps_created: u64,
    }

    public entry fun create_trap(arg0: 0x1::string::String, arg1: &mut TrapRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TrapObject{
            id                 : 0x2::object::new(arg2),
            trap_count         : 0,
            total_gas_consumed : 0,
            creator            : 0x2::tx_context::sender(arg2),
        };
        0x2::table::add<0x1::string::String, TrapObject>(&mut arg1.traps, arg0, v0);
        arg1.total_traps_created = arg1.total_traps_created + 1;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 1000) {
            0x1::vector::push_back<u64>(&mut v1, v2);
            v2 = v2 + 1;
        };
    }

    public entry fun gas_sink(arg0: &mut TrapRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = if (arg1 > 5000) {
            5000
        } else {
            arg1
        };
        while (v0 < v1) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 0;
            while (v3 < 200) {
                0x1::vector::push_back<u8>(&mut v2, ((v3 % 256) as u8));
                v3 = v3 + 1;
            };
            let v4 = 0;
            let v5 = 0;
            while (v5 < 50) {
                if (v5 < 0x1::vector::length<u8>(&v2)) {
                    v4 = v4 + (*0x1::vector::borrow<u8>(&v2, v5) as u64);
                };
                v5 = v5 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun get_total_traps(arg0: &TrapRegistry) : u64 {
        arg0.total_traps_created
    }

    public fun get_trap_stats(arg0: &TrapRegistry, arg1: 0x1::string::String) : (u64, u64) {
        if (0x2::table::contains<0x1::string::String, TrapObject>(&arg0.traps, arg1)) {
            let v2 = 0x2::table::borrow<0x1::string::String, TrapObject>(&arg0.traps, arg1);
            (v2.trap_count, v2.total_gas_consumed)
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TrapRegistry{
            id                  : 0x2::object::new(arg0),
            traps               : 0x2::table::new<0x1::string::String, TrapObject>(arg0),
            total_traps_created : 0,
        };
        0x2::transfer::share_object<TrapRegistry>(v0);
    }

    public fun trap_exists(arg0: &TrapRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TrapObject>(&arg0.traps, arg1)
    }

    public entry fun trigger_multiple_traps(arg0: &mut TrapRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"trap1"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"trap2"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"trap3"));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&v0, v2);
            if (0x2::table::contains<0x1::string::String, TrapObject>(&arg0.traps, v3)) {
                trigger_trap(arg0, v3, arg1);
            };
            v2 = v2 + 1;
        };
    }

    public entry fun trigger_trap(arg0: &mut TrapRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, TrapObject>(&mut arg0.traps, arg1);
        let v1 = 0;
        let v2 = 100;
        while (v1 < v2) {
            let v3 = 0x1::vector::empty<u64>();
            let v4 = 0;
            while (v4 < 20) {
                0x1::vector::push_back<u64>(&mut v3, v4);
                v4 = v4 + 1;
            };
            let v5 = 0;
            while (v5 < 20) {
                if (0x1::vector::length<u64>(&v3) > 0) {
                    0x1::vector::pop_back<u64>(&mut v3);
                };
                0x1::vector::push_back<u64>(&mut v3, v5);
                v5 = v5 + 1;
            };
            v1 = v1 + 1;
        };
        v0.trap_count = v0.trap_count + 1;
        v0.total_gas_consumed = v0.total_gas_consumed + v2;
    }

    // decompiled from Move bytecode v6
}

