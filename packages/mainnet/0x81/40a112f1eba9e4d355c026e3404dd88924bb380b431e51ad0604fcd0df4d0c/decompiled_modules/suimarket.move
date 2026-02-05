module 0xa6d7003f05576dc9b38bd6f03fc580017d995e8c8b0bb4ee2beab15af74078cc::suimarket {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct FeeVault has key {
        id: 0x2::object::UID,
        recipient: address,
    }

    struct Market has key {
        id: 0x2::object::UID,
        title: vector<u8>,
        option_a: vector<u8>,
        option_b: vector<u8>,
        expires_at: u64,
        resolved: bool,
        outcome: u8,
        pool_a: u64,
        pool_b: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Position has key {
        id: 0x2::object::UID,
        owner: address,
        market_id: 0x2::object::ID,
        side: u8,
        amount: u64,
        claimed: bool,
    }

    struct MarketCreated has copy, drop, store {
        market_id: 0x2::object::ID,
    }

    public entry fun bet_a(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pool_a = arg0.pool_a + v1;
        let v2 = Position{
            id        : 0x2::object::new(arg2),
            owner     : v0,
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            side      : 1,
            amount    : v1,
            claimed   : false,
        };
        0x2::transfer::transfer<Position>(v2, v0);
    }

    public entry fun bet_b(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.resolved, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pool_b = arg0.pool_b + v1;
        let v2 = Position{
            id        : 0x2::object::new(arg2),
            owner     : v0,
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            side      : 2,
            amount    : v1,
            claimed   : false,
        };
        0x2::transfer::transfer<Position>(v2, v0);
    }

    public entry fun claim(arg0: &mut Market, arg1: &mut Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.resolved, 20);
        assert!(arg1.owner == v0, 21);
        assert!(!arg1.claimed, 22);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 23);
        assert!(arg1.side == arg0.outcome, 24);
        let v1 = if (arg0.outcome == 1) {
            arg0.pool_a
        } else {
            arg0.pool_b
        };
        arg1.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1.amount * (arg0.pool_a + arg0.pool_b) / v1), arg2), v0);
    }

    public entry fun create_market(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id         : 0x2::object::new(arg5),
            title      : arg1,
            option_a   : arg2,
            option_b   : arg3,
            expires_at : arg4,
            resolved   : false,
            outcome    : 0,
            pool_a     : 0,
            pool_b     : 0,
            vault      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = MarketCreated{market_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::transfer<Market>(v0, 0x2::tx_context::sender(arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeVault{
            id        : 0x2::object::new(arg0),
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<FeeVault>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun resolve(arg0: &AdminCap, arg1: &FeeVault, arg2: &mut Market, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.resolved, 10);
        assert!(arg3 == 1 || arg3 == 2, 11);
        arg2.resolved = true;
        arg2.outcome = arg3;
        let v0 = (arg2.pool_a + arg2.pool_b) * 15 / 1000;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.vault, v0), arg4), arg1.recipient);
        };
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeVault, arg2: address) {
        arg1.recipient = arg2;
    }

    // decompiled from Move bytecode v6
}

