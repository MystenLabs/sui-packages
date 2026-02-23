module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees {
    struct StableFees has copy, drop, store {
        fee: u256,
        admin_fee: u256,
        future_fee: 0x1::option::Option<u256>,
        future_admin_fee: 0x1::option::Option<u256>,
        deadline: u64,
    }

    public(friend) fun admin_fee(arg0: &StableFees) : u256 {
        arg0.admin_fee
    }

    fun assert_epoch(arg0: &StableFees, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) > arg0.deadline, 5);
    }

    public(friend) fun calculate_admin_fee(arg0: &StableFees, arg1: u256) : u256 {
        calculate_fee_amount(arg1, arg0.admin_fee)
    }

    public(friend) fun calculate_fee(arg0: &StableFees, arg1: u256) : u256 {
        calculate_fee_amount(arg1, arg0.fee)
    }

    fun calculate_fee_amount(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u256::mul_div_up(arg0, arg1, 1000000000000000000);
        let v1 = if (v0 != 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 == 0
        };
        assert!(v1, 18);
        v0
    }

    public(friend) fun commit_admin_fee(arg0: &mut StableFees, arg1: 0x1::option::Option<u256>, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = *0x1::option::borrow<u256>(&arg1);
        assert!(300000000000000000 >= v0, 4);
        update_deadline(arg0, arg2);
        arg0.future_admin_fee = 0x1::option::some<u256>(v0);
    }

    public(friend) fun commit_fee(arg0: &mut StableFees, arg1: 0x1::option::Option<u256>, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = *0x1::option::borrow<u256>(&arg1);
        assert!(20000000000000000 >= v0, 4);
        update_deadline(arg0, arg2);
        arg0.future_fee = 0x1::option::some<u256>(v0);
    }

    public(friend) fun deadline(arg0: &StableFees) : u64 {
        arg0.deadline
    }

    public(friend) fun fee(arg0: &StableFees) : u256 {
        arg0.fee
    }

    public(friend) fun future_admin_fee(arg0: &StableFees) : 0x1::option::Option<u256> {
        arg0.future_admin_fee
    }

    public(friend) fun future_fee(arg0: &StableFees) : 0x1::option::Option<u256> {
        arg0.future_fee
    }

    public(friend) fun new() : StableFees {
        StableFees{
            fee              : 500000000000000,
            admin_fee        : 300000000000000000,
            future_fee       : 0x1::option::none<u256>(),
            future_admin_fee : 0x1::option::none<u256>(),
            deadline         : 18446744073709551615,
        }
    }

    public(friend) fun reset_deadline(arg0: &mut StableFees) {
        arg0.deadline = 18446744073709551615;
    }

    public(friend) fun update_admin_fee(arg0: &mut StableFees, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_none<u256>(&arg0.future_admin_fee)) {
            return
        };
        assert_epoch(arg0, arg1);
        arg0.admin_fee = 0x1::option::extract<u256>(&mut arg0.future_admin_fee);
    }

    fun update_deadline(arg0: &mut StableFees, arg1: &0x2::tx_context::TxContext) {
        arg0.deadline = 0x2::tx_context::epoch(arg1) + 3;
    }

    public(friend) fun update_fee(arg0: &mut StableFees, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_none<u256>(&arg0.future_fee)) {
            return
        };
        assert_epoch(arg0, arg1);
        arg0.fee = 0x1::option::extract<u256>(&mut arg0.future_fee);
    }

    // decompiled from Move bytecode v6
}

