module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_accounting {
    struct FutureAccounting has store {
        epoch: u32,
        used_capacity: u64,
        rewards_to_distribute: 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>,
    }

    struct FutureAccountingRingBuffer has store {
        current_index: u32,
        length: u32,
        ring_buffer: vector<FutureAccounting>,
    }

    public(friend) fun delete_empty_future_accounting(arg0: FutureAccounting) {
        0x2::balance::destroy_zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(unwrap_balance(arg0));
    }

    public fun epoch(arg0: &FutureAccounting) : u32 {
        arg0.epoch
    }

    public(friend) fun increase_used_capacity(arg0: &mut FutureAccounting, arg1: u64) : u64 {
        arg0.used_capacity = arg0.used_capacity + arg1;
        arg0.used_capacity
    }

    public fun max_epochs_ahead(arg0: &FutureAccountingRingBuffer) : u32 {
        arg0.length
    }

    public(friend) fun new_future_accounting(arg0: u32, arg1: u64, arg2: 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) : FutureAccounting {
        FutureAccounting{
            epoch                 : arg0,
            used_capacity         : arg1,
            rewards_to_distribute : arg2,
        }
    }

    public fun rewards(arg0: &FutureAccounting) : u64 {
        0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg0.rewards_to_distribute)
    }

    public(friend) fun rewards_balance(arg0: &mut FutureAccounting) : &mut 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        &mut arg0.rewards_to_distribute
    }

    public fun ring_lookup(arg0: &FutureAccountingRingBuffer, arg1: u32) : &FutureAccounting {
        assert!(arg1 < arg0.length, 0);
        0x1::vector::borrow<FutureAccounting>(&arg0.ring_buffer, (((arg1 + arg0.current_index) % arg0.length) as u64))
    }

    public(friend) fun ring_lookup_mut(arg0: &mut FutureAccountingRingBuffer, arg1: u32) : &mut FutureAccounting {
        assert!(arg1 < arg0.length, 0);
        0x1::vector::borrow_mut<FutureAccounting>(&mut arg0.ring_buffer, (((arg1 + arg0.current_index) % arg0.length) as u64))
    }

    public(friend) fun ring_new(arg0: u32) : FutureAccountingRingBuffer {
        let v0 = 0x1::vector::empty<FutureAccounting>();
        let v1 = 0;
        while (v1 < (arg0 as u64)) {
            let v2 = FutureAccounting{
                epoch                 : (v1 as u32),
                used_capacity         : 0,
                rewards_to_distribute : 0x2::balance::zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(),
            };
            0x1::vector::push_back<FutureAccounting>(&mut v0, v2);
            v1 = v1 + 1;
        };
        FutureAccountingRingBuffer{
            current_index : 0,
            length        : arg0,
            ring_buffer   : v0,
        }
    }

    public(friend) fun ring_pop_expand(arg0: &mut FutureAccountingRingBuffer) : FutureAccounting {
        let v0 = arg0.current_index;
        let v1 = FutureAccounting{
            epoch                 : 0x1::vector::borrow<FutureAccounting>(&arg0.ring_buffer, (v0 as u64)).epoch + arg0.length,
            used_capacity         : 0,
            rewards_to_distribute : 0x2::balance::zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(),
        };
        0x1::vector::push_back<FutureAccounting>(&mut arg0.ring_buffer, v1);
        arg0.current_index = (v0 + 1) % arg0.length;
        0x1::vector::swap_remove<FutureAccounting>(&mut arg0.ring_buffer, (v0 as u64))
    }

    public(friend) fun unwrap_balance(arg0: FutureAccounting) : 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        let FutureAccounting {
            epoch                 : _,
            used_capacity         : _,
            rewards_to_distribute : v2,
        } = arg0;
        v2
    }

    public fun used_capacity(arg0: &FutureAccounting) : u64 {
        arg0.used_capacity
    }

    // decompiled from Move bytecode v6
}

