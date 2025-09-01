module 0xa7cdfbd2f154b0b3c2e0367ca21cf8a34d32cdc29e77560ecce951522fb4e40a::pool {
    struct Pool has store, key {
        id: 0x2::object::UID,
        balanceA: u64,
        balanceB: u64,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pos has key {
        id: 0x2::object::UID,
        amountA: u64,
        amountB: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id       : 0x2::object::new(arg0),
            balanceA : 0,
            balanceB : 0,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun add_liquidity(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Pos {
        arg0.balanceA = arg0.balanceA + arg1;
        arg0.balanceB = arg0.balanceB + arg2;
        Pos{
            id      : 0x2::object::new(arg3),
            amountA : arg1,
            amountB : arg2,
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

