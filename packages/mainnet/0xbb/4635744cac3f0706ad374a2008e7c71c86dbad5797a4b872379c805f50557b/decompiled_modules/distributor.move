module 0xbb4635744cac3f0706ad374a2008e7c71c86dbad5797a4b872379c805f50557b::distributor {
    struct RetardCap has store, key {
        id: 0x2::object::UID,
    }

    struct RetardInfo has copy, drop, store {
        claimable: u64,
        has_claimed: bool,
    }

    struct CertifiedRetards has key {
        id: 0x2::object::UID,
        retards: 0x2::table::Table<address, RetardInfo>,
        distribution_balance: 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>,
    }

    public fun add_whitelisted_address(arg0: &RetardCap, arg1: &mut CertifiedRetards, arg2: address, arg3: u64) {
        let v0 = RetardInfo{
            claimable   : arg3,
            has_claimed : false,
        };
        0x2::table::add<address, RetardInfo>(&mut arg1.retards, arg2, v0);
    }

    public fun claim(arg0: &mut CertifiedRetards, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD> {
        assert!(is_retarded(arg0, 0x2::tx_context::sender(arg1)), 0);
        assert!(!has_claimed(arg0, 0x2::tx_context::sender(arg1)), 1);
        0x2::table::borrow_mut<address, RetardInfo>(&mut arg0.retards, 0x2::tx_context::sender(arg1)).has_claimed = true;
        0x2::balance::split<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg0.distribution_balance, distribution_amount(arg0, 0x2::tx_context::sender(arg1)))
    }

    public fun distribution_amount(arg0: &CertifiedRetards, arg1: address) : u64 {
        0x2::table::borrow<address, RetardInfo>(&arg0.retards, arg1).claimable
    }

    public fun has_claimed(arg0: &CertifiedRetards, arg1: address) : bool {
        0x2::table::borrow<address, RetardInfo>(&arg0.retards, arg1).has_claimed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CertifiedRetards{
            id                   : 0x2::object::new(arg0),
            retards              : 0x2::table::new<address, RetardInfo>(arg0),
            distribution_balance : 0x2::balance::zero<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(),
        };
        0x2::transfer::share_object<CertifiedRetards>(v0);
        let v1 = RetardCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RetardCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_retarded(arg0: &CertifiedRetards, arg1: address) : bool {
        0x2::table::contains<address, RetardInfo>(&arg0.retards, arg1)
    }

    public fun remove_whitelisted_address(arg0: &RetardCap, arg1: &mut CertifiedRetards, arg2: address) {
        0x2::table::remove<address, RetardInfo>(&mut arg1.retards, arg2);
    }

    public fun topup(arg0: &RetardCap, arg1: &mut CertifiedRetards, arg2: 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>) {
        0x2::balance::join<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg1.distribution_balance, arg2);
    }

    public fun withdraw(arg0: &RetardCap, arg1: &mut CertifiedRetards, arg2: u64) : 0x2::balance::Balance<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD> {
        0x2::balance::split<0x2cddfc6d4fc855917e990e71cd122b1ee8098aa890186ee15a84524ed17cd8c9::suitard::SUITARD>(&mut arg1.distribution_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

