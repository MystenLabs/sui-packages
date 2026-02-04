module 0x652e2d10792bf6534c5f00faccdef0687c7eb89d30b6f65f1e03902e91d2f7ab::pending {
    struct PendingAmount has store {
        value: 0x1::option::Option<u128>,
        valid_at: u64,
    }

    struct PendingAddress has store {
        value: 0x1::option::Option<address>,
        valid_at: u64,
    }

    public fun empty_pending_address() : PendingAddress {
        PendingAddress{
            value    : 0x1::option::none<address>(),
            valid_at : 0,
        }
    }

    public fun empty_pending_amount() : PendingAmount {
        PendingAmount{
            value    : 0x1::option::none<u128>(),
            valid_at : 0,
        }
    }

    public(friend) fun revoke_pending(arg0: &mut PendingAmount) : (u128, u64) {
        let v0 = arg0.valid_at;
        if (v0 == 0) {
            abort 2
        };
        arg0.valid_at = 0;
        (0x1::option::extract<u128>(&mut arg0.value), v0)
    }

    public(friend) fun set_pending_address(arg0: &mut PendingAddress, arg1: address, arg2: u64) {
        arg0.value = 0x1::option::some<address>(arg1);
        arg0.valid_at = arg2;
    }

    public(friend) fun set_pending_amount(arg0: &mut PendingAmount, arg1: u128, arg2: u64) {
        arg0.value = 0x1::option::some<u128>(arg1);
        arg0.valid_at = arg2;
    }

    public(friend) fun take_pending_address(arg0: &mut PendingAddress, arg1: u64) : address {
        if (arg0.valid_at == 0 || arg1 < arg0.valid_at) {
            abort 2
        };
        arg0.valid_at = 0;
        0x1::option::extract<address>(&mut arg0.value)
    }

    public(friend) fun take_pending_amount(arg0: &mut PendingAmount, arg1: u64) : u128 {
        if (arg0.valid_at == 0 || arg1 < arg0.valid_at) {
            abort 2
        };
        arg0.valid_at = 0;
        0x1::option::extract<u128>(&mut arg0.value)
    }

    // decompiled from Move bytecode v6
}

