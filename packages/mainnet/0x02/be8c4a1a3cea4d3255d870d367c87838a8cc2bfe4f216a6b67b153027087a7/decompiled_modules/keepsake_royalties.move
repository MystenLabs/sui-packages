module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_royalties {
    struct BpsRoyaltyStrategy<phantom T0> has key {
        id: 0x2::object::UID,
        royalty_fee_bps: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BpsRoyaltyStrategyRule has drop {
        dummy_field: bool,
    }

    struct StrategyCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        royalty_fee_bps: u64,
    }

    public fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BpsRoyaltyStrategy<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = StrategyCreated<T0>{
            id              : 0x2::object::uid_to_inner(&v0),
            royalty_fee_bps : arg0,
        };
        0x2::event::emit<StrategyCreated<T0>>(v1);
        BpsRoyaltyStrategy<T0>{
            id              : v0,
            royalty_fee_bps : arg0,
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun calculate<T0>(arg0: &BpsRoyaltyStrategy<T0>, arg1: u64) : u64 {
        arg1 * arg0.royalty_fee_bps / 10000
    }

    entry fun collect_royalties<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun confirm_transfer_with_balance<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(arg2, calculate<T0>(arg0, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::paid<T0>(arg1))));
        let v0 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::add_receipt<T0, BpsRoyaltyStrategyRule>(v0, arg1);
    }

    public fun confirm_transfer_with_coin<T0>(arg0: &mut BpsRoyaltyStrategy<T0>, arg1: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, calculate<T0>(arg0, 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::paid<T0>(arg1)), arg3)));
        let v0 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::add_receipt<T0, BpsRoyaltyStrategyRule>(v0, arg1);
    }

    public fun create_and_add_strategy<T0>(arg0: &mut 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg1: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg2, arg3);
        let v1 = BpsRoyaltyStrategyRule{dummy_field: false};
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::add_rule<T0, BpsRoyaltyStrategyRule, 0x2::object::ID>(v1, arg0, arg1, 0x2::object::id<BpsRoyaltyStrategy<T0>>(&v0));
        share<T0>(v0);
    }

    public fun royalty_fee_bps<T0>(arg0: &BpsRoyaltyStrategy<T0>) : u64 {
        arg0.royalty_fee_bps
    }

    public fun share<T0>(arg0: BpsRoyaltyStrategy<T0>) {
        0x2::transfer::share_object<BpsRoyaltyStrategy<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

