module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::events {
    struct SwapCompletedEvent has copy, drop {
        sender: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        referral: address,
    }

    struct StakeCompletedEvent has copy, drop {
        sender: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        referral: address,
    }

    struct UnstakeCompletedEvent has copy, drop {
        sender: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        referral: address,
    }

    struct FlashloanEvent has copy, drop {
        sender: address,
        type_name: 0x1::ascii::String,
        amount: u64,
    }

    struct StakeEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct ZeroObjectEvent has copy, drop {
        sender: address,
    }

    struct MultiZeroObjectEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct ClaimCroEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct AddPointsEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct RemovePointsEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        typeName: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun emit_add_points_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = AddPointsEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<AddPointsEvent>(v0);
    }

    public(friend) fun emit_claim_cro_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = ClaimCroEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<ClaimCroEvent>(v0);
    }

    public(friend) fun emit_flashloan_event(arg0: vector<u8>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = FlashloanEvent{
            sender    : 0x2::tx_context::sender(arg2),
            type_name : 0x1::ascii::string(arg0),
            amount    : arg1,
        };
        0x2::event::emit<FlashloanEvent>(v0);
    }

    public(friend) fun emit_multi_zero_object_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = MultiZeroObjectEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<MultiZeroObjectEvent>(v0);
    }

    public(friend) fun emit_remove_points_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = RemovePointsEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<RemovePointsEvent>(v0);
    }

    public(friend) fun emit_stake_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        let v0 = StakeCompletedEvent{
            sender     : 0x2::tx_context::sender(arg5),
            type_in    : 0x1::ascii::string(arg0),
            amount_in  : arg1,
            type_out   : 0x1::ascii::string(arg2),
            amount_out : arg3,
            referral   : arg4,
        };
        0x2::event::emit<StakeCompletedEvent>(v0);
    }

    public(friend) fun emit_stake_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = StakeEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public(friend) fun emit_swap_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        let v0 = SwapCompletedEvent{
            sender     : 0x2::tx_context::sender(arg5),
            type_in    : 0x1::ascii::string(arg0),
            amount_in  : arg1,
            type_out   : 0x1::ascii::string(arg2),
            amount_out : arg3,
            referral   : arg4,
        };
        0x2::event::emit<SwapCompletedEvent>(v0);
    }

    public(friend) fun emit_unstake_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        let v0 = UnstakeCompletedEvent{
            sender     : 0x2::tx_context::sender(arg5),
            type_in    : 0x1::ascii::string(arg0),
            amount_in  : arg1,
            type_out   : 0x1::ascii::string(arg2),
            amount_out : arg3,
            referral   : arg4,
        };
        0x2::event::emit<UnstakeCompletedEvent>(v0);
    }

    public(friend) fun emit_unstake_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = UnstakeEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    public(friend) fun emit_withdraw_event<T0>(arg0: u64) {
        let v0 = WithdrawEvent{
            typeName : 0x1::type_name::get<T0>(),
            amount   : arg0,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun emit_zero_object_event(arg0: &0x2::tx_context::TxContext) {
        let v0 = ZeroObjectEvent{sender: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<ZeroObjectEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

