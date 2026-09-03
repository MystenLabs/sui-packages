module 0x280ddb7b8bf0c8cec87d4d640058e7b93524dd509057f251cc3d13343b1da8e6::market {
    struct Listing<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        seller: address,
        stock: 0x2::balance::Balance<T0>,
        price_per_unit: u64,
        sold: u64,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        amount: u64,
        price_per_unit: u64,
    }

    struct Purchased has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
        paid: u64,
        remaining: u64,
    }

    struct PriceChanged has copy, drop {
        listing_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    struct StockChanged has copy, drop {
        listing_id: 0x2::object::ID,
        remaining: u64,
    }

    public fun add_stock<T0, T1>(arg0: &mut Listing<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 3);
        0x2::balance::join<T0>(&mut arg0.stock, 0x2::coin::into_balance<T0>(arg1));
        let v0 = StockChanged{
            listing_id : 0x2::object::id<Listing<T0, T1>>(arg0),
            remaining  : 0x2::balance::value<T0>(&arg0.stock),
        };
        0x2::event::emit<StockChanged>(v0);
    }

    public fun buy<T0, T1>(arg0: &mut Listing<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        buy_capped<T0, T1>(arg0, arg1, arg2, 18446744073709551615, arg3)
    }

    public fun buy_capped<T0, T1>(arg0: &mut Listing<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.stock) >= arg2, 2);
        let v0 = (arg2 as u128) * (arg0.price_per_unit as u128);
        assert!(v0 <= 18446744073709551615, 6);
        let v1 = (v0 as u64);
        assert!(v1 <= arg3, 100);
        assert!(0x2::coin::value<T1>(&arg1) >= v1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v1, arg4), arg0.seller);
        arg0.sold = arg0.sold + arg2;
        let v2 = Purchased{
            listing_id : 0x2::object::id<Listing<T0, T1>>(arg0),
            seller     : arg0.seller,
            buyer      : 0x2::tx_context::sender(arg4),
            amount     : arg2,
            paid       : v1,
            remaining  : 0x2::balance::value<T0>(&arg0.stock),
        };
        0x2::event::emit<Purchased>(v2);
        (0x2::coin::take<T0>(&mut arg0.stock, arg2, arg4), arg1)
    }

    public fun close_listing<T0, T1>(arg0: Listing<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg1), 1);
        assert!(0x2::balance::value<T0>(&arg0.stock) == 0, 5);
        let Listing {
            id             : v0,
            seller         : _,
            stock          : v2,
            price_per_unit : _,
            sold           : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun create_listing<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 3);
        assert!(arg1 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = Listing<T0, T1>{
            id             : 0x2::object::new(arg2),
            seller         : v1,
            stock          : 0x2::coin::into_balance<T0>(arg0),
            price_per_unit : arg1,
            sold           : 0,
        };
        let v3 = ListingCreated{
            listing_id     : 0x2::object::id<Listing<T0, T1>>(&v2),
            seller         : v1,
            amount         : v0,
            price_per_unit : arg1,
        };
        0x2::event::emit<ListingCreated>(v3);
        0x2::transfer::share_object<Listing<T0, T1>>(v2);
    }

    public fun price_per_unit<T0, T1>(arg0: &Listing<T0, T1>) : u64 {
        arg0.price_per_unit
    }

    public fun quote<T0, T1>(arg0: &Listing<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.price_per_unit as u128);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    public fun seller<T0, T1>(arg0: &Listing<T0, T1>) : address {
        arg0.seller
    }

    public fun set_price<T0, T1>(arg0: &mut Listing<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 > 0, 3);
        arg0.price_per_unit = arg1;
        let v0 = PriceChanged{
            listing_id : 0x2::object::id<Listing<T0, T1>>(arg0),
            old_price  : arg0.price_per_unit,
            new_price  : arg1,
        };
        0x2::event::emit<PriceChanged>(v0);
    }

    public fun sold<T0, T1>(arg0: &Listing<T0, T1>) : u64 {
        arg0.sold
    }

    public fun stock<T0, T1>(arg0: &Listing<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.stock)
    }

    public fun withdraw<T0, T1>(arg0: &mut Listing<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.stock) >= arg1, 2);
        let v0 = StockChanged{
            listing_id : 0x2::object::id<Listing<T0, T1>>(arg0),
            remaining  : 0x2::balance::value<T0>(&arg0.stock),
        };
        0x2::event::emit<StockChanged>(v0);
        0x2::coin::take<T0>(&mut arg0.stock, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

