module 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::prizePool {
    struct PrizePool has store, key {
        id: 0x2::object::UID,
        level: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AutherizeCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun distributeEvery(arg0: vector<address>, arg1: &mut PrizePool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg0);
        while (v0 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance) / v1 * 90 / 100), arg2), *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun distributeRank(arg0: vector<address>, arg1: vector<u64>, arg2: &mut PrizePool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 2);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg0);
        let v2 = vector[];
        while (v0 < v1) {
            0x1::vector::push_back<u64>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(&arg2.balance) * *0x1::vector::borrow<u64>(&arg1, v0) / 1000);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance, *0x1::vector::borrow<u64>(&v2, v0)), arg3), *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun getBonus(arg0: &mut PrizePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1 < 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun getPoolLevel(arg0: &PrizePool) : 0x1::string::String {
        arg0.level
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePool{
            id      : 0x2::object::new(arg0),
            level   : 0x1::string::utf8(b"gold"),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = PrizePool{
            id      : 0x2::object::new(arg0),
            level   : 0x1::string::utf8(b"sliver"),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = PrizePool{
            id      : 0x2::object::new(arg0),
            level   : 0x1::string::utf8(b"bronze"),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<PrizePool>(v0);
        0x2::transfer::public_share_object<PrizePool>(v1);
        0x2::transfer::public_share_object<PrizePool>(v2);
        let v3 = AutherizeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AutherizeCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun updateBalance(arg0: &mut PrizePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun withdraw(arg0: &AutherizeCap, arg1: &mut PrizePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

