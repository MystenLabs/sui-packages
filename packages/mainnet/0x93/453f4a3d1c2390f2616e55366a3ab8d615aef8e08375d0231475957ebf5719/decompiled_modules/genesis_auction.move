module 0x93453f4a3d1c2390f2616e55366a3ab8d615aef8e08375d0231475957ebf5719::genesis_auction {
    struct GenesisAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuctionInfo has copy, drop, store {
        auction_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        creator: address,
        start_ms: u64,
        end_ms: u64,
    }

    struct AuctionRegistry has key {
        id: 0x2::object::UID,
        auctions: 0x2::table::Table<0x2::object::ID, AuctionInfo>,
        ordered_ids: vector<0x2::object::ID>,
    }

    struct Auction<phantom T0> has key {
        id: 0x2::object::UID,
        escrow: 0x2::balance::Balance<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        deposits: 0x2::table::Table<address, u64>,
        start_ms: u64,
        end_ms: u64,
        total_raised: u64,
        closed_at_ms: u64,
        closed: bool,
        sui_withdrawn: bool,
        claims_open: bool,
        withdraws_enabled: bool,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        start_ms: u64,
        end_ms: u64,
    }

    struct Deposited has copy, drop {
        auction_id: 0x2::object::ID,
        user: address,
        amount: u64,
        wallet_total: u64,
        total_raised: u64,
    }

    struct Withdrawn has copy, drop {
        auction_id: 0x2::object::ID,
        user: address,
        amount: u64,
        wallet_total: u64,
        total_raised: u64,
    }

    struct Closed has copy, drop {
        auction_id: 0x2::object::ID,
        total_raised: u64,
        closed_at_ms: u64,
    }

    struct RaisedWithdrawn has copy, drop {
        auction_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct ClaimsOpened has copy, drop {
        auction_id: 0x2::object::ID,
    }

    struct Claimed has copy, drop {
        auction_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct EscrowReclaimed has copy, drop {
        auction_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct UnclaimedSwept has copy, drop {
        auction_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct WithdrawsToggled has copy, drop {
        auction_id: 0x2::object::ID,
        enabled: bool,
    }

    public entry fun cancel_empty<T0>(arg0: &GenesisAdminCap, arg1: &mut AuctionRegistry, arg2: Auction<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.closed, 8);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.end_ms, 7);
        assert!(0x2::table::is_empty<address, u64>(&arg2.deposits), 14);
        let v0 = 0x2::object::id<Auction<T0>>(&arg2);
        let Auction {
            id                : v1,
            escrow            : v2,
            sui_raised        : v3,
            deposits          : v4,
            start_ms          : _,
            end_ms            : _,
            total_raised      : _,
            closed_at_ms      : _,
            closed            : _,
            sui_withdrawn     : _,
            claims_open       : _,
            withdraws_enabled : _,
        } = arg2;
        let v13 = v2;
        0x2::table::destroy_empty<address, u64>(v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        if (0x2::table::contains<0x2::object::ID, AuctionInfo>(&arg1.auctions, v0)) {
            0x2::table::remove<0x2::object::ID, AuctionInfo>(&mut arg1.auctions, v0);
        };
        let v14 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg4), v14);
        0x2::object::delete(v1);
        let v15 = EscrowReclaimed{
            auction_id : v0,
            amount     : 0x2::balance::value<T0>(&v13),
            recipient  : v14,
        };
        0x2::event::emit<EscrowReclaimed>(v15);
    }

    public entry fun claim<T0>(arg0: &mut Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_coin<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun claim_coin<T0>(arg0: &mut Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.claims_open, 11);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 12);
        let v1 = muldiv(100000000000000000, *0x2::table::borrow<address, u64>(&arg0.deposits, v0), arg0.total_raised);
        assert!(v1 > 0, 12);
        0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        let v2 = Claimed{
            auction_id : 0x2::object::id<Auction<T0>>(arg0),
            user       : v0,
            amount     : v1,
        };
        0x2::event::emit<Claimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, v1), arg1)
    }

    public fun claimable<T0>(arg0: &Auction<T0>, arg1: address) : u64 {
        if (!arg0.claims_open || !0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            return 0
        };
        muldiv(100000000000000000, *0x2::table::borrow<address, u64>(&arg0.deposits, arg1), arg0.total_raised)
    }

    public entry fun close<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>, arg2: &0x2::clock::Clock) {
        assert!(!arg1.closed, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.end_ms, 7);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_raised);
        assert!(v1 > 0, 9);
        arg1.total_raised = v1;
        arg1.closed_at_ms = v0;
        arg1.closed = true;
        let v2 = Closed{
            auction_id   : 0x2::object::id<Auction<T0>>(arg1),
            total_raised : v1,
            closed_at_ms : v0,
        };
        0x2::event::emit<Closed>(v2);
    }

    public fun closed_at_ms<T0>(arg0: &Auction<T0>) : u64 {
        arg0.closed_at_ms
    }

    public entry fun create_auction<T0>(arg0: &GenesisAdminCap, arg1: &mut AuctionRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 100000000000000000, 0);
        assert!(arg4 > arg3, 1);
        let v0 = Auction<T0>{
            id                : 0x2::object::new(arg5),
            escrow            : 0x2::coin::into_balance<T0>(arg2),
            sui_raised        : 0x2::balance::zero<0x2::sui::SUI>(),
            deposits          : 0x2::table::new<address, u64>(arg5),
            start_ms          : arg3,
            end_ms            : arg4,
            total_raised      : 0,
            closed_at_ms      : 0,
            closed            : false,
            sui_withdrawn     : false,
            claims_open       : false,
            withdraws_enabled : false,
        };
        let v1 = 0x2::object::id<Auction<T0>>(&v0);
        let v2 = AuctionInfo{
            auction_id : v1,
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            creator    : 0x2::tx_context::sender(arg5),
            start_ms   : arg3,
            end_ms     : arg4,
        };
        0x2::table::add<0x2::object::ID, AuctionInfo>(&mut arg1.auctions, v1, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.ordered_ids, v1);
        let v3 = AuctionCreated{
            auction_id : v1,
            start_ms   : arg3,
            end_ms     : arg4,
        };
        0x2::event::emit<AuctionCreated>(v3);
        0x2::transfer::share_object<Auction<T0>>(v0);
    }

    public fun current_price<T0>(arg0: &Auction<T0>) : u64 {
        let v0 = current_raised<T0>(arg0);
        if (v0 == 0) {
            0
        } else {
            v0 / 100000000
        }
    }

    public fun current_raised<T0>(arg0: &Auction<T0>) : u64 {
        if (arg0.closed) {
            arg0.total_raised
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised)
        }
    }

    public entry fun deposit<T0>(arg0: &mut Auction<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_active<T0>(arg0, arg2), 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = wallet_deposit<T0>(arg0, v1) + v0;
        assert!(v2 <= 250000000000, 5);
        assert!(v2 >= 100000000, 15);
        if (0x2::table::contains<address, u64>(&arg0.deposits, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v1) = v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposits, v1, v2);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = Deposited{
            auction_id   : 0x2::object::id<Auction<T0>>(arg0),
            user         : v1,
            amount       : v0,
            wallet_total : v2,
            total_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
        };
        0x2::event::emit<Deposited>(v3);
    }

    fun derive_opening_rate(arg0: u64) : u64 {
        let v0 = arg0 / 1250;
        if (v0 > 20000000000) {
            20000000000
        } else {
            v0
        }
    }

    public fun escrow_balance<T0>(arg0: &Auction<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun info_auction_id(arg0: &AuctionInfo) : 0x2::object::ID {
        arg0.auction_id
    }

    public fun info_coin_type(arg0: &AuctionInfo) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun info_creator(arg0: &AuctionInfo) : address {
        arg0.creator
    }

    public fun info_end_ms(arg0: &AuctionInfo) : u64 {
        arg0.end_ms
    }

    public fun info_start_ms(arg0: &AuctionInfo) : u64 {
        arg0.start_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GenesisAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GenesisAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AuctionRegistry{
            id          : 0x2::object::new(arg0),
            auctions    : 0x2::table::new<0x2::object::ID, AuctionInfo>(arg0),
            ordered_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<AuctionRegistry>(v1);
    }

    fun is_active<T0>(arg0: &Auction<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (!arg0.closed) {
            if (v0 >= arg0.start_ms) {
                v0 < arg0.end_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_claims_open<T0>(arg0: &Auction<T0>) : bool {
        arg0.claims_open
    }

    public fun is_closed<T0>(arg0: &Auction<T0>) : bool {
        arg0.closed
    }

    public fun min_deposit() : u64 {
        100000000
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun my_allocation<T0>(arg0: &Auction<T0>, arg1: address) : u64 {
        let v0 = current_raised<T0>(arg0);
        if (v0 == 0 || !0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            return 0
        };
        muldiv(100000000000000000, *0x2::table::borrow<address, u64>(&arg0.deposits, arg1), v0)
    }

    public fun offered() : u64 {
        100000000000000000
    }

    public entry fun open_claims<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>) {
        assert!(arg1.closed, 10);
        assert!(arg1.sui_withdrawn, 18);
        if (!arg1.claims_open) {
            arg1.claims_open = true;
            let v0 = ClaimsOpened{auction_id: 0x2::object::id<Auction<T0>>(arg1)};
            0x2::event::emit<ClaimsOpened>(v0);
        };
    }

    public fun opening_rate<T0>(arg0: &Auction<T0>) : u64 {
        derive_opening_rate(arg0.total_raised)
    }

    public fun participants<T0>(arg0: &Auction<T0>) : u64 {
        0x2::table::length<address, u64>(&arg0.deposits)
    }

    public fun per_wallet_cap() : u64 {
        250000000000
    }

    public fun q1_vault_amount<T0>(arg0: &Auction<T0>) : u64 {
        opening_rate<T0>(arg0) * 7776000
    }

    public fun raised_withdrawn<T0>(arg0: &Auction<T0>) : bool {
        arg0.sui_withdrawn
    }

    public fun registry_contains(arg0: &AuctionRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, AuctionInfo>(&arg0.auctions, arg1)
    }

    public fun registry_ids(arg0: &AuctionRegistry) : &vector<0x2::object::ID> {
        &arg0.ordered_ids
    }

    public fun registry_info(arg0: &AuctionRegistry, arg1: 0x2::object::ID) : AuctionInfo {
        *0x2::table::borrow<0x2::object::ID, AuctionInfo>(&arg0.auctions, arg1)
    }

    public fun registry_live_count(arg0: &AuctionRegistry) : u64 {
        0x2::table::length<0x2::object::ID, AuctionInfo>(&arg0.auctions)
    }

    public fun registry_total_count(arg0: &AuctionRegistry) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.ordered_ids)
    }

    public entry fun set_withdraws_enabled<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>, arg2: bool) {
        if (arg1.withdraws_enabled != arg2) {
            arg1.withdraws_enabled = arg2;
            let v0 = WithdrawsToggled{
                auction_id : 0x2::object::id<Auction<T0>>(arg1),
                enabled    : arg2,
            };
            0x2::event::emit<WithdrawsToggled>(v0);
        };
    }

    public fun sui_balance<T0>(arg0: &Auction<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised)
    }

    public fun sweep_delay_ms() : u64 {
        2592000000
    }

    public entry fun sweep_unclaimed<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.closed, 10);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.closed_at_ms + 2592000000, 16);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = UnclaimedSwept{
            auction_id : 0x2::object::id<Auction<T0>>(arg1),
            amount     : 0x2::balance::value<T0>(&arg1.escrow),
            recipient  : v0,
        };
        0x2::event::emit<UnclaimedSwept>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.escrow), arg3), v0);
    }

    public fun wallet_deposit<T0>(arg0: &Auction<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.deposits, arg1)
        } else {
            0
        }
    }

    public fun window<T0>(arg0: &Auction<T0>) : (u64, u64) {
        (arg0.start_ms, arg0.end_ms)
    }

    public entry fun withdraw_deposit<T0>(arg0: &mut Auction<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.withdraws_enabled, 17);
        assert!(!arg0.closed, 8);
        assert!(arg1 > 0, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 6);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.deposits, v0);
        assert!(arg1 <= v1, 6);
        let v2 = v1 - arg1;
        assert!(v2 == 0 || v2 >= 100000000, 15);
        if (v2 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0) = v2;
        };
        let v3 = Withdrawn{
            auction_id   : 0x2::object::id<Auction<T0>>(arg0),
            user         : v0,
            amount       : arg1,
            wallet_total : v2,
            total_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_raised, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_raised<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_raised_coin<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_raised_coin<T0>(arg0: &GenesisAdminCap, arg1: &mut Auction<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.closed, 10);
        assert!(!arg1.sui_withdrawn, 13);
        arg1.sui_withdrawn = true;
        let v0 = RaisedWithdrawn{
            auction_id : 0x2::object::id<Auction<T0>>(arg1),
            amount     : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_raised),
            recipient  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RaisedWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_raised), arg2)
    }

    public fun withdraws_enabled<T0>(arg0: &Auction<T0>) : bool {
        arg0.withdraws_enabled
    }

    // decompiled from Move bytecode v7
}

