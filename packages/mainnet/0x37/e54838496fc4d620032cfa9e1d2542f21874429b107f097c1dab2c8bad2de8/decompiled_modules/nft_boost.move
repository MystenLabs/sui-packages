module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::nft_boost {
    struct EBoosted<phantom T0, phantom T1> has copy, drop {
        owner: address,
        boosted_pos: 0x2::object::ID,
        shares: u64,
    }

    struct EUnboosted<phantom T0, phantom T1> has copy, drop {
        owner: address,
        boosted_pos: 0x2::object::ID,
        moved_shares: u64,
    }

    struct EClaimed<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
    }

    struct EStaked<phantom T0> has copy, drop {
        owner: address,
        position: 0x2::object::ID,
        amount: u64,
        tier: u8,
    }

    struct NftLocker<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct NftBoostFactory<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::Pool<T0, T0>,
        admin: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::AdminCap,
        locker: NftLocker<T1>,
        private_policy: 0x2::transfer_policy::TransferPolicy<T1>,
        private_cap: 0x2::transfer_policy::TransferPolicyCap<T1>,
    }

    struct NFTOpenPosition<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        shares: u64,
        pos: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position,
        escrow_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct BoostedUnbondingTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        unlock_ts: u64,
        escrow: 0x2::balance::Balance<T0>,
    }

    public fun new<T0, T1, T2>(arg0: &0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg1: 0x2::transfer_policy::TransferPolicy<T2>, arg2: 0x2::transfer_policy::TransferPolicyCap<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_owner<T0, T0, T1>(arg0, arg3);
        let (v0, v1) = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::create<T0, T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::get_base_apr_bps<T0, T0, T1>(arg0) + 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::get_boost_delta_bps<T0, T0, T1>(arg0), 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::get_max_eps_boosted<T0, T0, T1>(arg0), arg3);
        let v2 = NftLocker<T2>{id: 0x2::object::new(arg3)};
        let v3 = NftBoostFactory<T0, T2>{
            id             : 0x2::object::new(arg3),
            pool           : v0,
            admin          : v1,
            locker         : v2,
            private_policy : arg1,
            private_cap    : arg2,
        };
        0x2::transfer::share_object<NftBoostFactory<T0, T2>>(v3);
    }

    public fun boost<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::PurchaseCap<T2>, arg4: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : NFTOpenPosition<T0, T2> {
        boost_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun boost_and_transfer<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::PurchaseCap<T2>, arg4: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = boost_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<NFTOpenPosition<T0, T2>>(v0, 0x2::tx_context::sender(arg6));
    }

    public(friend) fun boost_internal<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::PurchaseCap<T2>, arg4: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : NFTOpenPosition<T0, T2> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2) == 0x2::tx_context::sender(arg6), 7);
        let (v0, v1, _) = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::get_op_fields<T0>(&arg4);
        assert!(v1 == 0, 2);
        assert!(v0 > 0, 3);
        fund_and_poke<T0, T1, T2>(arg0, arg1, arg5);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::sync<T0, T0, T1>(arg1, arg5);
        let v3 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::withdraw_shares<T0, T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::borrow_normal_pool_mut<T0, T0, T1>(arg1), 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::borrow_op_from_internal_pool_mut<T0>(&mut arg4), v0, arg5);
        let v4 = 0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::claim<T0, T0, T1>(arg1, &mut arg4, arg6)));
        let v5 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_new<T0, T0>(&mut arg0.pool, v3, arg5);
        let (v6, v7) = purchase_nft<T0, T2>(arg0, arg2, arg3, arg6);
        let v8 = NFTOpenPosition<T0, T2>{
            id        : 0x2::object::new(arg6),
            shares    : v4,
            pos       : v5,
            escrow_id : v7,
            kiosk_id  : v6,
        };
        let v9 = EBoosted<T0, T2>{
            owner       : 0x2::tx_context::sender(arg6),
            boosted_pos : 0x2::object::id<NFTOpenPosition<T0, T2>>(&v8),
            shares      : v0,
        };
        0x2::event::emit<EBoosted<T0, T2>>(v9);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::clean_and_destroy_position<T0>(arg4);
        v8
    }

    public fun claim<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = claim_internal<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        v0
    }

    public fun claim_and_transfer<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_internal<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun claim_internal<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        0x2::coin::from_balance<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::claim_all<T0, T0>(&mut arg0.pool, &mut arg2.pos), arg3)
    }

    fun fund_and_poke<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::pre_accrue_need<T0, T0>(&arg0.pool, 0x2::clock::timestamp_ms(arg2) / 1000);
        if (v0 > 0) {
            assert!(v0 <= 0x2::balance::value<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::borrow_reserve<T0, T0, T1>(arg1)), 1);
            0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::fund_reserve<T0, T0>(&mut arg0.pool, 0x2::balance::split<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::borrow_reserve_mut<T0, T0, T1>(arg1), v0));
        };
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::poke<T0, T0>(&mut arg0.pool, arg2);
    }

    fun purchase_nft<T0, T1: store + key>(arg0: &mut NftBoostFactory<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::PurchaseCap<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v1 = 0x2::kiosk::purchase_cap_item<T1>(&arg2);
        assert!(v0 == 0x2::kiosk::purchase_cap_kiosk<T1>(&arg2), 8);
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T1>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(&arg0.private_policy, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, T1>(&mut arg0.locker.id, v1, v2);
        (v0, v1)
    }

    public fun request_unstake<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : BoostedUnbondingTicket<T0> {
        request_unstake_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun request_unstake_and_transfer<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = request_unstake_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<BoostedUnbondingTicket<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun request_unstake_internal<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : BoostedUnbondingTicket<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        assert!(arg3 > 0 && arg3 <= arg2.shares, 6);
        fund_and_poke<T0, T1, T2>(arg0, arg1, arg4);
        arg2.shares = arg2.shares - arg3;
        BoostedUnbondingTicket<T0>{
            id        : 0x2::object::new(arg5),
            unlock_ts : 0x2::clock::timestamp_ms(arg4) / 1000 + 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::get_unbound_sec<T0, T0, T1>(arg1),
            escrow    : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::withdraw_shares<T0, T0>(&mut arg0.pool, &mut arg2.pos, arg3, arg4),
        }
    }

    fun return_nft<T0, T1: store + key>(arg0: &mut NftBoostFactory<T0, T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::transfer_policy::TransferPolicy<T1>, arg4: 0x2::object::ID) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        0x2::kiosk::lock<T1>(arg1, &v2, arg3, 0x2::dynamic_object_field::remove<0x2::object::ID, T1>(&mut arg0.locker.id, arg4));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public fun stake_more<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut NFTOpenPosition<T0, T2>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 4);
        fund_and_poke<T0, T1, T2>(arg0, arg1, arg4);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_more<T0, T0>(&mut arg0.pool, &mut arg2.pos, v0, arg4);
        arg2.shares = arg2.shares + v1;
        let v2 = EStaked<T0>{
            owner    : 0x2::tx_context::sender(arg5),
            position : 0x2::object::id<NFTOpenPosition<T0, T2>>(arg2),
            amount   : v1,
            tier     : 1,
        };
        0x2::event::emit<EStaked<T0>>(v2);
    }

    public fun sync<T0, T1, T2>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &0x2::clock::Clock) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        fund_and_poke<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun unbond<T0, T1>(arg0: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg1: BoostedUnbondingTicket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        unbond_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun unbond_and_transfer<T0, T1>(arg0: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg1: BoostedUnbondingTicket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unbond_internal<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unbond_internal<T0, T1>(arg0: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg1: BoostedUnbondingTicket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg0);
        let BoostedUnbondingTicket {
            id        : v0,
            unlock_ts : v1,
            escrow    : v2,
        } = arg1;
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v1, 5);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v2, arg3)
    }

    public fun unboost<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<T2>, arg5: NFTOpenPosition<T0, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0> {
        unboost_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun unboost_and_transfer<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<T2>, arg5: NFTOpenPosition<T0, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = unboost_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    public(friend) fun unboost_internal<T0, T1, T2: store + key>(arg0: &mut NftBoostFactory<T0, T2>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::StakingFactory<T0, T0, T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<T2>, arg5: NFTOpenPosition<T0, T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::OpenPosition<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_is_compatible<T0, T0, T1>(arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::assert_not_paused<T0, T0, T1>(arg1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg2) == 0x2::tx_context::sender(arg7), 7);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg5.kiosk_id, 8);
        fund_and_poke<T0, T1, T2>(arg0, arg1, arg6);
        let NFTOpenPosition {
            id        : v0,
            shares    : v1,
            pos       : v2,
            escrow_id : v3,
            kiosk_id  : _,
        } = arg5;
        let v5 = v2;
        let v6 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::withdraw_shares<T0, T0>(&mut arg0.pool, &mut v5, v1, arg6);
        0x2::balance::join<T0>(&mut v6, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::claim_all<T0, T0>(&mut arg0.pool, &mut v5));
        return_nft<T0, T2>(arg0, arg2, arg3, arg4, v3);
        let v7 = EUnboosted<T0, T2>{
            owner        : 0x2::tx_context::sender(arg7),
            boosted_pos  : 0x2::object::id<NFTOpenPosition<T0, T2>>(&arg5),
            moved_shares : v1,
        };
        0x2::event::emit<EUnboosted<T0, T2>>(v7);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::position_destroy_empty(v5);
        0x2::object::delete(v0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory::stake_internal<T0, T0, T1>(arg1, 0x2::coin::from_balance<T0>(v6, arg7), arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

