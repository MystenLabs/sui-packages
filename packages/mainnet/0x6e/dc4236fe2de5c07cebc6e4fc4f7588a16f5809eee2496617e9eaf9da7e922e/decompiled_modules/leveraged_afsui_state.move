module 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::leveraged_afsui_state {
    struct LeveragedAfSuiState has store, key {
        id: 0x2::object::UID,
        total_afsui_collateral: u64,
        total_sui_debt: u64,
        protocol_version: u64,
    }

    public(friend) fun assert_protocol_version(arg0: &LeveragedAfSuiState) {
        assert!(arg0.protocol_version == 1, 0);
    }

    public(friend) fun decrease_total_afsui_collateral(arg0: &mut LeveragedAfSuiState, arg1: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral - arg1;
    }

    public(friend) fun decrease_total_sui_debt(arg0: &mut LeveragedAfSuiState, arg1: u64) {
        arg0.total_sui_debt = arg0.total_sui_debt - arg1;
    }

    public(friend) fun increase_total_afsui_collateral(arg0: &mut LeveragedAfSuiState, arg1: u64) {
        arg0.total_afsui_collateral = arg0.total_afsui_collateral + arg1;
    }

    public(friend) fun increase_total_sui_debt(arg0: &mut LeveragedAfSuiState, arg1: u64) {
        arg0.total_sui_debt = arg0.total_sui_debt + arg1;
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

