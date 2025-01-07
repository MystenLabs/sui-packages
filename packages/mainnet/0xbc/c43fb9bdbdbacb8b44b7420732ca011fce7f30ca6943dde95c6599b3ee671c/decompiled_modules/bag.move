module 0xec4e3ce39b3e49cfc763b4b19df01409441600aae1c7a38c2a6d06cc0b6471b3::bag {
    struct BalanceBag has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelisted_addresses: vector<address>,
    }

    struct BagOwnerCap has key {
        id: 0x2::object::UID,
    }

    public fun add_fund(arg0: &mut BalanceBag, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun add_whitelist(arg0: &BagOwnerCap, arg1: &mut BalanceBag, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    public fun get_fund(arg0: &mut BalanceBag, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceBag{
            id                    : 0x2::object::new(arg0),
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            whitelisted_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<BalanceBag>(v0);
        let v1 = BagOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BagOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &BalanceBag, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    entry fun test_call() {
    }

    // decompiled from Move bytecode v6
}

