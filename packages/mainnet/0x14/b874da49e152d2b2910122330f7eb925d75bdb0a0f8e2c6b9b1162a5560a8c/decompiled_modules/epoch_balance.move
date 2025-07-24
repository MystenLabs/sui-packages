module 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance {
    struct EpochBalance has copy, drop, store {
        epoch: u32,
        balance: u64,
    }

    struct EpochBalanceRingBuffer has store {
        current_index: u32,
        ring_buffer: vector<EpochBalance>,
    }

    public(friend) fun length(arg0: &EpochBalanceRingBuffer) : u32 {
        (0x1::vector::length<EpochBalance>(&arg0.ring_buffer) as u32)
    }

    public(friend) fun balance(arg0: &EpochBalance) : u64 {
        arg0.balance
    }

    public(friend) fun epoch(arg0: &EpochBalance) : u32 {
        arg0.epoch
    }

    public(friend) fun ring_lookup(arg0: &EpochBalanceRingBuffer, arg1: u32) : &EpochBalance {
        assert!(arg1 < length(arg0), 0);
        0x1::vector::borrow<EpochBalance>(&arg0.ring_buffer, (((arg1 + arg0.current_index) % length(arg0)) as u64))
    }

    public(friend) fun ring_lookup_mut(arg0: &mut EpochBalanceRingBuffer, arg1: u32) : &mut EpochBalance {
        assert!(arg1 < length(arg0), 0);
        0x1::vector::borrow_mut<EpochBalance>(&mut arg0.ring_buffer, (((arg1 + arg0.current_index) % length(arg0)) as u64))
    }

    public(friend) fun ring_new_from_balances(arg0: u32, arg1: vector<u64>) : EpochBalanceRingBuffer {
        let v0 = 0x1::vector::empty<EpochBalance>();
        0x1::vector::reverse<u64>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = EpochBalance{
                epoch   : arg0,
                balance : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            arg0 = arg0 + 1;
            0x1::vector::push_back<EpochBalance>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
        EpochBalanceRingBuffer{
            current_index : 0,
            ring_buffer   : v0,
        }
    }

    public(friend) fun ring_pop_expand(arg0: &mut EpochBalanceRingBuffer) : EpochBalance {
        let v0 = arg0.current_index;
        let v1 = EpochBalance{
            epoch   : 0x1::vector::borrow<EpochBalance>(&arg0.ring_buffer, (v0 as u64)).epoch + (length(arg0) as u32),
            balance : 0,
        };
        0x1::vector::push_back<EpochBalance>(&mut arg0.ring_buffer, v1);
        arg0.current_index = (v0 + 1) % length(arg0);
        0x1::vector::swap_remove<EpochBalance>(&mut arg0.ring_buffer, (v0 as u64))
    }

    public(friend) fun set_balance(arg0: &mut EpochBalance, arg1: u64) {
        arg0.balance = arg1;
    }

    // decompiled from Move bytecode v6
}

