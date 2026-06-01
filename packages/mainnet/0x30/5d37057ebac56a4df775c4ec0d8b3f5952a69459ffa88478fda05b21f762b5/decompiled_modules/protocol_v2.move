module 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::protocol_v2 {
    struct GlobalRegistry has key {
        id: 0x2::object::UID,
        active_offers: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct EscrowKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CoinEscrowKey has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinRequirement has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        paid: bool,
    }

    struct BundleOffer has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: 0x1::option::Option<address>,
        maker_nft_ids: vector<0x2::object::ID>,
        requested_nft_ids: vector<0x2::object::ID>,
        maker_nfts_deposited: u64,
        requested_nfts_deposited: u64,
        requested_coins: vector<CoinRequirement>,
        expiration_ms: u64,
        state: u8,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        maker_nft_ids: vector<0x2::object::ID>,
        requested_nft_ids: vector<0x2::object::ID>,
        requested_coins: vector<CoinRequirement>,
        expiration_ms: u64,
    }

    struct OfferActivated has copy, drop {
        offer_id: 0x2::object::ID,
    }

    struct NftDeposited has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        depositor: address,
        maker_side: bool,
    }

    struct NftReleased has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        recipient: address,
        maker_side: bool,
    }

    struct MakerCoinDeposited has copy, drop {
        offer_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct TakerPaymentDeposited has copy, drop {
        offer_id: 0x2::object::ID,
        payer: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct MakerCoinReleased has copy, drop {
        offer_id: 0x2::object::ID,
        recipient: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapExecuted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    struct OfferAdminCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        admin: address,
    }

    struct OfferExpiredCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    public fun activate_offer(arg0: &mut GlobalRegistry, arg1: &mut BundleOffer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg1.maker, 1);
        assert!(arg1.maker_nfts_deposited == 0x1::vector::length<0x2::object::ID>(&arg1.maker_nft_ids), 7);
        let v0 = 0x2::object::id<BundleOffer>(arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.active_offers, v0, true);
        let v1 = OfferActivated{offer_id: v0};
        0x2::event::emit<OfferActivated>(v1);
        arg1.state = 1;
    }

    public fun admin_cancel_offer(arg0: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::AdminCap, arg1: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg2: &mut GlobalRegistry, arg3: &mut BundleOffer, arg4: &mut 0x2::tx_context::TxContext) {
        0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::assert_admin(arg0, arg1);
        assert!(arg3.state == 0 || arg3.state == 1, 4);
        assert_no_requested_assets_deposited(arg3);
        if (arg3.state == 1) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.active_offers, 0x2::object::id<BundleOffer>(arg3));
        };
        arg3.state = 4;
        let v0 = OfferAdminCancelled{
            offer_id : 0x2::object::id<BundleOffer>(arg3),
            admin    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<OfferAdminCancelled>(v0);
    }

    fun assert_all_nfts_released(arg0: &BundleOffer) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.maker_nft_ids)) {
            let v1 = EscrowKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg0.maker_nft_ids, v0)};
            assert!(!0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v1), 7);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.requested_nft_ids)) {
            let v2 = EscrowKey{id: *0x1::vector::borrow<0x2::object::ID>(&arg0.requested_nft_ids, v0)};
            assert!(!0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v2), 7);
            v0 = v0 + 1;
        };
    }

    fun assert_no_requested_assets_deposited(arg0: &BundleOffer) {
        assert!(arg0.requested_nfts_deposited == 0, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<CoinRequirement>(&arg0.requested_coins)) {
            assert!(0x1::vector::borrow<CoinRequirement>(&arg0.requested_coins, v0).paid == 0x1::vector::borrow<CoinRequirement>(&arg0.requested_coins, v0).amount == 0, 4);
            v0 = v0 + 1;
        };
    }

    fun assert_ready_to_release(arg0: &BundleOffer, arg1: address) {
        assert_taker_allowed(arg0, arg1);
        assert!(arg0.requested_nfts_deposited == 0x1::vector::length<0x2::object::ID>(&arg0.requested_nft_ids), 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<CoinRequirement>(&arg0.requested_coins)) {
            assert!(0x1::vector::borrow<CoinRequirement>(&arg0.requested_coins, v0).paid, 8);
            v0 = v0 + 1;
        };
    }

    fun assert_taker_allowed(arg0: &BundleOffer, arg1: address) {
        if (0x1::option::is_some<address>(&arg0.taker)) {
            assert!(arg1 == *0x1::option::borrow<address>(&arg0.taker), 1);
        };
    }

    public fun cancel_expired_offer(arg0: &mut GlobalRegistry, arg1: &mut BundleOffer, arg2: &0x2::clock::Clock) {
        assert!(arg1.state == 0 || arg1.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.expiration_ms, 2);
        assert_no_requested_assets_deposited(arg1);
        if (arg1.state == 1) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, 0x2::object::id<BundleOffer>(arg1));
        };
        arg1.state = 5;
        let v0 = OfferExpiredCancelled{
            offer_id : 0x2::object::id<BundleOffer>(arg1),
            maker    : arg1.maker,
        };
        0x2::event::emit<OfferExpiredCancelled>(v0);
    }

    public fun cancel_offer(arg0: &mut GlobalRegistry, arg1: &mut BundleOffer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.maker, 1);
        assert!(arg1.state == 0 || arg1.state == 1, 4);
        assert_no_requested_assets_deposited(arg1);
        if (arg1.state == 1) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, 0x2::object::id<BundleOffer>(arg1));
        };
        arg1.state = 3;
        let v0 = OfferCancelled{
            offer_id : 0x2::object::id<BundleOffer>(arg1),
            maker    : arg1.maker,
        };
        0x2::event::emit<OfferCancelled>(v0);
    }

    fun contains_id(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_draft_offer(arg0: 0x1::option::Option<address>, arg1: vector<0x2::object::ID>, arg2: vector<0x2::object::ID>, arg3: vector<CoinRequirement>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg6), 9);
        assert!(arg4 >= 300000 && arg4 <= 31536000000, 3);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg4;
        let v2 = BundleOffer{
            id                       : 0x2::object::new(arg7),
            maker                    : v0,
            taker                    : arg0,
            maker_nft_ids            : arg1,
            requested_nft_ids        : arg2,
            maker_nfts_deposited     : 0,
            requested_nfts_deposited : 0,
            requested_coins          : arg3,
            expiration_ms            : v1,
            state                    : 0,
        };
        let v3 = OfferCreated{
            offer_id          : 0x2::object::id<BundleOffer>(&v2),
            maker             : v0,
            taker             : arg0,
            maker_nft_ids     : arg1,
            requested_nft_ids : arg2,
            requested_coins   : arg3,
            expiration_ms     : v1,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<BundleOffer>(v2);
    }

    public fun deposit_maker_coin<T0>(arg0: &mut BundleOffer, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = CoinEscrowKey{coin_type: v0};
        if (0x2::dynamic_field::exists<CoinEscrowKey>(&arg0.id, v1)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinEscrowKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<CoinEscrowKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = MakerCoinDeposited{
            offer_id  : 0x2::object::id<BundleOffer>(arg0),
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<MakerCoinDeposited>(v2);
    }

    public fun deposit_maker_nft<T0: store + key>(arg0: &mut BundleOffer, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        let v0 = 0x2::object::id<T0>(&arg1);
        assert!(contains_id(&arg0.maker_nft_ids, v0), 5);
        let v1 = EscrowKey{id: v0};
        assert!(!0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v1), 6);
        let v2 = EscrowKey{id: v0};
        0x2::dynamic_object_field::add<EscrowKey, T0>(&mut arg0.id, v2, arg1);
        arg0.maker_nfts_deposited = arg0.maker_nfts_deposited + 1;
        let v3 = NftDeposited{
            offer_id   : 0x2::object::id<BundleOffer>(arg0),
            nft_id     : v0,
            depositor  : 0x2::tx_context::sender(arg2),
            maker_side : true,
        };
        0x2::event::emit<NftDeposited>(v3);
    }

    public fun deposit_requested_nft<T0: store + key>(arg0: &mut BundleOffer, arg1: T0, arg2: &0x2::clock::Clock, arg3: &0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg3), 9);
        assert!(arg0.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expiration_ms, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert_taker_allowed(arg0, v0);
        let v1 = 0x2::object::id<T0>(&arg1);
        assert!(contains_id(&arg0.requested_nft_ids, v1), 5);
        let v2 = EscrowKey{id: v1};
        assert!(!0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v2), 6);
        let v3 = EscrowKey{id: v1};
        0x2::dynamic_object_field::add<EscrowKey, T0>(&mut arg0.id, v3, arg1);
        arg0.requested_nfts_deposited = arg0.requested_nfts_deposited + 1;
        let v4 = NftDeposited{
            offer_id   : 0x2::object::id<BundleOffer>(arg0),
            nft_id     : v1,
            depositor  : v0,
            maker_side : false,
        };
        0x2::event::emit<NftDeposited>(v4);
    }

    public fun finalize_swap(arg0: &mut GlobalRegistry, arg1: &mut BundleOffer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 4);
        assert_ready_to_release(arg1, 0x2::tx_context::sender(arg2));
        assert_all_nfts_released(arg1);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.active_offers, 0x2::object::id<BundleOffer>(arg1));
        arg1.state = 2;
        let v0 = SwapExecuted{
            offer_id : 0x2::object::id<BundleOffer>(arg1),
            maker    : arg1.maker,
            taker    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapExecuted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalRegistry{
            id            : 0x2::object::new(arg0),
            active_offers : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<GlobalRegistry>(v0);
    }

    public fun pay_requested_coin<T0>(arg0: &mut BundleOffer, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::PlatformConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::is_paused(arg2), 9);
        assert!(arg0.state == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.expiration_ms, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert_taker_allowed(arg0, v0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = requested_coin_index(&arg0.requested_coins, v1);
        assert!(0x1::option::is_some<u64>(&v2), 5);
        let v3 = 0x1::vector::borrow_mut<CoinRequirement>(&mut arg0.requested_coins, 0x1::option::destroy_some<u64>(v2));
        assert!(!v3.paid, 4);
        let v4 = v3.amount;
        v3.paid = true;
        let v5 = 0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::get_flat_fee<T0>(arg2);
        assert!(0x2::coin::value<T0>(&arg1) >= v4 + v5, 8);
        if (v5 > 0) {
            0x7f76809d57b9d07fa0314ada5af9bd799729ecc4453dabf7ef1a0c22a3a61d15::fee_manager_v2::collect_fee<T0>(arg2, 0x2::coin::split<T0>(&mut arg1, v5, arg4));
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v4, arg4), arg0.maker);
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        let v6 = TakerPaymentDeposited{
            offer_id  : 0x2::object::id<BundleOffer>(arg0),
            payer     : v0,
            coin_type : v1,
            amount    : v4,
        };
        0x2::event::emit<TakerPaymentDeposited>(v6);
    }

    public fun reclaim_maker_coin<T0>(arg0: &mut BundleOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 1);
        let v0 = if (arg0.state == 3) {
            true
        } else if (arg0.state == 4) {
            true
        } else {
            arg0.state == 5
        };
        assert!(v0, 4);
        let v1 = CoinEscrowKey{coin_type: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<CoinEscrowKey>(&arg0.id, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<CoinEscrowKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1), arg0.maker);
        };
    }

    public fun reclaim_maker_nft<T0: store + key>(arg0: &mut BundleOffer, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        let v0 = if (arg0.state == 3) {
            true
        } else if (arg0.state == 4) {
            true
        } else {
            arg0.state == 5
        };
        assert!(v0, 4);
        assert!(contains_id(&arg0.maker_nft_ids, arg1), 5);
        let v1 = EscrowKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v1), 7);
        let v2 = EscrowKey{id: arg1};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<EscrowKey, T0>(&mut arg0.id, v2), arg0.maker);
    }

    public fun release_maker_coin_to_taker<T0>(arg0: &mut BundleOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 4);
        assert_ready_to_release(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = CoinEscrowKey{coin_type: v0};
        assert!(0x2::dynamic_field::exists<CoinEscrowKey>(&arg0.id, v1), 7);
        let v2 = 0x2::dynamic_field::remove<CoinEscrowKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), 0x2::tx_context::sender(arg1));
        let v3 = MakerCoinReleased{
            offer_id  : 0x2::object::id<BundleOffer>(arg0),
            recipient : 0x2::tx_context::sender(arg1),
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<MakerCoinReleased>(v3);
    }

    public fun release_maker_nft_to_taker<T0: store + key>(arg0: &mut BundleOffer, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 4);
        assert_ready_to_release(arg0, 0x2::tx_context::sender(arg2));
        assert!(contains_id(&arg0.maker_nft_ids, arg1), 5);
        let v0 = EscrowKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v0), 7);
        let v1 = EscrowKey{id: arg1};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<EscrowKey, T0>(&mut arg0.id, v1), 0x2::tx_context::sender(arg2));
        let v2 = NftReleased{
            offer_id   : 0x2::object::id<BundleOffer>(arg0),
            nft_id     : arg1,
            recipient  : 0x2::tx_context::sender(arg2),
            maker_side : true,
        };
        0x2::event::emit<NftReleased>(v2);
    }

    public fun release_requested_nft_to_maker<T0: store + key>(arg0: &mut BundleOffer, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 1, 4);
        assert_ready_to_release(arg0, 0x2::tx_context::sender(arg2));
        assert!(contains_id(&arg0.requested_nft_ids, arg1), 5);
        let v0 = EscrowKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists<EscrowKey>(&arg0.id, v0), 7);
        let v1 = EscrowKey{id: arg1};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<EscrowKey, T0>(&mut arg0.id, v1), arg0.maker);
        let v2 = NftReleased{
            offer_id   : 0x2::object::id<BundleOffer>(arg0),
            nft_id     : arg1,
            recipient  : arg0.maker,
            maker_side : false,
        };
        0x2::event::emit<NftReleased>(v2);
    }

    public fun requested_coin<T0>(arg0: u64) : CoinRequirement {
        CoinRequirement{
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg0,
            paid      : arg0 == 0,
        }
    }

    fun requested_coin_index(arg0: &vector<CoinRequirement>, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CoinRequirement>(arg0)) {
            if (0x1::vector::borrow<CoinRequirement>(arg0, v0).coin_type == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun requested_sui(arg0: u64) : CoinRequirement {
        requested_coin<0x2::sui::SUI>(arg0)
    }

    // decompiled from Move bytecode v7
}

