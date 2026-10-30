module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::pas_state {
    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AllocationKey has copy, drop, store {
        pos0: address,
    }

    struct Allocation has copy, drop, store {
        bps: u64,
        deposited: u64,
    }

    public(friend) fun allocation_key(arg0: address) : AllocationKey {
        AllocationKey{pos0: arg0}
    }

    public(friend) fun bps(arg0: &Allocation) : u64 {
        arg0.bps
    }

    public(friend) fun deposited(arg0: &Allocation) : u64 {
        arg0.deposited
    }

    public(friend) fun is_listed(arg0: &Allocation) : bool {
        arg0.bps > 0
    }

    public(friend) fun limit(arg0: &Allocation, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0.bps == 10000) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((0x1::u128::div_ceil((arg1 as u128) * (arg0.bps as u128), (10000 as u128)) as u64))
    }

    public(friend) fun new_allocation(arg0: u64, arg1: u64) : Allocation {
        assert!(arg0 <= 10000, 13835058218490986498);
        Allocation{
            bps       : arg0,
            deposited : arg1,
        }
    }

    public(friend) fun policy_cap_key() : PolicyCapKey {
        PolicyCapKey{dummy_field: false}
    }

    public(friend) fun record_deposit(arg0: &mut Allocation, arg1: u64, arg2: u64) {
        let v0 = arg0.deposited + arg1;
        let v1 = limit(arg0, arg2);
        assert!(0x1::option::is_none<u64>(&v1) || v0 <= *0x1::option::borrow<u64>(&v1), 13835339860971552772);
        arg0.deposited = v0;
    }

    public(friend) fun record_withdrawal(arg0: &mut Allocation, arg1: u64) {
        arg0.deposited = 0x1::u64::saturating_sub(arg0.deposited, arg1);
    }

    public(friend) fun set_bps(arg0: &mut Allocation, arg1: u64) {
        assert!(arg1 <= 10000, 13835058330160136194);
        arg0.bps = arg1;
    }

    public(friend) fun set_deposited(arg0: &mut Allocation, arg1: u64) {
        arg0.deposited = arg1;
    }

    // decompiled from Move bytecode v7
}

