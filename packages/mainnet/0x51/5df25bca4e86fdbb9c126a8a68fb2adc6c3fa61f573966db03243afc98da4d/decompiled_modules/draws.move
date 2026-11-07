module 0x515df25bca4e86fdbb9c126a8a68fb2adc6c3fa61f573966db03243afc98da4d::draws {
    struct Draws has key {
        id: 0x2::object::UID,
        drawers: 0x2::vec_set::VecSet<address>,
        results: 0x2::table::Table<DrawKey, DrawResult>,
        count: u64,
    }

    struct DrawKey has copy, drop, store {
        app: vector<u8>,
        interaction: vector<u8>,
        label: vector<u8>,
    }

    struct DrawResult has copy, drop, store {
        kind: u8,
        n: u64,
        k: u64,
        value: vector<u64>,
        epoch: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Drawn has copy, drop {
        registry: 0x2::object::ID,
        app: vector<u8>,
        interaction: vector<u8>,
        label: vector<u8>,
        kind: u8,
        n: u64,
        k: u64,
        value: vector<u64>,
        drawer: address,
        index: u64,
    }

    public fun add_drawer(arg0: &AdminCap, arg1: &mut Draws, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.drawers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.drawers, arg2);
        };
    }

    fun checked_key(arg0: &Draws, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: address) : DrawKey {
        assert!(0x2::vec_set::contains<address>(&arg0.drawers, &arg7), 0);
        assert!(!0x1::vector::is_empty<u8>(&arg1) && 0x1::vector::length<u8>(&arg1) <= 64, 4);
        assert!(!0x1::vector::is_empty<u8>(&arg2) && 0x1::vector::length<u8>(&arg2) <= 64, 4);
        assert!(!0x1::vector::is_empty<u8>(&arg3) && 0x1::vector::length<u8>(&arg3) <= 32, 5);
        if (arg4 == 0) {
            assert!(arg5 >= 2 && arg6 == 0, 3);
        } else if (arg4 == 1) {
            let v0 = if (arg5 >= 2) {
                if (arg5 <= 64) {
                    arg6 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 3);
        } else {
            assert!(arg4 == 2, 2);
            let v1 = if (arg6 >= 1) {
                if (arg6 <= 64) {
                    if (arg6 <= arg5) {
                        arg5 <= 1000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 3);
        };
        let v2 = DrawKey{
            app         : arg1,
            interaction : arg2,
            label       : arg3,
        };
        assert!(!0x2::table::contains<DrawKey, DrawResult>(&arg0.results, v2), 1);
        v2
    }

    fun compute(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u64, arg3: u64) : vector<u64> {
        if (arg1 == 0) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, 0x2::random::generate_u64_in_range(arg0, 0, arg2 - 1));
            v1
        } else if (arg1 == 1) {
            let v2 = range(arg2);
            0x2::random::shuffle<u64>(arg0, &mut v2);
            v2
        } else {
            let v3 = range(arg2);
            let v4 = vector[];
            let v5 = 0;
            while (v5 < arg3) {
                0x1::vector::swap<u64>(&mut v3, v5, 0x2::random::generate_u64_in_range(arg0, v5, arg2 - 1));
                0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v3, v5));
                v5 = v5 + 1;
            };
            v4
        }
    }

    public fun count(arg0: &Draws) : u64 {
        arg0.count
    }

    entry fun draw(arg0: &0x2::random::Random, arg1: &mut Draws, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = checked_key(arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::sender(arg8));
        let v1 = 0x2::random::new_generator(arg0, arg8);
        let v2 = &mut v1;
        record(arg1, v0, arg5, arg6, arg7, compute(v2, arg5, arg6, arg7), arg8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Draws{
            id      : 0x2::object::new(arg0),
            drawers : 0x2::vec_set::empty<address>(),
            results : 0x2::table::new<DrawKey, DrawResult>(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Draws>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_drawer(arg0: &Draws, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.drawers, &arg1)
    }

    fun range(arg0: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun record(arg0: &mut Draws, arg1: DrawKey, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: &0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        arg0.count = v0 + 1;
        let v1 = DrawResult{
            kind  : arg2,
            n     : arg3,
            k     : arg4,
            value : arg5,
            epoch : 0x2::tx_context::epoch(arg6),
        };
        0x2::table::add<DrawKey, DrawResult>(&mut arg0.results, arg1, v1);
        let v2 = Drawn{
            registry    : 0x2::object::id<Draws>(arg0),
            app         : arg1.app,
            interaction : arg1.interaction,
            label       : arg1.label,
            kind        : arg2,
            n           : arg3,
            k           : arg4,
            value       : arg5,
            drawer      : 0x2::tx_context::sender(arg6),
            index       : v0,
        };
        0x2::event::emit<Drawn>(v2);
    }

    public fun remove_drawer(arg0: &AdminCap, arg1: &mut Draws, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.drawers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.drawers, &arg2);
        };
    }

    public fun result(arg0: &Draws, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : 0x1::option::Option<vector<u64>> {
        let v0 = DrawKey{
            app         : arg1,
            interaction : arg2,
            label       : arg3,
        };
        if (0x2::table::contains<DrawKey, DrawResult>(&arg0.results, v0)) {
            0x1::option::some<vector<u64>>(0x2::table::borrow<DrawKey, DrawResult>(&arg0.results, v0).value)
        } else {
            0x1::option::none<vector<u64>>()
        }
    }

    // decompiled from Move bytecode v7
}

