module 0x355714a1eeb7ab1d80902da6c92001170cda1212edf524c32aa308a3ac177c31::token_vesting {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft_index: u64,
        balance: 0x2::balance::Balance<T0>,
        beneficiaries: 0x2::table::Table<0x2::object::ID, VestingInfo>,
        amount: u64,
        released_amount: u64,
    }

    struct VestingInfo has drop, store {
        is_pause: bool,
        msg: 0x1::string::String,
    }

    struct VestingNFT has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        index: u64,
        amount: u64,
        released_amount: u64,
        start_time: u64,
        period_infos: vector<PeriodInfo>,
    }

    struct PeriodInfo has copy, drop, store {
        release_time: u64,
        period: u64,
        amount: u64,
        is_redeemed: bool,
    }

    struct TOKEN_VESTING has drop {
        dummy_field: bool,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct AllocateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        start_time: u64,
        amount: u64,
        periods: u64,
    }

    struct RedeemEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        period: u16,
        amount: u64,
    }

    struct PauseEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct UnPauseEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    public fun allocate<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pool == 0x2::object::id<Pool<T0>>(arg1), 4);
        let v0 = 0x1::vector::length<u64>(&arg4);
        assert!(0x1::vector::length<u64>(&arg3) > 0 && 0x1::vector::length<u64>(&arg3) == v0, 1);
        let v1 = *0x1::vector::borrow<u64>(&arg4, 0);
        assert!(v1 > 0x2::clock::timestamp_ms(arg5) / 1000, 2);
        let v2 = 1;
        let v3 = 0x1::vector::empty<PeriodInfo>();
        let v4 = 0;
        while (v2 <= v0) {
            if (v2 != v0) {
                assert!(*0x1::vector::borrow<u64>(&arg4, v2 - 1) < *0x1::vector::borrow<u64>(&arg4, v2), 6);
            };
            let v5 = *0x1::vector::borrow<u64>(&arg3, v2 - 1);
            v4 = v4 + v5;
            let v6 = PeriodInfo{
                release_time : *0x1::vector::borrow<u64>(&arg4, v2 - 1),
                period       : v2,
                amount       : v5,
                is_redeemed  : false,
            };
            0x1::vector::push_back<PeriodInfo>(&mut v3, v6);
            v2 = v2 + 1;
        };
        arg1.amount = arg1.amount + v4;
        arg1.nft_index = arg1.nft_index + 1;
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg1.amount - arg1.released_amount, 9);
        let v7 = VestingInfo{
            is_pause : false,
            msg      : 0x1::string::utf8(b""),
        };
        let v8 = VestingNFT{
            id              : 0x2::object::new(arg6),
            pool            : 0x2::object::id<Pool<T0>>(arg1),
            index           : arg1.nft_index,
            amount          : v4,
            released_amount : 0,
            start_time      : v1,
            period_infos    : v3,
        };
        let v9 = 0x2::object::id<VestingNFT>(&v8);
        0x2::table::add<0x2::object::ID, VestingInfo>(&mut arg1.beneficiaries, v9, v7);
        let v10 = AllocateEvent{
            pool_id    : 0x2::object::id<Pool<T0>>(arg1),
            nft_id     : v9,
            start_time : v1,
            amount     : v4,
            periods    : v0,
        };
        0x2::event::emit<AllocateEvent>(v10);
        0x2::transfer::transfer<VestingNFT>(v8, arg2);
    }

    public fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id              : 0x2::object::new(arg0),
            nft_index       : 0,
            balance         : 0x2::balance::zero<T0>(),
            beneficiaries   : 0x2::table::new<0x2::object::ID, VestingInfo>(arg0),
            amount          : 0,
            released_amount : 0,
        };
        let v1 = AdminCap{
            id   : 0x2::object::new(arg0),
            pool : 0x2::object::id<Pool<T0>>(&v0),
        };
        let v2 = CreatePoolEvent{
            pool_id : 0x2::object::id<Pool<T0>>(&v0),
            cap_id  : 0x2::object::id<AdminCap>(&v1),
        };
        0x2::event::emit<CreatePoolEvent>(v2);
        0x2::transfer::share_object<Pool<T0>>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        let v0 = DepositEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            amount  : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun init(arg0: TOKEN_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus Pass #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://7klhjnt4vboklad3aqiv4xrtkobe5zhc4aeomw54ew2dy2vh4iaq.arweave.net/-pZ0tnyoXKWAewQRXl4zU4JO5OLgCOZbvCW0PGqn4gE"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cetus"));
        let v4 = 0x2::package::claim<TOKEN_VESTING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VestingNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<VestingNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VestingNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun pause<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        assert!(arg0.pool == 0x2::object::id<Pool<T0>>(arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg1.beneficiaries, arg2);
        assert!(!v0.is_pause, 10);
        v0.is_pause = true;
        v0.msg = arg3;
        let v1 = PauseEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            nft_id  : arg2,
        };
        0x2::event::emit<PauseEvent>(v1);
    }

    public fun redeem<T0>(arg0: &mut Pool<T0>, arg1: &mut VestingNFT, arg2: u16, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<VestingNFT>(arg1);
        assert!(!0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg0.beneficiaries, v0).is_pause, 3);
        assert!(arg2 > 0 && (arg2 as u64) <= 0x1::vector::length<PeriodInfo>(&arg1.period_infos), 8);
        let v1 = 0x1::vector::borrow_mut<PeriodInfo>(&mut arg1.period_infos, (arg2 as u64) - 1);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 >= v1.release_time, 7);
        assert!(!v1.is_redeemed, 5);
        v1.is_redeemed = true;
        let v2 = v1.amount;
        arg0.released_amount = arg0.released_amount + v2;
        arg1.released_amount = arg1.released_amount + v2;
        if (arg1.amount == arg1.released_amount) {
            0x2::table::remove<0x2::object::ID, VestingInfo>(&mut arg0.beneficiaries, v0);
        };
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg4), 0x2::tx_context::sender(arg4));
        let v3 = RedeemEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
            nft_id  : 0x2::object::id<VestingNFT>(arg1),
            period  : arg2,
            amount  : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    public entry fun unpause<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID) {
        assert!(arg0.pool == 0x2::object::id<Pool<T0>>(arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg1.beneficiaries, arg2);
        assert!(v0.is_pause, 11);
        v0.is_pause = false;
        v0.msg = 0x1::string::utf8(b"");
        let v1 = UnPauseEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            nft_id  : arg2,
        };
        0x2::event::emit<UnPauseEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

