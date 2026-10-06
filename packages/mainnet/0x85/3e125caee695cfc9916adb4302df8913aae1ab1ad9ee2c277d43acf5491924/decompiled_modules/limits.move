module 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_recipient: address,
        paused: bool,
    }

    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<T0>,
        amount_in: u64,
        min_out: u64,
        fee_bps: u64,
        fee_on_input: bool,
        created_ms: u64,
        expiry_ms: u64,
        state: u8,
    }

    struct FillReceipt<phantom T0, phantom T1> {
        order_id: 0x2::object::ID,
        amount_in: u64,
        input_fee: u64,
    }

    struct OrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
        fee_bps: u64,
        fee_on_input: bool,
        expiry_ms: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        filler: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        fee_on_input: bool,
    }

    struct OrderClosed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        refunded: u64,
        expired: bool,
    }

    public fun amount_in<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.amount_in
    }

    public fun begin_fill<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FillReceipt<T0, T1>) {
        assert!(!arg1.paused, 1);
        assert!(arg0.state == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 5);
        arg0.state = 1;
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg3);
        let v2 = if (arg0.fee_on_input) {
            fee_for(v0, arg0.fee_bps)
        } else {
            0
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v2, arg3), arg1.fee_recipient);
        };
        let v3 = FillReceipt<T0, T1>{
            order_id  : 0x2::object::id<Order<T0, T1>>(arg0),
            amount_in : v0,
            input_fee : v2,
        };
        (v1, v3)
    }

    public fun cancel<T0, T1>(arg0: Order<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 7);
        close<T0, T1>(arg0, false, arg1);
    }

    fun close<T0, T1>(arg0: Order<T0, T1>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 8);
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.funds), arg2), v0);
        let v1 = OrderClosed{
            order_id : 0x2::object::id<Order<T0, T1>>(&arg0),
            owner    : v0,
            refunded : 0x2::balance::value<T0>(&arg0.funds),
            expired  : arg1,
        };
        0x2::event::emit<OrderClosed>(v1);
        destroy<T0, T1>(arg0);
    }

    fun destroy<T0, T1>(arg0: Order<T0, T1>) {
        let Order {
            id           : v0,
            owner        : _,
            funds        : v2,
            amount_in    : _,
            min_out      : _,
            fee_bps      : _,
            fee_on_input : _,
            created_ms   : _,
            expiry_ms    : _,
            state        : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun expire_refund<T0, T1>(arg0: Order<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 6);
        close<T0, T1>(arg0, true, arg2);
    }

    public fun expiry_ms<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.expiry_ms
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_for(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun fee_on_input<T0, T1>(arg0: &Order<T0, T1>) : bool {
        arg0.fee_on_input
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun finish_fill<T0, T1>(arg0: FillReceipt<T0, T1>, arg1: Order<T0, T1>, arg2: &Config, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let FillReceipt {
            order_id  : v0,
            amount_in : v1,
            input_fee : v2,
        } = arg0;
        assert!(v0 == 0x2::object::id<Order<T0, T1>>(&arg1), 10);
        assert!(arg1.state == 1, 9);
        let v3 = 0x2::coin::value<T1>(&arg3);
        let v4 = if (arg1.fee_on_input) {
            0
        } else {
            fee_for(v3, arg1.fee_bps)
        };
        assert!(v3 - v4 >= arg1.min_out, 11);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v4, arg4), arg2.fee_recipient);
        };
        let v5 = if (arg1.fee_on_input) {
            v2
        } else {
            v4
        };
        let v6 = OrderFilled{
            order_id     : v0,
            owner        : arg1.owner,
            filler       : 0x2::tx_context::sender(arg4),
            amount_in    : v1,
            amount_out   : v3,
            fee          : v5,
            fee_on_input : arg1.fee_on_input,
        };
        0x2::event::emit<OrderFilled>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, arg1.owner);
        destroy<T0, T1>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            fee_bps       : 0,
            fee_recipient : 0x2::tx_context::sender(arg0),
            paused        : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_open<T0, T1>(arg0: &Order<T0, T1>) : bool {
        arg0.state == 0
    }

    public fun min_out<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.min_out
    }

    public fun order_fee_bps<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun owner<T0, T1>(arg0: &Order<T0, T1>) : address {
        arg0.owner
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun place<T0, T1>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        assert!(arg2 > 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v1 && arg4 - v1 <= 7776000000, 4);
        let v2 = Order<T0, T1>{
            id           : 0x2::object::new(arg6),
            owner        : 0x2::tx_context::sender(arg6),
            funds        : 0x2::coin::into_balance<T0>(arg1),
            amount_in    : v0,
            min_out      : arg2,
            fee_bps      : arg0.fee_bps,
            fee_on_input : arg3,
            created_ms   : v1,
            expiry_ms    : arg4,
            state        : 0,
        };
        let v3 = 0x2::object::id<Order<T0, T1>>(&v2);
        let v4 = OrderPlaced{
            order_id     : v3,
            owner        : v2.owner,
            coin_in      : 0x1::type_name::with_defining_ids<T0>(),
            coin_out     : 0x1::type_name::with_defining_ids<T1>(),
            amount_in    : v0,
            min_out      : arg2,
            fee_bps      : v2.fee_bps,
            fee_on_input : arg3,
            expiry_ms    : arg4,
        };
        0x2::event::emit<OrderPlaced>(v4);
        0x2::transfer::share_object<Order<T0, T1>>(v2);
        v3
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100, 12);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

