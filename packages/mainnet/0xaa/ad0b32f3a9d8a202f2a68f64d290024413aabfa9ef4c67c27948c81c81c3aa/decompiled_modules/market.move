module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        category: 0x1::string::String,
        close_ts_ms: u64,
        state: u8,
        winning_outcome: u8,
        collateral: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        creator: address,
        close_ts_ms: u64,
    }

    public fun assert_closed<T0>(arg0: &Market<T0>) {
        assert!(arg0.state == 1, 3);
    }

    public fun assert_open<T0>(arg0: &Market<T0>) {
        assert!(arg0.state == 0, 0);
    }

    public fun assert_resolved<T0>(arg0: &Market<T0>) {
        assert!(arg0.state == 2, 1);
    }

    public fun close<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.close_ts_ms, 2);
        arg0.state = 1;
    }

    public fun close_ts_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.close_ts_ms
    }

    public fun collateral_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun create<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = MarketCreated{
            market_id   : 0x2::object::uid_to_inner(&v0),
            creator     : v1,
            close_ts_ms : arg2,
        };
        0x2::event::emit<MarketCreated>(v2);
        Market<T0>{
            id              : v0,
            question        : arg0,
            category        : arg1,
            close_ts_ms     : arg2,
            state           : 0,
            winning_outcome : 255,
            collateral      : 0x2::balance::zero<T0>(),
            creator         : v1,
        }
    }

    public fun create_and_share<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Market<T0>>(create<T0>(arg0, arg1, arg2, arg3));
    }

    public fun creator<T0>(arg0: &Market<T0>) : address {
        arg0.creator
    }

    public(friend) fun deposit_collateral<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collateral, arg1);
    }

    public fun is_closed<T0>(arg0: &Market<T0>) : bool {
        arg0.state == 1
    }

    public fun is_invalid<T0>(arg0: &Market<T0>) : bool {
        arg0.state == 3
    }

    public fun is_open<T0>(arg0: &Market<T0>) : bool {
        arg0.state == 0
    }

    public fun is_resolved<T0>(arg0: &Market<T0>) : bool {
        arg0.state == 2
    }

    public fun outcome_unset() : u8 {
        255
    }

    public(friend) fun set_invalid<T0>(arg0: &mut Market<T0>) {
        arg0.state = 3;
        arg0.winning_outcome = 255;
    }

    public(friend) fun set_resolved<T0>(arg0: &mut Market<T0>, arg1: u8) {
        arg0.state = 2;
        arg0.winning_outcome = arg1;
    }

    public fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public fun state<T0>(arg0: &Market<T0>) : u8 {
        arg0.state
    }

    public fun state_closed() : u8 {
        1
    }

    public fun state_invalid() : u8 {
        3
    }

    public fun state_open() : u8 {
        0
    }

    public fun state_resolved() : u8 {
        2
    }

    public fun winning_outcome<T0>(arg0: &Market<T0>) : u8 {
        arg0.winning_outcome
    }

    public(friend) fun withdraw_collateral<T0>(arg0: &mut Market<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collateral, arg1)
    }

    // decompiled from Move bytecode v7
}

