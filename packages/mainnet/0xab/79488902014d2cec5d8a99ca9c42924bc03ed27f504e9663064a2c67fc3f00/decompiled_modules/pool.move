module 0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        balance: 0x2::balance::Balance<T0>,
        admin_deposited: u64,
        swap_proceeds: u64,
        limits: Limits,
        operators: 0x2::table::Table<address, OperatorState>,
        pausers: 0x2::vec_set::VecSet<address>,
        withdraw_targets: 0x2::vec_set::VecSet<address>,
        forwarded: 0x2::table::Table<vector<u8>, bool>,
        deposited: 0x2::table::Table<vector<u8>, bool>,
        withdrawn: 0x2::table::Table<vector<u8>, bool>,
        window_start_ms: u64,
        forwarded_in_window: u64,
        withdrawn_in_window: u64,
    }

    struct Limits has copy, drop, store {
        max_forward: u64,
        max_refund: u64,
        max_withdraw: u64,
        min_move: u64,
        window_ms: u64,
        max_forwarded_per_window: u64,
        max_withdrawn_per_window: u64,
    }

    struct OperatorState has copy, drop, store {
        max_forward: u64,
        max_forwarded_per_window: u64,
        window_start_ms: u64,
        forwarded_in_window: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminOffer has key {
        id: 0x2::object::UID,
        from: address,
        to: address,
    }

    struct ForwardReceipt {
        pool_id: 0x2::object::ID,
        intent_id: vector<u8>,
        operator: address,
        out_type: 0x1::type_name::TypeName,
        min_out: u64,
        recipient: address,
        usdc_in: u64,
    }

    public fun balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun accept_admin(arg0: AdminOffer, arg1: 0x2::transfer::Receiving<AdminCap>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.to, 19);
        let (v1, v2) = take_offered_cap(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::admin_accepted(v0, v2);
    }

    public fun admin_deposited<T0>(arg0: &Pool<T0>) : u64 {
        arg0.admin_deposited
    }

    public fun admin_receive_asset<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        assert_version<T0>(arg1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg1.id, arg2);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        arg1.admin_deposited = arg1.admin_deposited + v1;
        0x2::coin::put<T0>(&mut arg1.balance, v0);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::deposited(0x2::object::uid_to_address(&arg1.id), v1);
    }

    public fun admin_rescue<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>, arg3: address) {
        assert_version<T0>(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != 0x1::type_name::with_defining_ids<T0>(), 10);
        assert!(arg3 != @0x0 && arg3 != 0x2::object::uid_to_address(&arg1.id), 9);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg1.id, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg3);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::asset_rescued(v0, arg3, 0x2::coin::value<T1>(&v1));
    }

    public fun admin_rescue_object<T0, T1: store + key>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: 0x2::transfer::Receiving<T1>, arg3: address) {
        assert_version<T0>(arg1);
        assert!(arg3 != @0x0 && arg3 != 0x2::object::uid_to_address(&arg1.id), 9);
        let v0 = 0x2::transfer::public_receive<T1>(&mut arg1.id, arg2);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::object_rescued(0x1::type_name::with_defining_ids<T1>(), 0x2::object::id<T1>(&v0), arg3);
        0x2::transfer::public_transfer<T1>(v0, arg3);
    }

    public fun admin_withdraw<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert!(arg2 > 0, 6);
        assert!(arg3 != @0x0 && arg3 != 0x2::object::uid_to_address(&arg1.id), 9);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 8);
        pay_out<T0>(arg1, arg2, arg3, arg4);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::withdrawn(0x1::option::none<vector<u8>>(), 0x2::tx_context::sender(arg4), arg3, arg2, 2);
    }

    fun assert_intent_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 16, 4);
    }

    fun assert_recipient<T0>(arg0: &Pool<T0>, arg1: address) {
        assert!(arg1 != @0x0 && arg1 != 0x2::object::uid_to_address(&arg0.id), 9);
        assert!(!0x2::table::contains<address, OperatorState>(&arg0.operators, arg1), 9);
    }

    fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 0);
    }

    fun bump_forwarded<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64, arg3: u64) {
        roll_window<T0>(arg0, arg3);
        assert!(fits(arg0.forwarded_in_window, arg2, arg0.limits.max_forwarded_per_window), 7);
        arg0.forwarded_in_window = arg0.forwarded_in_window + arg2;
        bump_operator_window<T0>(arg0, arg1, arg2, arg3);
    }

    fun bump_operator_window<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, OperatorState>(&mut arg0.operators, arg1);
        if (window_elapsed(v0.window_start_ms, arg3, arg0.limits.window_ms)) {
            v0.window_start_ms = arg3;
            v0.forwarded_in_window = 0;
        };
        assert!(fits(v0.forwarded_in_window, arg2, v0.max_forwarded_per_window), 7);
        v0.forwarded_in_window = v0.forwarded_in_window + arg2;
    }

    fun bump_withdrawn<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) {
        roll_window<T0>(arg0, arg2);
        assert!(fits(arg0.withdrawn_in_window, arg1, arg0.limits.max_withdrawn_per_window), 7);
        arg0.withdrawn_in_window = arg0.withdrawn_in_window + arg1;
    }

    public fun cancel_admin_offer(arg0: AdminOffer, arg1: 0x2::transfer::Receiving<AdminCap>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.from, 20);
        let (v1, v2) = take_offered_cap(arg0, arg1);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::admin_offer_cancelled(v0, v2);
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                  : 0x2::object::new(arg8),
            version             : 1,
            paused              : false,
            balance             : 0x2::balance::zero<T0>(),
            admin_deposited     : 0,
            swap_proceeds       : 0,
            limits              : new_limits(arg1, arg2, arg3, arg4, arg5, arg6, arg7),
            operators           : 0x2::table::new<address, OperatorState>(arg8),
            pausers             : 0x2::vec_set::empty<address>(),
            withdraw_targets    : 0x2::vec_set::empty<address>(),
            forwarded           : 0x2::table::new<vector<u8>, bool>(arg8),
            deposited           : 0x2::table::new<vector<u8>, bool>(arg8),
            withdrawn           : 0x2::table::new<vector<u8>, bool>(arg8),
            window_start_ms     : 0,
            forwarded_in_window : 0,
            withdrawn_in_window : 0,
        };
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::pool_created(0x2::object::id<Pool<T0>>(&v0), 0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg8));
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        arg0.admin_deposited = arg0.admin_deposited + v0;
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::deposited(0x2::tx_context::sender(arg2), v0);
    }

    public fun deposit_for_intent<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 1);
        assert_intent_id(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.deposited, arg1), 5);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 11);
        assert!(arg3 >= arg0.limits.min_move, 6);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0 && v0 >= arg3, 12);
        0x2::table::add<vector<u8>, bool>(&mut arg0.deposited, arg1, true);
        arg0.swap_proceeds = arg0.swap_proceeds + v0;
        0x2::coin::put<T0>(&mut arg0.balance, arg2);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::swap_deposited(arg1, 0x2::tx_context::sender(arg6), v0);
    }

    fun fits(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) + (arg1 as u128) <= (arg2 as u128)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_deposited<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.deposited, arg1)
    }

    public fun is_forwarded<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.forwarded, arg1)
    }

    public fun is_operator<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x2::table::contains<address, OperatorState>(&arg0.operators, arg1)
    }

    public fun is_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.paused
    }

    public fun is_pauser<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.pausers, &arg1)
    }

    public fun is_withdraw_target<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.withdraw_targets, &arg1)
    }

    public fun is_withdrawn<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.withdrawn, arg1)
    }

    public fun limits<T0>(arg0: &Pool<T0>) : Limits {
        arg0.limits
    }

    public fun max_forward(arg0: &Limits) : u64 {
        arg0.max_forward
    }

    public fun max_forwarded_per_window(arg0: &Limits) : u64 {
        arg0.max_forwarded_per_window
    }

    public fun max_refund(arg0: &Limits) : u64 {
        arg0.max_refund
    }

    public fun max_window_ms() : u64 {
        604800000
    }

    public fun max_withdraw(arg0: &Limits) : u64 {
        arg0.max_withdraw
    }

    public fun max_withdrawn_per_window(arg0: &Limits) : u64 {
        arg0.max_withdrawn_per_window
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>) {
        assert!(arg1.version < 1, 18);
        arg1.version = 1;
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::migrated(arg1.version, 1);
    }

    public fun min_move(arg0: &Limits) : u64 {
        arg0.min_move
    }

    fun new_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Limits {
        assert!(arg3 > 0, 17);
        assert!(arg4 > 0 && arg4 <= 604800000, 17);
        Limits{
            max_forward              : arg0,
            max_refund               : arg1,
            max_withdraw             : arg2,
            min_move                 : arg3,
            window_ms                : arg4,
            max_forwarded_per_window : arg5,
            max_withdrawn_per_window : arg6,
        }
    }

    public fun offer(arg0: &AdminOffer) : (address, address) {
        (arg0.from, arg0.to)
    }

    public fun offer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 != @0x0 && arg1 != v0, 9);
        let v1 = AdminOffer{
            id   : 0x2::object::new(arg2),
            from : v0,
            to   : arg1,
        };
        let v2 = 0x2::object::id<AdminOffer>(&v1);
        0x2::transfer::transfer<AdminCap>(arg0, 0x2::object::id_to_address(&v2));
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::admin_offered(v0, arg1, v2);
        0x2::transfer::share_object<AdminOffer>(v1);
    }

    public fun op_forwarded_in_window(arg0: &OperatorState) : u64 {
        arg0.forwarded_in_window
    }

    public fun op_max_forward(arg0: &OperatorState) : u64 {
        arg0.max_forward
    }

    public fun op_max_forwarded_per_window(arg0: &OperatorState) : u64 {
        arg0.max_forwarded_per_window
    }

    public fun op_window_start_ms(arg0: &OperatorState) : u64 {
        arg0.window_start_ms
    }

    public fun operator_state<T0>(arg0: &Pool<T0>, arg1: address) : OperatorState {
        assert!(0x2::table::contains<address, OperatorState>(&arg0.operators, arg1), 2);
        *0x2::table::borrow<address, OperatorState>(&arg0.operators, arg1)
    }

    public fun pause<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, OperatorState>(&arg0.operators, v0) || 0x2::vec_set::contains<address>(&arg0.pausers, &v0), 3);
        arg0.paused = true;
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::paused(v0);
    }

    fun pay_out<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        spend_working_capital<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg3), arg2);
    }

    public fun rebalance_withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, OperatorState>(&arg0.operators, v0), 2);
        assert!(!arg0.paused, 1);
        assert!(0x2::vec_set::contains<address>(&arg0.withdraw_targets, &arg2), 16);
        assert!(arg1 >= arg0.limits.min_move && arg1 <= arg0.limits.max_withdraw, 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        bump_withdrawn<T0>(arg0, arg1, v1);
        bump_operator_window<T0>(arg0, v0, arg1, v1);
        pay_out<T0>(arg0, arg1, arg2, arg4);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::withdrawn(0x1::option::none<vector<u8>>(), v0, arg2, arg1, 1);
    }

    public fun refund_withdraw<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, OperatorState>(&arg0.operators, v0), 2);
        assert!(!arg0.paused, 1);
        assert_intent_id(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.withdrawn, arg1), 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.forwarded, arg1), 5);
        assert_recipient<T0>(arg0, arg3);
        assert!(arg2 >= arg0.limits.min_move && arg2 <= arg0.limits.max_refund, 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 8);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        bump_withdrawn<T0>(arg0, arg2, v1);
        bump_operator_window<T0>(arg0, v0, arg2, v1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.withdrawn, arg1, true);
        pay_out<T0>(arg0, arg2, arg3, arg5);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::withdrawn(0x1::option::some<vector<u8>>(arg1), v0, arg3, arg2, 0);
    }

    public fun remove_operator<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address) {
        assert_version<T0>(arg1);
        assert!(0x2::table::contains<address, OperatorState>(&arg1.operators, arg2), 2);
        0x2::table::remove<address, OperatorState>(&mut arg1.operators, arg2);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::operator_removed(arg2);
    }

    public fun return_change<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        arg0.swap_proceeds = arg0.swap_proceeds + v0;
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::change_returned(v0, 0x2::tx_context::sender(arg2));
    }

    fun roll_window<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        if (window_elapsed(arg0.window_start_ms, arg1, arg0.limits.window_ms)) {
            arg0.window_start_ms = arg1;
            arg0.forwarded_in_window = 0;
            arg0.withdrawn_in_window = 0;
        };
    }

    public fun set_limits<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert_version<T0>(arg1);
        arg1.limits = new_limits(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::limits_set(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun set_member(arg0: &mut 0x2::vec_set::VecSet<address>, arg1: address, arg2: bool) {
        if (arg2) {
            if (!0x2::vec_set::contains<address>(arg0, &arg1)) {
                0x2::vec_set::insert<address>(arg0, arg1);
            };
        } else if (0x2::vec_set::contains<address>(arg0, &arg1)) {
            0x2::vec_set::remove<address>(arg0, &arg1);
        };
    }

    public fun set_operator<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address, arg3: u64, arg4: u64) {
        assert_version<T0>(arg1);
        assert!(arg2 != @0x0 && arg2 != 0x2::object::uid_to_address(&arg1.id), 9);
        assert!(!0x2::vec_set::contains<address>(&arg1.withdraw_targets, &arg2), 15);
        assert!(arg3 <= arg1.limits.max_forward && (arg4 as u128) <= (arg1.limits.max_forwarded_per_window as u128) + (arg1.limits.max_withdrawn_per_window as u128), 17);
        if (0x2::table::contains<address, OperatorState>(&arg1.operators, arg2)) {
            let v0 = 0x2::table::borrow_mut<address, OperatorState>(&mut arg1.operators, arg2);
            v0.max_forward = arg3;
            v0.max_forwarded_per_window = arg4;
        } else {
            let v1 = OperatorState{
                max_forward              : arg3,
                max_forwarded_per_window : arg4,
                window_start_ms          : 0,
                forwarded_in_window      : 0,
            };
            0x2::table::add<address, OperatorState>(&mut arg1.operators, arg2, v1);
        };
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::operator_set(arg2, arg3, arg4);
    }

    public fun set_pauser<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address, arg3: bool) {
        assert_version<T0>(arg1);
        assert!(arg2 != @0x0, 9);
        let v0 = &mut arg1.pausers;
        set_member(v0, arg2, arg3);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::pauser_set(arg2, arg3);
    }

    public fun set_withdraw_target<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address, arg3: bool) {
        assert_version<T0>(arg1);
        assert!(arg2 != @0x0 && arg2 != 0x2::object::uid_to_address(&arg1.id), 9);
        if (arg3) {
            assert!(!0x2::table::contains<address, OperatorState>(&arg1.operators, arg2), 15);
        };
        let v0 = &mut arg1.withdraw_targets;
        set_member(v0, arg2, arg3);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::withdraw_target_set(arg2, arg3);
    }

    public fun settle<T0, T1>(arg0: &Pool<T0>, arg1: ForwardReceipt, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let ForwardReceipt {
            pool_id   : v0,
            intent_id : v1,
            operator  : v2,
            out_type  : v3,
            min_out   : v4,
            recipient : v5,
            usdc_in   : v6,
        } = arg1;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg0), 13);
        assert!(v3 == 0x1::type_name::with_defining_ids<T1>(), 14);
        assert!(v2 == 0x2::tx_context::sender(arg3), 2);
        let v7 = 0x2::coin::value<T1>(&arg2);
        assert!(v7 > 0 && v7 >= v4, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v5);
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::swap_forwarded(v1, v2, v5, v6, v3, v7);
    }

    fun spend_working_capital<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        let v0 = 0x1::u64::min(arg1, arg0.swap_proceeds);
        arg0.swap_proceeds = arg0.swap_proceeds - v0;
        let v1 = arg1 - v0;
        let v2 = if (v1 >= arg0.admin_deposited) {
            0
        } else {
            arg0.admin_deposited - v1
        };
        arg0.admin_deposited = v2;
    }

    public fun swap_proceeds<T0>(arg0: &Pool<T0>) : u64 {
        arg0.swap_proceeds
    }

    fun take_offered_cap(arg0: AdminOffer, arg1: 0x2::transfer::Receiving<AdminCap>) : (AdminCap, 0x2::object::ID) {
        let AdminOffer {
            id   : v0,
            from : _,
            to   : _,
        } = arg0;
        let v3 = v0;
        0x2::object::delete(v3);
        (0x2::transfer::receive<AdminCap>(&mut v3, arg1), 0x2::object::uid_to_inner(&v3))
    }

    public fun unpause<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>) {
        assert_version<T0>(arg1);
        arg1.paused = false;
        0xab79488902014d2cec5d8a99ca9c42924bc03ed27f504e9663064a2c67fc3f00::events::unpaused();
    }

    public fun version<T0>(arg0: &Pool<T0>) : u64 {
        arg0.version
    }

    public fun window<T0>(arg0: &Pool<T0>) : (u64, u64, u64) {
        (arg0.window_start_ms, arg0.forwarded_in_window, arg0.withdrawn_in_window)
    }

    fun window_elapsed(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0 && arg1 - arg0 >= arg2
    }

    public fun window_ms(arg0: &Limits) : u64 {
        arg0.window_ms
    }

    public fun withdraw_for_intent<T0, T1>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ForwardReceipt) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = operator_state<T0>(arg0, v0);
        assert!(!arg0.paused, 1);
        assert_intent_id(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.forwarded, arg1), 5);
        assert_recipient<T0>(arg0, arg4);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v2 != 0x1::type_name::with_defining_ids<T0>(), 10);
        let v3 = 0x2::clock::timestamp_ms(arg6);
        assert!(v3 <= arg5, 11);
        assert!(arg2 >= arg0.limits.min_move, 6);
        assert!(arg2 <= 0x1::u64::min(arg0.limits.max_forward, v1.max_forward), 6);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 8);
        bump_forwarded<T0>(arg0, v0, arg2, v3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.forwarded, arg1, true);
        spend_working_capital<T0>(arg0, arg2);
        let v4 = ForwardReceipt{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            intent_id : arg1,
            operator  : v0,
            out_type  : v2,
            min_out   : arg3,
            recipient : arg4,
            usdc_in   : arg2,
        };
        (0x2::coin::take<T0>(&mut arg0.balance, arg2, arg7), v4)
    }

    // decompiled from Move bytecode v7
}

