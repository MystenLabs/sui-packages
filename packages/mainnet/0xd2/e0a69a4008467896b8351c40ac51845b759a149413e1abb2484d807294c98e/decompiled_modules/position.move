module 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::position {
    struct AccountPositionUpdateEvent has copy, drop {
        position: UserPosition,
        sender: address,
        action: u8,
    }

    struct PositionClosedEvent has copy, drop {
        perpID: 0x2::object::ID,
        account: address,
        amount: u128,
    }

    struct UserPosition has copy, drop, store {
        user: address,
        perpID: 0x2::object::ID,
        isPosPositive: bool,
        qPos: u128,
        margin: u128,
        oiOpen: u128,
        mro: u128,
        index: 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::funding_rate::FundingIndex,
    }

    public fun compute_average_entry_price(arg0: UserPosition) : u128 {
        if (arg0.qPos == 0) {
            0
        } else {
            0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::library::base_div(arg0.oiOpen, arg0.qPos)
        }
    }

    public fun compute_margin_ratio(arg0: UserPosition, arg1: u128) : 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::Number {
        let v0 = 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::one();
        let v1 = v0;
        if (arg0.qPos == 0) {
            return v0
        };
        let v2 = 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::library::base_mul(arg1, arg0.qPos);
        if (arg0.isPosPositive) {
            if (v2 > 0) {
                v1 = 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::sub(v0, 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::div_uint(0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::from_subtraction(arg0.oiOpen, arg0.margin), v2));
            };
        } else if (v2 > 0) {
            v1 = 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::from_subtraction(0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::library::base_div(arg0.oiOpen + arg0.margin, v2), 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::library::base_uint());
        };
        v1
    }

    public fun compute_pnl_per_unit(arg0: UserPosition, arg1: u128) : 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::Number {
        if (arg0.isPosPositive) {
            0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::from_subtraction(arg1, compute_average_entry_price(arg0))
        } else {
            0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::from_subtraction(compute_average_entry_price(arg0), arg1)
        }
    }

    public(friend) fun create_position(arg0: 0x2::object::ID, arg1: &mut 0x2::table::Table<address, UserPosition>, arg2: address) {
        if (!0x2::table::contains<address, UserPosition>(arg1, arg2)) {
            0x2::table::add<address, UserPosition>(arg1, arg2, initialize(arg0, arg2));
        };
    }

    public(friend) fun emit_position_closed_event(arg0: 0x2::object::ID, arg1: address, arg2: u128) {
        let v0 = PositionClosedEvent{
            perpID  : arg0,
            account : arg1,
            amount  : arg2,
        };
        0x2::event::emit<PositionClosedEvent>(v0);
    }

    public(friend) fun emit_position_update_event(arg0: UserPosition, arg1: address, arg2: u8) {
        let v0 = AccountPositionUpdateEvent{
            position : arg0,
            sender   : arg1,
            action   : arg2,
        };
        0x2::event::emit<AccountPositionUpdateEvent>(v0);
    }

    public fun index(arg0: UserPosition) : 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::funding_rate::FundingIndex {
        arg0.index
    }

    public(friend) fun initialize(arg0: 0x2::object::ID, arg1: address) : UserPosition {
        UserPosition{
            user          : arg1,
            perpID        : arg0,
            isPosPositive : false,
            qPos          : 0,
            margin        : 0,
            oiOpen        : 0,
            mro           : 0,
            index         : 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::funding_rate::initialize_index(0),
        }
    }

    public fun isPosPositive(arg0: UserPosition) : bool {
        arg0.isPosPositive
    }

    public fun is_undercollat(arg0: UserPosition, arg1: u128, arg2: u128) : bool {
        0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::lt_uint(compute_margin_ratio(arg0, arg1), arg2)
    }

    public fun margin(arg0: UserPosition) : u128 {
        arg0.margin
    }

    public fun mro(arg0: UserPosition) : u128 {
        arg0.mro
    }

    public fun oiOpen(arg0: UserPosition) : u128 {
        arg0.oiOpen
    }

    public fun qPos(arg0: UserPosition) : u128 {
        arg0.qPos
    }

    public(friend) fun set_index(arg0: &mut UserPosition, arg1: 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::funding_rate::FundingIndex) {
        arg0.index = arg1;
    }

    public(friend) fun set_isPosPositive(arg0: &mut UserPosition, arg1: bool) {
        arg0.isPosPositive = arg1;
    }

    public(friend) fun set_margin(arg0: &mut UserPosition, arg1: u128) {
        arg0.margin = arg1;
    }

    public(friend) fun set_mro(arg0: &mut UserPosition, arg1: u128) {
        if (arg0.qPos == 0) {
            arg0.mro = 0;
        } else {
            arg0.mro = arg1;
        };
    }

    public(friend) fun set_oiOpen(arg0: &mut UserPosition, arg1: u128) {
        arg0.oiOpen = arg1;
    }

    public(friend) fun set_qPos(arg0: &mut UserPosition, arg1: u128) {
        arg0.qPos = arg1;
        if (arg1 == 0) {
            set_isPosPositive(arg0, false);
            set_mro(arg0, 0);
        };
    }

    public fun user(arg0: UserPosition) : address {
        arg0.user
    }

    public fun verify_collat_checks(arg0: UserPosition, arg1: UserPosition, arg2: u128, arg3: u128, arg4: u128, arg5: u8, arg6: u64) {
        let v0 = compute_margin_ratio(arg1, arg4);
        if (0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::gte_uint(v0, arg2)) {
            return
        };
        assert!(arg1.isPosPositive == arg0.isPosPositive && arg0.qPos > 0, 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::error::mr_less_than_imr_can_not_open_or_flip_position(arg6));
        assert!(0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::gte(v0, compute_margin_ratio(arg0, arg4)), 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::error::mr_less_than_imr_mr_must_improve(arg6));
        assert!(0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::gt_uint(v0, arg3) || arg0.qPos >= arg1.qPos && arg0.isPosPositive == arg1.isPosPositive, 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::error::mr_less_than_imr_position_can_only_reduce(arg6));
        assert!(0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::signed_number::gte_uint(v0, 0) || arg5 == 2 || arg5 == 3, 0xd2e0a69a4008467896b8351c40ac51845b759a149413e1abb2484d807294c98e::error::mr_less_than_zero(arg6));
    }

    // decompiled from Move bytecode v6
}

