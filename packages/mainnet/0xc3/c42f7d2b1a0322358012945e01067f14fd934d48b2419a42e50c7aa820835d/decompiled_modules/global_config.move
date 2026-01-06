module 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::global_config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        fee_recipient: address,
        lock_fee: u64,
        claim_fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_claim_fee(arg0: &GlobalConfig) : u64 {
        arg0.claim_fee
    }

    public fun get_fee_recipient(arg0: &GlobalConfig) : address {
        arg0.fee_recipient
    }

    public fun get_lock_fee(arg0: &GlobalConfig) : u64 {
        arg0.lock_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalConfig{
            id            : 0x2::object::new(arg0),
            fee_recipient : v0,
            lock_fee      : 100000000,
            claim_fee     : 100000000,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun update_claim_fee(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.claim_fee = arg2;
    }

    public fun update_fee_recipient(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun update_lock_fee(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.lock_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

