module 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::quest {
    struct SetCheckinFeeEvent has copy, drop, store {
        fee: u64,
        type: 0x1::type_name::TypeName,
    }

    struct EventCheckin has copy, drop, store {
        user: address,
        day: u64,
        last_checkin_time: u64,
    }

    struct ClaimBonusEvent has copy, drop, store {
        user: address,
        task_id: 0x1::string::String,
        sub_task_id: 0x1::string::String,
        nonce: u128,
    }

    public fun checkin(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 8001
    }

    public fun checkin_v2<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::GlobalVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 8001
    }

    public fun claim_bonus_point<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::GlobalVault, arg2: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 8001
    }

    public fun migrate(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: u64) {
        abort 8001
    }

    public fun paused(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: bool) {
        abort 8001
    }

    public fun register(arg0: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Logs, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::UserArchive {
        abort 8001
    }

    public fun set_checkin_fee<T0>(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: u64) {
        abort 8001
    }

    public fun set_max_check_in_days(arg0: &0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::AdminCap, arg1: &mut 0xa2865255b1dd6e359658ae28a05db9ee199d1b426513298a8a218e5accce3002::guild::Config, arg2: u64) {
        abort 8001
    }

    // decompiled from Move bytecode v6
}

