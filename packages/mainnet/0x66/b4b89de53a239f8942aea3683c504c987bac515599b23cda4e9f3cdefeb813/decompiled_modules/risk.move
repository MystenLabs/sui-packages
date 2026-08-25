module 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::risk {
    struct OpCounter {
        vault_id: 0x2::object::ID,
        used: u64,
        cap: u64,
    }

    public fun assert_batch_size(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::batch_too_large());
    }

    public fun assert_deposit_size(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 <= arg1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::deposit_too_large());
        };
    }

    public fun assert_order_size(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 <= arg1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::order_too_large());
        };
    }

    public fun assert_withdraw_size(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            assert!(arg0 <= arg1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::withdraw_too_large());
        };
    }

    public fun charge(arg0: &mut OpCounter, arg1: u64) {
        let v0 = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::add(arg0.used, arg1);
        assert!(v0 <= arg0.cap, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::ptb_too_many_ops());
        arg0.used = v0;
    }

    public fun counter_cap(arg0: &OpCounter) : u64 {
        arg0.cap
    }

    public fun counter_used(arg0: &OpCounter) : u64 {
        arg0.used
    }

    public fun counter_vault_id(arg0: &OpCounter) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun destroy_counter(arg0: OpCounter) {
        let OpCounter {
            vault_id : _,
            used     : _,
            cap      : _,
        } = arg0;
    }

    public fun new_op_counter(arg0: 0x2::object::ID, arg1: u64) : OpCounter {
        OpCounter{
            vault_id : arg0,
            used     : 0,
            cap      : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

