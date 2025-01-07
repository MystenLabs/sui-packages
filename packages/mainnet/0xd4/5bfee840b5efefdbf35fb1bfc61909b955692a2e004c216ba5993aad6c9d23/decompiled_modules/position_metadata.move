module 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata {
    struct PositionMetadata has copy, drop, store {
        base_afsui_collateral: u64,
        total_afsui_collateral: u64,
        total_sui_debt: u64,
    }

    public(friend) fun afsui_collateral(arg0: &PositionMetadata) : u64 {
        arg0.total_afsui_collateral
    }

    public(friend) fun base_afsui_collateral(arg0: &PositionMetadata) : u64 {
        arg0.base_afsui_collateral
    }

    public(friend) fun decrease_base_afsui_collateral(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.base_afsui_collateral = arg0.base_afsui_collateral - arg1;
    }

    public(friend) fun decrease_total_afsui_collateral(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral - arg1;
    }

    public(friend) fun decrease_total_sui_debt(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.total_sui_debt = arg0.total_sui_debt - arg1;
    }

    public(friend) fun increase_base_afsui_collateral(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.base_afsui_collateral = arg0.base_afsui_collateral + arg1;
    }

    public(friend) fun increase_total_afsui_collateral(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral + arg1;
    }

    public(friend) fun increase_total_sui_debt(arg0: &mut PositionMetadata, arg1: u64) {
        arg0.total_sui_debt = arg0.total_sui_debt + arg1;
    }

    public(friend) fun leverage_ratio(arg0: &PositionMetadata) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::utils::calc_leverage_ratio(arg0.total_afsui_collateral, arg0.total_sui_debt)
    }

    public(friend) fun loan_to_value(arg0: &PositionMetadata) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::utils::calc_loan_to_value(arg0.total_afsui_collateral, arg0.total_sui_debt)
    }

    public(friend) fun new() : PositionMetadata {
        PositionMetadata{
            base_afsui_collateral  : 0,
            total_afsui_collateral : 0,
            total_sui_debt         : 0,
        }
    }

    public(friend) fun sui_debt(arg0: &PositionMetadata) : u64 {
        arg0.total_sui_debt
    }

    // decompiled from Move bytecode v6
}

