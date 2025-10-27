module 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::token_vesting {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft_index: u64,
        balance: 0x2::balance::Balance<T0>,
        beneficiaries: 0x2::table::Table<0x2::object::ID, VestingInfo>,
        amount: u64,
        redeemed_amount: u64,
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
        redeemed_amount: u64,
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
        period: u64,
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

    struct ClaimNFTEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        address: address,
    }

    public fun allocate<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::admin_cap::AdminCap, arg2: &mut Pool<T0>, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x1::vector::length<u64>(&arg5);
        assert!(0x1::vector::length<u64>(&arg4) > 0 && 0x1::vector::length<u64>(&arg4) == v0, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::parameter_illegal());
        let v1 = *0x1::vector::borrow<u64>(&arg5, 0);
        assert!(v1 > 0x2::clock::timestamp_ms(arg6) / 1000, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::time_illegal());
        let v2 = 1;
        let v3 = 0x1::vector::empty<PeriodInfo>();
        let v4 = 0;
        while (v2 <= v0) {
            if (v2 != v0) {
                assert!(*0x1::vector::borrow<u64>(&arg5, v2 - 1) < *0x1::vector::borrow<u64>(&arg5, v2), 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::release_interval_error());
            };
            let v5 = *0x1::vector::borrow<u64>(&arg4, v2 - 1);
            v4 = v4 + v5;
            let v6 = PeriodInfo{
                release_time : *0x1::vector::borrow<u64>(&arg5, v2 - 1),
                period       : v2,
                amount       : v5,
                is_redeemed  : false,
            };
            0x1::vector::push_back<PeriodInfo>(&mut v3, v6);
            v2 = v2 + 1;
        };
        assert!(v4 > 0, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::err_amount_is_zero());
        arg2.amount = arg2.amount + v4;
        arg2.nft_index = arg2.nft_index + 1;
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg2.amount - arg2.redeemed_amount, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::err_balance_not_enough());
        let v7 = VestingInfo{
            is_pause : false,
            msg      : 0x1::string::utf8(b""),
        };
        let v8 = VestingNFT{
            id              : 0x2::object::new(arg7),
            pool            : 0x2::object::id<Pool<T0>>(arg2),
            index           : arg2.nft_index,
            amount          : v4,
            redeemed_amount : 0,
            start_time      : v1,
            period_infos    : v3,
        };
        let v9 = 0x2::object::id<VestingNFT>(&v8);
        0x2::table::add<0x2::object::ID, VestingInfo>(&mut arg2.beneficiaries, v9, v7);
        let v10 = AllocateEvent{
            pool_id    : 0x2::object::id<Pool<T0>>(arg2),
            nft_id     : v9,
            start_time : v1,
            amount     : v4,
            periods    : v0,
        };
        0x2::event::emit<AllocateEvent>(v10);
        0x2::dynamic_object_field::add<address, VestingNFT>(&mut arg2.id, arg3, v8);
    }

    public fun claim_nft<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) : VestingNFT {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<address, VestingNFT>(&arg1.id, 0x2::tx_context::sender(arg2)), 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::nft_not_found());
        let v0 = 0x2::dynamic_object_field::remove<address, VestingNFT>(&mut arg1.id, 0x2::tx_context::sender(arg2));
        assert!(!0x2::table::borrow<0x2::object::ID, VestingInfo>(&arg1.beneficiaries, 0x2::object::id<VestingNFT>(&v0)).is_pause, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::vesting_paused());
        let v1 = ClaimNFTEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            nft_id  : 0x2::object::id<VestingNFT>(&v0),
            address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClaimNFTEvent>(v1);
        v0
    }

    public fun create_pool<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::admin_cap::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = Pool<T0>{
            id              : 0x2::object::new(arg2),
            nft_index       : 0,
            balance         : 0x2::balance::zero<T0>(),
            beneficiaries   : 0x2::table::new<0x2::object::ID, VestingInfo>(arg2),
            amount          : 0,
            redeemed_amount : 0,
        };
        let v1 = CreatePoolEvent{pool_id: 0x2::object::id<Pool<T0>>(&v0)};
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::err_amount_is_zero());
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            amount  : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: TOKEN_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Haedal VIP Pass #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://node1.irys.xyz/HMkdVVHmOycYYXP7hUEfn0snDF3d-7sYQ3WUKy95Vu8"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.haedal.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"HAEDAL"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The NFT certificate for you to claim vested Haedal tokens"));
        let v4 = 0x2::package::claim<TOKEN_VESTING>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VestingNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<VestingNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VestingNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun pause<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::admin_cap::AdminCap, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg2.beneficiaries, arg3);
        assert!(!v0.is_pause, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::already_paused());
        v0.is_pause = true;
        v0.msg = arg4;
        let v1 = PauseEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg2),
            nft_id  : arg3,
        };
        0x2::event::emit<PauseEvent>(v1);
    }

    public fun redeem<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &mut Pool<T0>, arg2: &mut VestingNFT, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x2::object::id<VestingNFT>(arg2);
        assert!(!0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg1.beneficiaries, v0).is_pause, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::vesting_paused());
        assert!(arg3 > 0 && arg3 <= 0x1::vector::length<PeriodInfo>(&arg2.period_infos), 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::period_illegal());
        let v1 = 0x1::vector::borrow_mut<PeriodInfo>(&mut arg2.period_infos, arg3 - 1);
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 >= v1.release_time, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::lock_time_not_end());
        assert!(!v1.is_redeemed, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::already_redeemed());
        v1.is_redeemed = true;
        let v2 = v1.amount;
        arg1.redeemed_amount = arg1.redeemed_amount + v2;
        arg2.redeemed_amount = arg2.redeemed_amount + v2;
        if (arg2.amount == arg2.redeemed_amount) {
            0x2::table::remove<0x2::object::ID, VestingInfo>(&mut arg1.beneficiaries, v0);
        };
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v2, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::balance_not_enough());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v2), arg5), 0x2::tx_context::sender(arg5));
        let v3 = RedeemEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg1),
            nft_id  : 0x2::object::id<VestingNFT>(arg2),
            period  : arg3,
            amount  : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    public fun unpause<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::admin_cap::AdminCap, arg2: &mut Pool<T0>, arg3: 0x2::object::ID) {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VestingInfo>(&mut arg2.beneficiaries, arg3);
        assert!(v0.is_pause, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::already_unpaused());
        v0.is_pause = false;
        v0.msg = 0x1::string::utf8(b"");
        let v1 = UnPauseEvent{
            pool_id : 0x2::object::id<Pool<T0>>(arg2),
            nft_id  : arg3,
        };
        0x2::event::emit<UnPauseEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::Versioned, arg1: &0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::admin_cap::AdminCap, arg2: &mut Pool<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::versioned::check_version(arg0);
        let v0 = 0x2::balance::value<T0>(&arg2.balance) - arg2.amount - arg2.redeemed_amount;
        assert!(v0 > 0, 0x57cccd892f1dd4e9b840b7aecb3904cefbad98a7793d532ce525e0fcca850f03::errors::err_amount_is_zero());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v0), arg3)
    }

    // decompiled from Move bytecode v6
}

