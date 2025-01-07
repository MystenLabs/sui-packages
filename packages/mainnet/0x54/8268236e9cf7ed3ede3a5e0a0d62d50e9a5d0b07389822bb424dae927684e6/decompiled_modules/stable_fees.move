module 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::stable_fees {
    struct StableFees has copy, drop, store {
        fee_in_percent: u256,
        fee_out_percent: u256,
        admin_fee_percent: u256,
    }

    public fun admin_fee_percent(arg0: &StableFees) : u256 {
        arg0.admin_fee_percent
    }

    public fun calculate_admin_amount(arg0: &StableFees, arg1: u64) : u64 {
        calculate_fee_amount(arg1, arg0.admin_fee_percent)
    }

    fun calculate_fee_amount(arg0: u64, arg1: u256) : u64 {
        (0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::fixed_point_wad::mul_up((arg0 as u256), arg1) as u64)
    }

    public fun calculate_fee_in_amount(arg0: &StableFees, arg1: u64) : u64 {
        calculate_fee_amount(arg1, arg0.fee_in_percent)
    }

    public fun calculate_fee_out_amount(arg0: &StableFees, arg1: u64) : u64 {
        calculate_fee_amount(arg1, arg0.fee_out_percent)
    }

    public fun fee_in_percent(arg0: &StableFees) : u256 {
        arg0.fee_in_percent
    }

    public fun fee_out_percent(arg0: &StableFees) : u256 {
        arg0.fee_out_percent
    }

    public fun new() : StableFees {
        StableFees{
            fee_in_percent    : 250000000000000,
            fee_out_percent   : 250000000000000,
            admin_fee_percent : 0,
        }
    }

    public fun update_admin_fee_percent(arg0: &mut StableFees, arg1: 0x1::option::Option<u256>) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = 0x1::option::extract<u256>(&mut arg1);
        assert!(200000000000000000 >= v0, 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::errors::invalid_fee());
        arg0.admin_fee_percent = v0;
    }

    public fun update_fee_in_percent(arg0: &mut StableFees, arg1: 0x1::option::Option<u256>) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = 0x1::option::extract<u256>(&mut arg1);
        assert!(20000000000000000 >= v0, 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::errors::invalid_fee());
        arg0.fee_in_percent = v0;
    }

    public fun update_fee_out_percent(arg0: &mut StableFees, arg1: 0x1::option::Option<u256>) {
        if (0x1::option::is_none<u256>(&arg1)) {
            return
        };
        let v0 = 0x1::option::extract<u256>(&mut arg1);
        assert!(20000000000000000 >= v0, 0x548268236e9cf7ed3ede3a5e0a0d62d50e9a5d0b07389822bb424dae927684e6::errors::invalid_fee());
        arg0.fee_out_percent = v0;
    }

    // decompiled from Move bytecode v6
}

