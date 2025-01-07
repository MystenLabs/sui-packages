module 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::pool {
    struct AdminConfig has store, key {
        id: 0x2::object::UID,
        fees_sales: u8,
        permissions: vector<address>,
        owner: address,
    }

    struct Account has copy, drop, store {
        adr: address,
        amount: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LaunchpadINOCreatedEvent has copy, drop {
        launchpad_ino_id: 0x2::object::ID,
    }

    struct BuyCreatedEvent has copy, drop {
        buy_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct ClaimCreatedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct RefundCreatedEvent has copy, drop {
        refund_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct ListSlugINOEvent has copy, drop {
        code: 0x1::string::String,
        launchpad_ino_id: 0x2::object::ID,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        total_raised_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_raise_nfts: u64,
        accounts_whitelist: vector<Account>,
        price: u64,
        maximum_amount: u64,
        minimum_amount: u64,
        time_allow_list_start: u64,
        time_start_sales: u64,
        time_end_sales: u64,
        time_claim: u64,
        isRefund: u8,
        status: u8,
        owner: address,
    }

    struct Buy has store, key {
        id: 0x2::object::UID,
        account: address,
        amount: u64,
    }

    struct Listing<T0: store + key> has store, key {
        id: 0x2::object::UID,
        item: T0,
        owner: address,
    }

    public entry fun add_pool(arg0: &mut 0xf3f4cee9aa11baaece24202f8c56d0e6db0164fe0413f0fe95e320e4b372d61b::launchpadINO::LaunchpadINO, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg10);
        0x2::object::uid_to_inner(&v0);
        let v1 = Pool{
            id                    : v0,
            total_raised_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_raise_nfts      : arg1,
            accounts_whitelist    : 0x1::vector::empty<Account>(),
            price                 : arg2,
            maximum_amount        : arg3,
            minimum_amount        : arg4,
            time_allow_list_start : arg5,
            time_start_sales      : arg6,
            time_end_sales        : arg7,
            time_claim            : arg8,
            isRefund              : arg9,
            status                : 0,
            owner                 : 0x2::tx_context::sender(arg10),
        };
        let v2 = PoolCreatedEvent{pool_id: 0x2::object::id<Pool>(&v1)};
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun add_whitelist(arg0: &mut Pool, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = Account{
                adr    : 0x1::vector::pop_back<address>(&mut arg1),
                amount : 0x1::vector::pop_back<u64>(&mut arg2),
            };
            0x1::vector::push_back<Account>(&mut arg0.accounts_whitelist, v0);
        };
    }

    public entry fun buy(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = maybe_split_and_transfer_rest<0x2::sui::SUI>(arg1, arg2, v0, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_raised_sui, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        let v4 = Buy{
            id      : 0x2::object::new(arg3),
            account : v2,
            amount  : v3,
        };
        let v5 = BuyCreatedEvent{
            buy_id : 0x2::object::id<Buy>(&v4),
            amount : v3,
            owner  : v2,
        };
        0x2::event::emit<BuyCreatedEvent>(v5);
        0x2::dynamic_object_field::add<0x2::object::ID, Buy>(&mut arg0.id, 0x2::object::id<Buy>(&v4), v4);
    }

    public entry fun claim<T0: store + key>(arg0: &mut Pool, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Buy>(&mut arg0.id, arg1);
        assert!(v0.amount > 0, 135289670000);
        assert!(0x2::tx_context::sender(arg2) == v0.account, 135289670003);
        let v1 = take_profits<T0>(arg0, arg2);
        0x2::transfer::public_transfer<T0>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit_list_nfts<T0: store + key>(arg0: &mut Pool, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            deposit_nfts<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1), arg2);
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public entry fun deposit_nfts<T0: store + key>(arg0: &mut Pool, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing<T0>{
            id    : 0x2::object::new(arg2),
            item  : arg1,
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::dynamic_object_field::add<address, Listing<T0>>(&mut arg0.id, @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c, v0);
    }

    fun get_amount_by_account_whitelist(arg0: &vector<Account>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Account>(arg0)) {
            let v1 = 0x1::vector::borrow<Account>(arg0, v0);
            if (v1.adr == arg1) {
                return (v1.amount as u64)
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public fun maybe_split_and_transfer_rest<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        0x2::coin::split<T0>(&mut arg0, arg1, arg3)
    }

    fun take_profits<T0: store + key>(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        0x2::dynamic_object_field::remove<address, T0>(&mut arg0.id, @0x790169f7b248c93f249432509b73e36d83ba9f1e9da1127dcd58181916663e3c)
    }

    public entry fun update_pool(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.owner, 135289670003);
        arg0.total_raise_nfts = arg1;
        arg0.price = arg2;
        arg0.maximum_amount = arg3;
        arg0.minimum_amount = arg4;
        arg0.time_allow_list_start = arg5;
        arg0.time_start_sales = arg6;
        arg0.time_claim = arg8;
        arg0.isRefund = arg9;
    }

    // decompiled from Move bytecode v6
}

