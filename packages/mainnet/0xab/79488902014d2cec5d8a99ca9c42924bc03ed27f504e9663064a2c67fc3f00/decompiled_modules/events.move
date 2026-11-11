module 0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        by: address,
    }

    struct SwapForwarded has copy, drop {
        intent_id: vector<u8>,
        operator: address,
        recipient: address,
        usdc_in: u64,
        out_type: 0x1::type_name::TypeName,
        out_amount: u64,
    }

    struct SwapDeposited has copy, drop {
        intent_id: vector<u8>,
        seller: address,
        proceeds: u64,
    }

    struct Withdrawn has copy, drop {
        intent_id: 0x1::option::Option<vector<u8>>,
        operator: address,
        to: address,
        amount: u64,
        kind: u8,
    }

    struct Deposited has copy, drop {
        from: address,
        amount: u64,
    }

    struct ChangeReturned has copy, drop {
        amount: u64,
        by: address,
    }

    struct AssetRescued has copy, drop {
        asset: 0x1::type_name::TypeName,
        to: address,
        amount: u64,
    }

    struct ObjectRescued has copy, drop {
        kind: 0x1::type_name::TypeName,
        object: 0x2::object::ID,
        to: address,
    }

    struct Paused has copy, drop {
        by: address,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct OperatorSet has copy, drop {
        op: address,
        max_forward: u64,
        max_forwarded_per_window: u64,
    }

    struct OperatorRemoved has copy, drop {
        op: address,
    }

    struct PauserSet has copy, drop {
        who: address,
        allowed: bool,
    }

    struct WithdrawTargetSet has copy, drop {
        who: address,
        allowed: bool,
    }

    struct LimitsSet has copy, drop {
        max_forward: u64,
        max_refund: u64,
        max_withdraw: u64,
        min_move: u64,
        window_ms: u64,
        max_forwarded_per_window: u64,
        max_withdrawn_per_window: u64,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct AdminOffered has copy, drop {
        from: address,
        to: address,
        offer_id: 0x2::object::ID,
    }

    struct AdminAccepted has copy, drop {
        to: address,
        offer_id: 0x2::object::ID,
    }

    struct AdminOfferCancelled has copy, drop {
        from: address,
        offer_id: 0x2::object::ID,
    }

    public(friend) fun admin_accepted(arg0: address, arg1: 0x2::object::ID) {
        let v0 = AdminAccepted{
            to       : arg0,
            offer_id : arg1,
        };
        0x2::event::emit<AdminAccepted>(v0);
    }

    public(friend) fun admin_offer_cancelled(arg0: address, arg1: 0x2::object::ID) {
        let v0 = AdminOfferCancelled{
            from     : arg0,
            offer_id : arg1,
        };
        0x2::event::emit<AdminOfferCancelled>(v0);
    }

    public(friend) fun admin_offered(arg0: address, arg1: address, arg2: 0x2::object::ID) {
        let v0 = AdminOffered{
            from     : arg0,
            to       : arg1,
            offer_id : arg2,
        };
        0x2::event::emit<AdminOffered>(v0);
    }

    public(friend) fun asset_rescued(arg0: 0x1::type_name::TypeName, arg1: address, arg2: u64) {
        let v0 = AssetRescued{
            asset  : arg0,
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AssetRescued>(v0);
    }

    public(friend) fun change_returned(arg0: u64, arg1: address) {
        let v0 = ChangeReturned{
            amount : arg0,
            by     : arg1,
        };
        0x2::event::emit<ChangeReturned>(v0);
    }

    public(friend) fun deposited(arg0: address, arg1: u64) {
        let v0 = Deposited{
            from   : arg0,
            amount : arg1,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun limits_set(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = LimitsSet{
            max_forward              : arg0,
            max_refund               : arg1,
            max_withdraw             : arg2,
            min_move                 : arg3,
            window_ms                : arg4,
            max_forwarded_per_window : arg5,
            max_withdrawn_per_window : arg6,
        };
        0x2::event::emit<LimitsSet>(v0);
    }

    public(friend) fun migrated(arg0: u64, arg1: u64) {
        let v0 = Migrated{
            from : arg0,
            to   : arg1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun object_rescued(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID, arg2: address) {
        let v0 = ObjectRescued{
            kind   : arg0,
            object : arg1,
            to     : arg2,
        };
        0x2::event::emit<ObjectRescued>(v0);
    }

    public(friend) fun operator_removed(arg0: address) {
        let v0 = OperatorRemoved{op: arg0};
        0x2::event::emit<OperatorRemoved>(v0);
    }

    public(friend) fun operator_set(arg0: address, arg1: u64, arg2: u64) {
        let v0 = OperatorSet{
            op                       : arg0,
            max_forward              : arg1,
            max_forwarded_per_window : arg2,
        };
        0x2::event::emit<OperatorSet>(v0);
    }

    public(friend) fun paused(arg0: address) {
        let v0 = Paused{by: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun pauser_set(arg0: address, arg1: bool) {
        let v0 = PauserSet{
            who     : arg0,
            allowed : arg1,
        };
        0x2::event::emit<PauserSet>(v0);
    }

    public(friend) fun pool_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = PoolCreated{
            pool_id : arg0,
            asset   : arg1,
            by      : arg2,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun swap_deposited(arg0: vector<u8>, arg1: address, arg2: u64) {
        let v0 = SwapDeposited{
            intent_id : arg0,
            seller    : arg1,
            proceeds  : arg2,
        };
        0x2::event::emit<SwapDeposited>(v0);
    }

    public(friend) fun swap_forwarded(arg0: vector<u8>, arg1: address, arg2: address, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = SwapForwarded{
            intent_id  : arg0,
            operator   : arg1,
            recipient  : arg2,
            usdc_in    : arg3,
            out_type   : arg4,
            out_amount : arg5,
        };
        0x2::event::emit<SwapForwarded>(v0);
    }

    public(friend) fun unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public(friend) fun withdraw_target_set(arg0: address, arg1: bool) {
        let v0 = WithdrawTargetSet{
            who     : arg0,
            allowed : arg1,
        };
        0x2::event::emit<WithdrawTargetSet>(v0);
    }

    public(friend) fun withdrawn(arg0: 0x1::option::Option<vector<u8>>, arg1: address, arg2: address, arg3: u64, arg4: u8) {
        let v0 = Withdrawn{
            intent_id : arg0,
            operator  : arg1,
            to        : arg2,
            amount    : arg3,
            kind      : arg4,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

