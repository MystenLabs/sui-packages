module 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        param_bots: 0x2::vec_set::VecSet<address>,
    }

    struct DexParams has key {
        id: 0x2::object::UID,
        l: u64,
        d: u64,
        t: u64,
        s: u64,
        kx: u64,
        ky: u64,
        px: u64,
        py: u64,
        ts: u64,
        st: u64,
    }

    public fun add_param_bot(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        0x2::vec_set::insert<address>(&mut arg0.param_bots, arg1);
    }

    fun assert_param_bot(arg0: &Registry, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.param_bots, &arg1), 2);
    }

    public fun create_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        validate_param(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<DexParams>(new_params(arg0, arg1, arg2, arg3, arg4, arg5, 0, 0, arg6, arg8));
    }

    public(friend) fun flatten(arg0: &DexParams, arg1: u64) : (u256, u256, u256, u256, u256, u256, u256, u256) {
        assert!(arg0.ts + arg0.st >= arg1, 3);
        ((arg0.l as u256), (arg0.d as u256), (arg0.t as u256), (arg0.s as u256), (arg0.kx as u256), (arg0.ky as u256), (arg0.px as u256), (arg0.py as u256))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id         : 0x2::object::new(arg0),
            param_bots : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public(friend) fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : DexParams {
        DexParams{
            id : 0x2::object::new(arg9),
            l  : arg0,
            d  : arg1,
            t  : arg2,
            s  : arg3,
            kx : arg4,
            ky : arg5,
            px : arg6,
            py : arg7,
            ts : 0,
            st : arg8,
        }
    }

    public fun remove_param_bot(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        0x2::vec_set::remove<address>(&mut arg0.param_bots, &arg1);
    }

    public fun update_params(arg0: &mut DexParams, arg1: &Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert_param_bot(arg1, 0x2::tx_context::sender(arg8));
        validate_param(arg2, arg3, arg4, arg5, arg6, arg7);
        arg0.l = arg2;
        arg0.d = arg3;
        arg0.t = arg4;
        arg0.s = arg5;
        arg0.kx = arg6;
        arg0.ky = arg7;
    }

    public fun update_price(arg0: &mut DexParams, arg1: &Registry, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_param_bot(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg2 > 0 && arg3 >= arg2, 1);
        arg0.px = arg2;
        arg0.py = arg3;
        arg0.ts = 0x2::clock::timestamp_ms(arg4);
    }

    public fun update_threshold(arg0: &mut DexParams, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0, 0);
        arg0.st = arg1;
    }

    fun validate_param(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::float_scaling();
        let v1 = if (arg0 >= 0) {
            if (arg1 > 0) {
                if (arg2 > 0) {
                    if (arg2 <= v0) {
                        arg3 >= v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = if (arg4 > 0) {
            if (arg4 <= 2 * v0) {
                if (arg5 > 0) {
                    arg5 <= 2 * v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0);
    }

    // decompiled from Move bytecode v6
}

