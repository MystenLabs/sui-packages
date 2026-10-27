module 0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        platform_address: address,
        fee_bps: u64,
        accrued_fees: 0x2::balance::Balance<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>,
    }

    struct Listing<T0: store + key> has store, key {
        id: 0x2::object::UID,
        item: T0,
        seller: address,
        price_units: u64,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        price_units: u64,
    }

    struct ListingPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price_units: u64,
        fee_units: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    struct FeeWithdrawn has copy, drop {
        amount_units: u64,
        to: address,
    }

    public fun accrued_fee_value(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&arg0.accrued_fees)
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: Listing<T0>, arg2: 0x2::coin::Coin<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let Listing {
            id          : v1,
            item        : v2,
            seller      : v3,
            price_units : v4,
        } = arg1;
        let v5 = v2;
        let v6 = v1;
        assert!(0x2::coin::value<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&arg2) >= v4, 3);
        let v7 = v4 * arg0.fee_bps / 10000;
        if (0x2::coin::value<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(arg2);
        };
        0x2::balance::join<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&mut arg0.accrued_fees, 0x2::coin::into_balance<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(0x2::coin::split<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&mut arg2, v7, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>>(0x2::coin::split<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&mut arg2, v4 - v7, arg3), v3);
        0x2::transfer::public_transfer<T0>(v5, v0);
        0x2::object::delete(v6);
        let v8 = ListingPurchased{
            listing_id  : 0x2::object::uid_to_inner(&v6),
            item_id     : 0x2::object::id<T0>(&v5),
            seller      : v3,
            buyer       : v0,
            price_units : v4,
            fee_units   : v7,
        };
        0x2::event::emit<ListingPurchased>(v8);
    }

    public fun cancel<T0: store + key>(arg0: Listing<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id          : v0,
            item        : v1,
            seller      : v2,
            price_units : _,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(v2 == 0x2::tx_context::sender(arg1), 1);
        let v6 = ListingCancelled{
            listing_id : 0x2::object::uid_to_inner(&v5),
            item_id    : 0x2::object::id<T0>(&v4),
            seller     : v2,
        };
        0x2::event::emit<ListingCancelled>(v6);
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(v4, v2);
    }

    public fun fee_bps(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id               : 0x2::object::new(arg0),
            platform_address : 0x2::tx_context::sender(arg0),
            fee_bps          : 250,
            accrued_fees     : 0x2::balance::zero<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(),
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Listing<T0>{
            id          : 0x2::object::new(arg2),
            item        : arg0,
            seller      : v0,
            price_units : arg1,
        };
        let v2 = ListingCreated{
            listing_id  : 0x2::object::id<Listing<T0>>(&v1),
            item_id     : 0x2::object::id<T0>(&arg0),
            seller      : v0,
            price_units : arg1,
        };
        0x2::event::emit<ListingCreated>(v2);
        0x2::transfer::share_object<Listing<T0>>(v1);
    }

    public fun listing_price<T0: store + key>(arg0: &Listing<T0>) : u64 {
        arg0.price_units
    }

    public fun listing_seller<T0: store + key>(arg0: &Listing<T0>) : address {
        arg0.seller
    }

    public fun platform_address(arg0: &Marketplace) : address {
        arg0.platform_address
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64) {
        assert!(arg2 <= 1000, 4);
        arg1.fee_bps = arg2;
    }

    public fun set_platform_address(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address) {
        arg1.platform_address = arg2;
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.platform_address;
        let v1 = FeeWithdrawn{
            amount_units : arg2,
            to           : v0,
        };
        0x2::event::emit<FeeWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>>(0x2::coin::from_balance<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(0x2::balance::split<0x865f07b88b9eb8b74973e0b85517ee0a83adef11644362f62e6229a30c465b31::hps::HPS>(&mut arg1.accrued_fees, arg2), arg3), v0);
    }

    // decompiled from Move bytecode v7
}

