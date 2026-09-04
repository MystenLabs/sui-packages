module 0xa48222e734396d8165b30ef1aa764cc5dd3949d230d1527c5b17a41c2613dc08::sale {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct Position has store {
        contributed_usdc: u64,
        purchased_dslvr: u64,
        claimed_dslvr: u64,
    }

    struct Sale<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury: address,
        starts_at_ms: u64,
        ends_at_ms: u64,
        launch_at_ms: u64,
        paused: bool,
        finalized: bool,
        unsold_withdrawn: bool,
        total_raised_usdc: u64,
        total_sold_dslvr: u64,
        inventory: 0x2::balance::Balance<T0>,
        eligible: 0x2::table::Table<address, bool>,
        positions: 0x2::table::Table<address, Position>,
    }

    struct SaleCreated has copy, drop {
        sale: 0x2::object::ID,
        treasury: address,
        starts_at_ms: u64,
        ends_at_ms: u64,
    }

    struct EligibilityChanged has copy, drop {
        sale: 0x2::object::ID,
        account: address,
        eligible: bool,
    }

    struct Purchased has copy, drop {
        sale: 0x2::object::ID,
        buyer: address,
        paid_usdc: u64,
        purchased_dslvr: u64,
    }

    struct Finalized has copy, drop {
        sale: 0x2::object::ID,
        launch_at_ms: u64,
    }

    struct Claimed has copy, drop {
        sale: 0x2::object::ID,
        buyer: address,
        amount_dslvr: u64,
    }

    struct PaymentSent has copy, drop {
        sale: 0x2::object::ID,
        buyer: address,
        treasury: address,
        amount_usdc: u64,
    }

    struct UnsoldSent has copy, drop {
        sale: 0x2::object::ID,
        treasury: address,
        amount_dslvr: u64,
    }

    public fun allocation_tokens() : u64 {
        150000000000
    }

    fun assert_admin<T0, T1>(arg0: &Sale<T0, T1>, arg1: &AdminCap) {
        assert!(arg1.sale_id == 0x2::object::id<Sale<T0, T1>>(arg0), 1);
    }

    public fun claim<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.finalized, 11);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.launch_at_ms, 19);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 14);
        let v1 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        let v2 = vested_amount(v1.purchased_dslvr, arg0.launch_at_ms, 0x2::clock::timestamp_ms(arg1));
        assert!(v2 > v1.claimed_dslvr, 15);
        let v3 = v2 - v1.claimed_dslvr;
        v1.claimed_dslvr = v2;
        let v4 = Claimed{
            sale         : 0x2::object::id<Sale<T0, T1>>(arg0),
            buyer        : v0,
            amount_dslvr : v3,
        };
        0x2::event::emit<Claimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.inventory, v3), arg2)
    }

    public fun create<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) == 150000000000, 2);
        assert!(arg1 != @0x0 && arg2 != @0x0, 1);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg5) && arg4 > arg3, 3);
        let v0 = Sale<T0, T1>{
            id                : 0x2::object::new(arg6),
            treasury          : arg1,
            starts_at_ms      : arg3,
            ends_at_ms        : arg4,
            launch_at_ms      : 0,
            paused            : true,
            finalized         : false,
            unsold_withdrawn  : false,
            total_raised_usdc : 0,
            total_sold_dslvr  : 0,
            inventory         : 0x2::coin::into_balance<T0>(arg0),
            eligible          : 0x2::table::new<address, bool>(arg6),
            positions         : 0x2::table::new<address, Position>(arg6),
        };
        let v1 = 0x2::object::id<Sale<T0, T1>>(&v0);
        let v2 = AdminCap{
            id      : 0x2::object::new(arg6),
            sale_id : v1,
        };
        0x2::transfer::transfer<AdminCap>(v2, arg2);
        0x2::transfer::share_object<Sale<T0, T1>>(v0);
        let v3 = SaleCreated{
            sale         : v1,
            treasury     : arg1,
            starts_at_ms : arg3,
            ends_at_ms   : arg4,
        };
        0x2::event::emit<SaleCreated>(v3);
    }

    public fun finalize<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(!arg0.finalized, 10);
        assert!(0x2::clock::timestamp_ms(arg3) > arg0.ends_at_ms || arg0.total_sold_dslvr == 150000000000, 4);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg3), 3);
        arg0.finalized = true;
        arg0.paused = true;
        arg0.launch_at_ms = arg2;
        let v0 = Finalized{
            sale         : 0x2::object::id<Sale<T0, T1>>(arg0),
            launch_at_ms : arg2,
        };
        0x2::event::emit<Finalized>(v0);
    }

    public fun finalized<T0, T1>(arg0: &Sale<T0, T1>) : bool {
        arg0.finalized
    }

    public fun maximum_usdc_per_wallet() : u64 {
        3000000000
    }

    public fun minimum_usdc() : u64 {
        5000000
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun purchase<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!arg0.paused && !arg0.finalized, 4);
        assert!(v0 >= arg0.starts_at_ms && v0 <= arg0.ends_at_ms, 4);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(v2 >= 5000000, 6);
        assert!(v2 % 2 == 0, 9);
        let v3 = tokens_for_payment(v2);
        assert!(arg0.total_sold_dslvr <= 150000000000 - v3, 8);
        if (0x2::table::contains<address, Position>(&arg0.positions, v1)) {
            let v4 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v1);
            assert!(v4.contributed_usdc <= 3000000000 - v2, 7);
            v4.contributed_usdc = v4.contributed_usdc + v2;
            v4.purchased_dslvr = v4.purchased_dslvr + v3;
        } else {
            assert!(v2 <= 3000000000, 7);
            let v5 = Position{
                contributed_usdc : v2,
                purchased_dslvr  : v3,
                claimed_dslvr    : 0,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v1, v5);
        };
        arg0.total_raised_usdc = arg0.total_raised_usdc + v2;
        arg0.total_sold_dslvr = arg0.total_sold_dslvr + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.treasury);
        let v6 = Purchased{
            sale            : 0x2::object::id<Sale<T0, T1>>(arg0),
            buyer           : v1,
            paid_usdc       : v2,
            purchased_dslvr : v3,
        };
        0x2::event::emit<Purchased>(v6);
        let v7 = PaymentSent{
            sale        : 0x2::object::id<Sale<T0, T1>>(arg0),
            buyer       : v1,
            treasury    : arg0.treasury,
            amount_usdc : v2,
        };
        0x2::event::emit<PaymentSent>(v7);
    }

    public fun send_unsold_to_treasury<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(arg0.finalized, 11);
        assert!(!arg0.unsold_withdrawn, 18);
        let v0 = 150000000000 - arg0.total_sold_dslvr;
        arg0.unsold_withdrawn = true;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.inventory, v0), arg2), arg0.treasury);
        };
        let v1 = UnsoldSent{
            sale         : 0x2::object::id<Sale<T0, T1>>(arg0),
            treasury     : arg0.treasury,
            amount_dslvr : v0,
        };
        0x2::event::emit<UnsoldSent>(v1);
    }

    public fun set_eligible<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: &AdminCap, arg2: address, arg3: bool) {
        assert_admin<T0, T1>(arg0, arg1);
        if (0x2::table::contains<address, bool>(&arg0.eligible, arg2)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.eligible, arg2) = arg3;
        } else {
            0x2::table::add<address, bool>(&mut arg0.eligible, arg2, arg3);
        };
        let v0 = EligibilityChanged{
            sale     : 0x2::object::id<Sale<T0, T1>>(arg0),
            account  : arg2,
            eligible : arg3,
        };
        0x2::event::emit<EligibilityChanged>(v0);
    }

    public fun set_paused<T0, T1>(arg0: &mut Sale<T0, T1>, arg1: &AdminCap, arg2: bool) {
        assert_admin<T0, T1>(arg0, arg1);
        assert!(!arg0.finalized, 10);
        arg0.paused = arg2;
    }

    fun tokens_for_payment(arg0: u64) : u64 {
        mul_div(arg0, 5, 2)
    }

    public fun total_raised<T0, T1>(arg0: &Sale<T0, T1>) : u64 {
        arg0.total_raised_usdc
    }

    public fun total_sold<T0, T1>(arg0: &Sale<T0, T1>) : u64 {
        arg0.total_sold_dslvr
    }

    public fun treasury<T0, T1>(arg0: &Sale<T0, T1>) : address {
        arg0.treasury
    }

    fun vested_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 < arg1) {
            return 0
        };
        let v0 = mul_div(arg0, 2000, 10000);
        let v1 = 0x1::u64::min((arg2 - arg1) / 2592000000, 12);
        if (v1 == 12) {
            return arg0
        };
        v0 + mul_div(arg0 - v0, v1, 12)
    }

    // decompiled from Move bytecode v7
}

