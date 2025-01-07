module 0xabf877bdabe13436a252b1d3c5671c405b79c59e9238c5cec0c99454bd9cbaa6::leveraged_afsui_state {
    struct LeveragedAfSuiState has store, key {
        id: 0x2::object::UID,
        total_afsui_collateral: u64,
        total_sui_debt: u64,
        protocol_version: u64,
    }

    public(friend) fun assert_protocol_version(arg0: &LeveragedAfSuiState) {
        assert!(arg0.protocol_version == 1, 0);
    }

    public(friend) fun decrease_state_counters(arg0: &mut LeveragedAfSuiState, arg1: u64, arg2: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral - arg1;
        arg0.total_sui_debt = arg0.total_sui_debt - arg2;
    }

    public(friend) fun increase_state_counters(arg0: &mut LeveragedAfSuiState, arg1: u64, arg2: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral + arg1;
        arg0.total_sui_debt = arg0.total_sui_debt + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeveragedAfSuiState{
            id                     : 0x2::object::new(arg0),
            total_afsui_collateral : 0,
            total_sui_debt         : 0,
            protocol_version       : 1,
        };
        0x2::transfer::share_object<LeveragedAfSuiState>(v0);
    }

    public fun total_afsui_collateral(arg0: &LeveragedAfSuiState) : u64 {
        arg0.total_afsui_collateral
    }

    public fun total_sui_debt(arg0: &LeveragedAfSuiState) : u64 {
        arg0.total_sui_debt
    }

    // decompiled from Move bytecode v6
}

