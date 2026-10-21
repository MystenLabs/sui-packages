module 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account {
    struct PendingPermit has store {
        account_id: 0x2::object::ID,
        close: 0x1::option::Option<u64>,
    }

    struct AccountKey has copy, drop, store {
        owner: address,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AccountCap has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    struct Position has store {
        id: u64,
        market_id: 0x2::object::ID,
        is_long: bool,
        entry_px_wad: u128,
        margin: u64,
        leverage: u64,
        notional: u64,
        bust_px_wad: u128,
        opened_at_ms: u64,
        open_oracle_ts_ms: u64,
        open_oracle_sequence: u64,
        winning_exposure: u64,
        factor_bps: u64,
        win_fee_bps: u64,
        deadband_ppm: u64,
        close_fee_ppm: u64,
        open_fee: u64,
        wash: bool,
        builder_id: 0x1::option::Option<u32>,
        builder_share_bps: u16,
    }

    struct AccountStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        cap_id: 0x2::object::ID,
        open_notional: u64,
        positions: 0x2::table::Table<u64, Position>,
        delegates: 0x2::vec_map::VecMap<address, u64>,
        side_long: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        side_short: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        last_close_market: 0x1::option::Option<0x2::object::ID>,
        last_close_long: bool,
        last_close_ts: u64,
        exchange_id: 0x2::object::ID,
        hedged: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
        pending_orders: u64,
        pending_close_positions: 0x2::vec_set::VecSet<u64>,
    }

    public fun account_address(arg0: 0x2::object::ID, arg1: address) : address {
        let v0 = AccountKey{owner: arg1};
        0x2::derived_object::derive_address<AccountKey>(arg0, v0)
    }

    public fun account_exists(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = AccountKey{owner: arg1};
        0x2::derived_object::exists<AccountKey>(arg0, v0)
    }

    public fun add_open_notional<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.open_notional = v0.open_notional + arg2;
    }

    public(friend) fun add_pending_close<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        0x2::vec_set::insert<u64>(&mut state_mut<T0>(arg1).pending_close_positions, arg2);
    }

    public fun add_side<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = if (arg3) {
            &mut state_mut<T0>(arg1).side_long
        } else {
            &mut state_mut<T0>(arg1).side_short
        };
        if (0x2::vec_map::contains<0x2::object::ID, u64>(v0, &arg2)) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(v0, &arg2);
            *v1 = *v1 + arg4;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(v0, arg2, arg4);
        };
    }

    fun assert_auth<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &Account<T0>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound(arg0, state<T0>(arg1).exchange_id);
    }

    fun assert_auth_refund<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &Account<T0>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound_refund(arg0, state<T0>(arg1).exchange_id);
    }

    public fun assert_cap<T0>(arg0: &Account<T0>, arg1: &AccountCap) {
        assert_version<T0>(arg0);
        assert!(arg1.account_id == 0x2::object::id<Account<T0>>(arg0), 13836747708302098445);
        assert!(state<T0>(arg0).cap_id == 0x2::object::id<AccountCap>(arg1), 13836747712597065741);
    }

    public fun assert_delegate<T0>(arg0: &Account<T0>, arg1: address, arg2: u64) {
        assert_version<T0>(arg0);
        let v0 = &state<T0>(arg0).delegates;
        assert!(0x2::vec_map::contains<address, u64>(v0, &arg1), 13835621847049437189);
        assert!(*0x2::vec_map::get<address, u64>(v0, &arg1) > arg2, 13835621851344404485);
    }

    public fun assert_exchange<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID) {
        assert!(state<T0>(arg0).exchange_id == arg1, 13836466319224602635);
        let v0 = 0x2::object::id<Account<T0>>(arg0);
        let v1 = AccountKey{owner: state<T0>(arg0).owner};
        assert!(0x2::object::id_to_address(&v0) == 0x2::derived_object::derive_address<AccountKey>(arg1, v1), 13836466323519569931);
    }

    public fun assert_version<T0>(arg0: &Account<T0>) {
        assert!(arg0.version == 1, 13835058828376276993);
    }

    public(friend) fun cap_id<T0>(arg0: &Account<T0>) : 0x2::object::ID {
        state<T0>(arg0).cap_id
    }

    public fun clear_hedge_if_flat<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: 0x2::object::ID) {
        assert_auth<T0>(arg0, arg1);
        if (side_notional<T0>(arg1, arg2, true) != 0 || side_notional<T0>(arg1, arg2, false) != 0) {
            return
        };
        let v0 = &mut state_mut<T0>(arg1).hedged;
        if (0x2::vec_map::contains<0x2::object::ID, bool>(v0, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(v0, &arg2);
        };
    }

    public fun closed_opposite_same_checkpoint<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u64) : bool {
        let v0 = state<T0>(arg0);
        if (v0.last_close_ts != arg3 || 0x1::option::is_none<0x2::object::ID>(&v0.last_close_market)) {
            return false
        };
        *0x1::option::borrow<0x2::object::ID>(&v0.last_close_market) == arg1 && v0.last_close_long != arg2
    }

    public(friend) fun create<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (Account<T0>, AccountCap) {
        let v0 = AccountKey{owner: arg2};
        assert!(!0x2::derived_object::exists<AccountKey>(arg0, v0), 13835339964050702339);
        let v1 = 1;
        let v2 = Account<T0>{
            id      : 0x2::derived_object::claim<AccountKey>(arg0, v0),
            version : v1,
        };
        let v3 = AccountCap{
            id         : 0x2::object::new(arg3),
            account_id : 0x2::object::id<Account<T0>>(&v2),
        };
        let v4 = AccountStateV1<T0>{
            id                      : 0x2::object::new(arg3),
            owner                   : arg2,
            cap_id                  : 0x2::object::id<AccountCap>(&v3),
            open_notional           : 0,
            positions               : 0x2::table::new<u64, Position>(arg3),
            delegates               : 0x2::vec_map::empty<address, u64>(),
            side_long               : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            side_short              : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            last_close_market       : 0x1::option::none<0x2::object::ID>(),
            last_close_long         : false,
            last_close_ts           : 0,
            exchange_id             : arg1,
            hedged                  : 0x2::vec_map::empty<0x2::object::ID, bool>(),
            pending_orders          : 0,
            pending_close_positions : 0x2::vec_set::empty<u64>(),
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::add<AccountStateV1<T0>>(&mut v2.id, v1, v4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_create_account_event(0x2::object::id<Account<T0>>(&v2), arg2);
        (v2, v3)
    }

    public fun dec_pending_orders<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: PendingPermit) {
        assert_auth_refund<T0>(arg0, arg1);
        let PendingPermit {
            account_id : v0,
            close      : v1,
        } = arg2;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<Account<T0>>(arg1), 13837030218366058511);
        let v3 = state_mut<T0>(arg1);
        v3.pending_orders = v3.pending_orders - 1;
        if (0x1::option::is_some<u64>(&v2)) {
            let v4 = 0x1::option::destroy_some<u64>(v2);
            if (0x2::vec_set::contains<u64>(&v3.pending_close_positions, &v4)) {
                0x2::vec_set::remove<u64>(&mut v3.pending_close_positions, &v4);
            };
        };
    }

    public fun destroy_position(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: Position) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound_any(arg0);
        let Position {
            id                   : _,
            market_id            : _,
            is_long              : _,
            entry_px_wad         : _,
            margin               : _,
            leverage             : _,
            notional             : _,
            bust_px_wad          : _,
            opened_at_ms         : _,
            open_oracle_ts_ms    : _,
            open_oracle_sequence : _,
            winning_exposure     : _,
            factor_bps           : _,
            win_fee_bps          : _,
            deadband_ppm         : _,
            close_fee_ppm        : _,
            open_fee             : _,
            wash                 : _,
            builder_id           : _,
            builder_share_bps    : _,
        } = arg1;
    }

    public(friend) fun grant_delegate<T0>(arg0: &mut Account<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &AccountCap, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_accounts());
        assert_cap<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v0 && arg4 - v0 <= 2592000000, 13835903120162816007);
        let v1 = 0x2::object::id<Account<T0>>(arg0);
        let v2 = &mut state_mut<T0>(arg0).delegates;
        if (0x2::vec_map::contains<address, u64>(v2, &arg3)) {
            *0x2::vec_map::get_mut<address, u64>(v2, &arg3) = arg4;
        } else {
            0x2::vec_map::insert<address, u64>(v2, arg3, arg4);
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_grant_delegate_event(v1, arg3, arg4);
    }

    public fun has_pending_close<T0>(arg0: &Account<T0>, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&state<T0>(arg0).pending_close_positions, &arg1)
    }

    public fun has_position<T0>(arg0: &Account<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, Position>(&state<T0>(arg0).positions, arg1)
    }

    public fun inc_pending_close<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) : PendingPermit {
        add_pending_close<T0>(arg0, arg1, arg2);
        let v0 = inc_pending_orders<T0>(arg0, arg1);
        v0.close = 0x1::option::some<u64>(arg2);
        v0
    }

    public fun inc_pending_orders<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>) : PendingPermit {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.pending_orders = v0.pending_orders + 1;
        PendingPermit{
            account_id : 0x2::object::id<Account<T0>>(arg1),
            close      : 0x1::option::none<u64>(),
        }
    }

    public fun insert_position<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: Position) {
        assert_auth<T0>(arg0, arg1);
        0x2::table::add<u64, Position>(&mut state_mut<T0>(arg1).positions, arg2.id, arg2);
    }

    public fun is_delegate<T0>(arg0: &Account<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, u64>(&state<T0>(arg0).delegates, &arg1)
    }

    public fun is_hedged<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, bool>(&state<T0>(arg0).hedged, &arg1)
    }

    public fun new_position(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: u64, arg2: 0x2::object::ID, arg3: bool, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: 0x1::option::Option<u32>, arg20: u16) : Position {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::assert_bound_any(arg0);
        Position{
            id                   : arg1,
            market_id            : arg2,
            is_long              : arg3,
            entry_px_wad         : arg4,
            margin               : arg5,
            leverage             : arg6,
            notional             : arg7,
            bust_px_wad          : arg8,
            opened_at_ms         : arg9,
            open_oracle_ts_ms    : arg10,
            open_oracle_sequence : arg11,
            winning_exposure     : arg12,
            factor_bps           : arg13,
            win_fee_bps          : arg14,
            deadband_ppm         : arg15,
            close_fee_ppm        : arg16,
            open_fee             : arg17,
            wash                 : arg18,
            builder_id           : arg19,
            builder_share_bps    : arg20,
        }
    }

    public fun note_close<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state_mut<T0>(arg1);
        v0.last_close_market = 0x1::option::some<0x2::object::ID>(arg2);
        v0.last_close_long = arg3;
        v0.last_close_ts = arg4;
    }

    public fun note_hedge_if_two_sided<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: 0x2::object::ID) {
        assert_auth<T0>(arg0, arg1);
        if (side_notional<T0>(arg1, arg2, true) == 0 || side_notional<T0>(arg1, arg2, false) == 0) {
            return
        };
        let v0 = &mut state_mut<T0>(arg1).hedged;
        if (!0x2::vec_map::contains<0x2::object::ID, bool>(v0, &arg2)) {
            0x2::vec_map::insert<0x2::object::ID, bool>(v0, arg2, true);
        };
    }

    public fun open_notional<T0>(arg0: &Account<T0>) : u64 {
        state<T0>(arg0).open_notional
    }

    public fun opposite_open<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID, arg2: bool) : bool {
        let v0 = if (arg2) {
            &state<T0>(arg0).side_short
        } else {
            &state<T0>(arg0).side_long
        };
        0x2::vec_map::contains<0x2::object::ID, u64>(v0, &arg1) && *0x2::vec_map::get<0x2::object::ID, u64>(v0, &arg1) > 0
    }

    public fun owner<T0>(arg0: &Account<T0>) : address {
        state<T0>(arg0).owner
    }

    public fun pending_close_count<T0>(arg0: &Account<T0>) : u64 {
        0x2::vec_set::length<u64>(&state<T0>(arg0).pending_close_positions)
    }

    public fun pending_orders<T0>(arg0: &Account<T0>) : u64 {
        state<T0>(arg0).pending_orders
    }

    public fun position_builder_id(arg0: &Position) : 0x1::option::Option<u32> {
        arg0.builder_id
    }

    public fun position_builder_share(arg0: &Position) : u16 {
        arg0.builder_share_bps
    }

    public fun position_bust(arg0: &Position) : u128 {
        arg0.bust_px_wad
    }

    public fun position_close_fee_ppm(arg0: &Position) : u64 {
        arg0.close_fee_ppm
    }

    public fun position_deadband_ppm(arg0: &Position) : u64 {
        arg0.deadband_ppm
    }

    public fun position_entry(arg0: &Position) : u128 {
        arg0.entry_px_wad
    }

    public fun position_exposure(arg0: &Position) : u64 {
        arg0.winning_exposure
    }

    public fun position_id(arg0: &Position) : u64 {
        arg0.id
    }

    public fun position_is_long(arg0: &Position) : bool {
        arg0.is_long
    }

    public fun position_leverage(arg0: &Position) : u64 {
        arg0.leverage
    }

    public fun position_margin(arg0: &Position) : u64 {
        arg0.margin
    }

    public fun position_market(arg0: &Position) : 0x2::object::ID {
        arg0.market_id
    }

    public fun position_notional(arg0: &Position) : u64 {
        arg0.notional
    }

    public fun position_open_fee(arg0: &Position) : u64 {
        arg0.open_fee
    }

    public fun position_opened_at(arg0: &Position) : u64 {
        arg0.opened_at_ms
    }

    public fun position_oracle_sequence(arg0: &Position) : u64 {
        arg0.open_oracle_sequence
    }

    public fun position_oracle_ts(arg0: &Position) : u64 {
        arg0.open_oracle_ts_ms
    }

    public fun position_summary<T0>(arg0: &Account<T0>, arg1: u64) : (0x2::object::ID, bool, u64) {
        let v0 = 0x2::table::borrow<u64, Position>(&state<T0>(arg0).positions, arg1);
        (v0.market_id, v0.is_long, v0.opened_at_ms)
    }

    public fun position_wash(arg0: &Position) : bool {
        arg0.wash
    }

    public fun position_win_fee_bps(arg0: &Position) : u64 {
        arg0.win_fee_bps
    }

    public(friend) fun remove_pending_close<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = &mut state_mut<T0>(arg1).pending_close_positions;
        if (0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::remove<u64>(v0, &arg2);
        };
    }

    public fun remove_position<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) : Position {
        assert_auth<T0>(arg0, arg1);
        assert!(0x2::table::contains<u64, Position>(&state<T0>(arg1).positions, arg2), 13836185046111223817);
        0x2::table::remove<u64, Position>(&mut state_mut<T0>(arg1).positions, arg2)
    }

    public(friend) fun revoke_delegate<T0>(arg0: &mut Account<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &AccountCap, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        assert_cap<T0>(arg0, arg2);
        let v0 = 0x2::object::id<Account<T0>>(arg0);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut state_mut<T0>(arg0).delegates, &arg3);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_revoke_delegate_event(v0, arg3);
    }

    fun side_notional<T0>(arg0: &Account<T0>, arg1: 0x2::object::ID, arg2: bool) : u64 {
        let v0 = if (arg2) {
            &state<T0>(arg0).side_long
        } else {
            &state<T0>(arg0).side_short
        };
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(v0, &arg1)) {
            0
        } else {
            *0x2::vec_map::get<0x2::object::ID, u64>(v0, &arg1)
        }
    }

    fun state<T0>(arg0: &Account<T0>) : &AccountStateV1<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow<AccountStateV1<T0>>(&arg0.id, arg0.version)
    }

    fun state_mut<T0>(arg0: &mut Account<T0>) : &mut AccountStateV1<T0> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::extended_field::borrow_mut<AccountStateV1<T0>>(&mut arg0.id, arg0.version)
    }

    public fun sub_open_notional<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = state<T0>(arg1).open_notional - arg2;
        state_mut<T0>(arg1).open_notional = v0;
    }

    public fun sub_side<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut Account<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: u64) {
        assert_auth<T0>(arg0, arg1);
        let v0 = if (arg3) {
            &mut state_mut<T0>(arg1).side_long
        } else {
            &mut state_mut<T0>(arg1).side_short
        };
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(v0, &arg2);
        *v1 = *v1 - arg4;
    }

    // decompiled from Move bytecode v7
}

