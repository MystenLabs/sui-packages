module 0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::pool {
    struct Bag<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nfts: vector<T0>,
    }

    struct AdminConfig has store, key {
        id: 0x2::object::UID,
        fees_sales: u8,
        permissions: vector<address>,
        owner: address,
    }

    struct Account has copy, drop, store {
        adr: address,
        quantity: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LaunchpadINOCreatedEvent has copy, drop {
        launchpad_ino_id: 0x2::object::ID,
    }

    struct BuyCreatedEvent has copy, drop {
        buy_id: 0x2::object::ID,
        quantity: u64,
        owner: address,
    }

    struct ClaimCreatedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        quantity: u64,
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

    struct Buyer has store, key {
        id: 0x2::object::UID,
        account: address,
        quantity: u64,
        claimed: u8,
    }

    struct StoreNFT<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nfts: vector<T0>,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        launchpad_ino_id: 0x2::object::ID,
        total_raised_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_raise_nfts: u64,
        total_bought: u64,
        accounts_whitelist: vector<Account>,
        price: u64,
        maximum_amount: u64,
        minimum_amount: u64,
        time_allow_list_start: u64,
        time_start_sales: u64,
        time_end_sales: u64,
        time_claim: u64,
        isRefund: u8,
        type: u8,
        isLocked: u8,
        status: u8,
        owner: address,
        create_date: u64,
        update_date: u64,
        buyers: 0x2::vec_map::VecMap<address, Buyer>,
    }

    public entry fun add_pool(arg0: &mut 0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::launchpadINO::LaunchpadINO, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::launchpadINO::get_vote_id(arg0) != 0x2::object::id_from_address(@0x7b), 135289670009);
        assert!(v0 == 0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::launchpadINO::get_owner(arg0), 135289670003);
        let v1 = 0x2::object::new(arg11);
        0x2::object::uid_to_inner(&v1);
        let v2 = Pool{
            id                    : v1,
            launchpad_ino_id      : 0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::launchpadINO::get_id(arg0),
            total_raised_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_raise_nfts      : arg1,
            total_bought          : 0,
            accounts_whitelist    : 0x1::vector::empty<Account>(),
            price                 : arg2,
            maximum_amount        : arg3,
            minimum_amount        : arg4,
            time_allow_list_start : arg5,
            time_start_sales      : arg6,
            time_end_sales        : arg7,
            time_claim            : arg8,
            isRefund              : arg9,
            type                  : arg10,
            isLocked              : 0,
            status                : 0,
            owner                 : v0,
            create_date           : 0,
            update_date           : 0,
            buyers                : 0x2::vec_map::empty<address, Buyer>(),
        };
        let v3 = 0x2::object::id<Pool>(&v2);
        let v4 = PoolCreatedEvent{pool_id: v3};
        0x2::event::emit<PoolCreatedEvent>(v4);
        0x6dc3a29b6623df9f1404e49d79e421a4f736a56bb7bb6c38f93cac0c03892ad8::launchpadINO::add_more_pools(arg0, v3);
        0x2::transfer::share_object<Pool>(v2);
    }

    public entry fun add_whitelist(arg0: &mut Pool, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = Account{
                adr      : 0x1::vector::pop_back<address>(&mut arg1),
                quantity : 0x1::vector::pop_back<u64>(&mut arg2),
            };
            0x1::vector::push_back<Account>(&mut arg0.accounts_whitelist, v0);
        };
    }

    public entry fun buy(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.isLocked == 0, 135289670008);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.time_start_sales, 135289670011);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.time_end_sales, 135289670012);
        let v1 = get_amount_by_account_whitelist(&mut arg0.accounts_whitelist, v0);
        if (!0x2::vec_map::contains<address, Buyer>(&arg0.buyers, &v0)) {
            let v2 = Buyer{
                id       : 0x2::object::new(arg5),
                account  : v0,
                quantity : 0,
                claimed  : 0,
            };
            let v3 = BuyCreatedEvent{
                buy_id   : 0x2::object::id<Buyer>(&v2),
                quantity : arg4,
                owner    : v0,
            };
            0x2::event::emit<BuyCreatedEvent>(v3);
            0x2::vec_map::insert<address, Buyer>(&mut arg0.buyers, v0, v2);
        };
        let v4 = 0x2::vec_map::get_mut<address, Buyer>(&mut arg0.buyers, &v0);
        v4.quantity = v4.quantity + arg4;
        arg0.total_bought = arg0.total_bought + arg4;
        if (arg0.type == 2 || arg0.type == 1) {
            assert!(v1 > 0, 135289670013);
        };
        assert!(v1 <= v4.quantity || v4.quantity <= arg0.maximum_amount, 135289670014);
        let v5 = maybe_split_and_transfer_rest<0x2::sui::SUI>(arg1, arg2, v0, arg5);
        0x2::coin::value<0x2::sui::SUI>(&v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_raised_sui, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
    }

    public entry fun claim<T0: store + key>(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.isLocked == 0, 135289670008);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.time_claim, 135289670010);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::get_mut<address, Buyer>(&mut arg0.buyers, &v0);
        assert!(v0 == v1.account, 135289670003);
        assert!(v1.quantity > 0, 135289670000);
        assert!(v1.claimed == 0, 135289670001);
        while (0 < v1.quantity) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, Bag<T0>>(&mut arg0.id, b"bag").nfts), v0);
        };
        v1.claimed = 1;
    }

    public entry fun create_bag<T0: store + key>(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bag<T0>{
            id   : 0x2::object::new(arg1),
            nfts : 0x1::vector::empty<T0>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, Bag<T0>>(&mut arg0.id, b"bag", v0);
    }

    public entry fun deposit_nfts_to_bag<T0: store + key>(arg0: &mut Pool, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::append<T0>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, Bag<T0>>(&mut arg0.id, b"bag").nfts, arg1);
    }

    fun get_amount_by_account_whitelist(arg0: &vector<Account>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Account>(arg0)) {
            let v1 = 0x1::vector::borrow<Account>(arg0, v0);
            if (v1.adr == arg1) {
                return (v1.quantity as u64)
            };
            v0 = v0 + 1;
        };
        abort 0
    }

    public entry fun lock_pool(arg0: &mut AdminConfig, arg1: &mut Pool, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 135289670007);
        arg1.isLocked = arg2;
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

    public entry fun update_pool(arg0: &mut Pool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.isLocked == 0, 135289670008);
        assert!(0x2::clock::timestamp_ms(arg10) >= arg0.time_start_sales, 135289670011);
        assert!(0x2::tx_context::sender(arg11) == arg0.owner, 135289670003);
        arg0.total_raise_nfts = arg1;
        arg0.price = arg2;
        arg0.maximum_amount = arg3;
        arg0.minimum_amount = arg4;
        arg0.time_allow_list_start = arg5;
        arg0.time_start_sales = arg6;
        arg0.time_end_sales = arg7;
        arg0.time_claim = arg8;
        arg0.isRefund = arg9;
    }

    // decompiled from Move bytecode v6
}

