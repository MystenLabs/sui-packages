module 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::leveraged_afsui_position {
    struct LeveragedAfSuiPosition has store, key {
        id: 0x2::object::UID,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        position_metadata: 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::PositionMetadata,
    }

    public fun afsui_collateral(arg0: &LeveragedAfSuiPosition) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::afsui_collateral(&arg0.position_metadata)
    }

    public fun base_afsui_collateral(arg0: &LeveragedAfSuiPosition) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::base_afsui_collateral(&arg0.position_metadata)
    }

    public fun leverage_ratio(arg0: &LeveragedAfSuiPosition) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::leverage_ratio(&arg0.position_metadata)
    }

    public fun loan_to_value(arg0: &LeveragedAfSuiPosition) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::loan_to_value(&arg0.position_metadata)
    }

    public fun obligation_key(arg0: &LeveragedAfSuiPosition) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &arg0.obligation_key
    }

    public(friend) fun obligation_key_mut(arg0: &mut LeveragedAfSuiPosition) : &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey {
        &mut arg0.obligation_key
    }

    public fun open_obligation(arg0: &mut 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::leveraged_afsui_state::LeveragedAfSuiState, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0x2::tx_context::TxContext) : (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, LeveragedAfSuiPosition, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::ObligationHotPotato) {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::leveraged_afsui_state::assert_protocol_version(arg0);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg2);
        let v3 = LeveragedAfSuiPosition{
            id                : 0x2::object::new(arg2),
            obligation_key    : v1,
            position_metadata : 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::new(),
        };
        (v0, v3, v2)
    }

    public fun position_metadata(arg0: &LeveragedAfSuiPosition) : 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::PositionMetadata {
        arg0.position_metadata
    }

    public fun return_obligation(arg0: &mut 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::leveraged_afsui_state::LeveragedAfSuiState, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::ObligationHotPotato) {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::leveraged_afsui_state::assert_protocol_version(arg0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg1, arg2, arg3);
    }

    public(friend) fun set_position_metadata(arg0: &mut LeveragedAfSuiPosition, arg1: 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::PositionMetadata) {
        arg0.position_metadata = arg1;
    }

    public fun sui_debt(arg0: &LeveragedAfSuiPosition) : u64 {
        0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::position_metadata::sui_debt(&arg0.position_metadata)
    }

    // decompiled from Move bytecode v6
}

