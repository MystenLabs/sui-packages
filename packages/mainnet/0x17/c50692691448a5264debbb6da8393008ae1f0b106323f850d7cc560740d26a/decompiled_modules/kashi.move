module 0x35467d9346377150f0b568c53d49dd58f77cebce3a6100343f2661d6932912e2::kashi {
    struct KASHI has drop {
        dummy_field: bool,
    }

    struct SaleReserve has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<KASHI>,
    }

    struct Sale<phantom T0> has key {
        id: 0x2::object::UID,
        available: 0x2::balance::Balance<KASHI>,
        proceeds: 0x2::balance::Balance<T0>,
        price: u64,
    }

    struct SaleAdminCap has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        kashi: 0x2::balance::Balance<KASHI>,
        quote: 0x2::balance::Balance<T0>,
        virtual_quote: u64,
        fee_bps: u64,
        fees: 0x2::balance::Balance<T0>,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct Bought has copy, drop {
        market_id: 0x2::object::ID,
        buyer: address,
        paid: u64,
        fee: u64,
        kashi_out: u64,
    }

    struct Sold has copy, drop {
        market_id: 0x2::object::ID,
        seller: address,
        kashi_in: u64,
        fee: u64,
        received: u64,
    }

    fun amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun available<T0>(arg0: &Sale<T0>) : u64 {
        0x2::balance::value<KASHI>(&arg0.available)
    }

    public fun buy<T0>(arg0: &mut Sale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<KASHI>, 0x2::coin::Coin<T0>) {
        let v0 = (0x2::coin::value<T0>(&arg1) as u128) * (1000000000 as u128) / (arg0.price as u128);
        let v1 = (0x2::balance::value<KASHI>(&arg0.available) as u128);
        assert!(v1 > 0, 2);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        assert!(v2 > 0, 1);
        0x2::balance::join<T0>(&mut arg0.proceeds, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, (((v2 * (arg0.price as u128) + (1000000000 as u128) - 1) / (1000000000 as u128)) as u64), arg2)));
        (0x2::coin::take<KASHI>(&mut arg0.available, (v2 as u64), arg2), arg1)
    }

    public fun buy_market<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KASHI> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = fee_on(v0, arg0.fee_bps);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg3)));
        let v2 = amount_out(v0 - v1, quote_reserve<T0>(arg0), 0x2::balance::value<KASHI>(&arg0.kashi));
        assert!(v2 > 0 && v2 < 0x2::balance::value<KASHI>(&arg0.kashi), 6);
        assert!(v2 >= arg2, 5);
        0x2::balance::join<T0>(&mut arg0.quote, 0x2::coin::into_balance<T0>(arg1));
        let v3 = Bought{
            market_id : 0x2::object::id<Market<T0>>(arg0),
            buyer     : 0x2::tx_context::sender(arg3),
            paid      : v0,
            fee       : v1,
            kashi_out : v2,
        };
        0x2::event::emit<Bought>(v3);
        0x2::coin::take<KASHI>(&mut arg0.kashi, v2, arg3)
    }

    fun fee_on(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    fun init(arg0: KASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KASHI>(arg0, 9, 0x1::string::utf8(b"KASHI"), 0x1::string::utf8(b"Kashi"), 0x1::string::utf8(b"Kashi coin"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 1000000000 * 1000000000;
        let v5 = 0x2::coin::mint_balance<KASHI>(&mut v2, v4);
        0x2::coin_registry::make_supply_fixed_init<KASHI>(&mut v3, v2);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KASHI>>(0x2::coin::from_balance<KASHI>(0x2::balance::split<KASHI>(&mut v5, v4 / 100 * 10), arg1), @0x210a64e3e635fbdde0ea28c433e1cd34b7a26aadc3724a3b4fb27b6607319dca);
        let v7 = SaleReserve{
            id      : 0x2::object::new(arg1),
            balance : v5,
        };
        0x2::transfer::public_transfer<SaleReserve>(v7, v6);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KASHI>>(0x2::coin_registry::finalize<KASHI>(v3, arg1), v6);
    }

    public fun market_fees<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public fun market_kashi<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<KASHI>(&arg0.kashi)
    }

    public fun market_quote<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.quote)
    }

    public fun open_market<T0>(arg0: SaleReserve, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : MarketAdminCap {
        assert!(arg1 > 0, 0);
        assert!(arg2 <= 1000, 4);
        let SaleReserve {
            id      : v0,
            balance : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        let v3 = Market<T0>{
            id            : 0x2::object::new(arg3),
            kashi         : v2,
            quote         : 0x2::balance::zero<T0>(),
            virtual_quote : (((arg1 as u128) * (0x2::balance::value<KASHI>(&v2) as u128) / (1000000000 as u128)) as u64),
            fee_bps       : arg2,
            fees          : 0x2::balance::zero<T0>(),
        };
        let v4 = MarketAdminCap{
            id        : 0x2::object::new(arg3),
            market_id : 0x2::object::id<Market<T0>>(&v3),
        };
        0x2::transfer::share_object<Market<T0>>(v3);
        v4
    }

    public fun open_sale<T0>(arg0: SaleReserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SaleAdminCap {
        assert!(arg1 > 0, 0);
        let SaleReserve {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = Sale<T0>{
            id        : 0x2::object::new(arg2),
            available : v1,
            proceeds  : 0x2::balance::zero<T0>(),
            price     : arg1,
        };
        let v3 = SaleAdminCap{
            id      : 0x2::object::new(arg2),
            sale_id : 0x2::object::id<Sale<T0>>(&v2),
        };
        0x2::transfer::share_object<Sale<T0>>(v2);
        v3
    }

    public fun price<T0>(arg0: &Sale<T0>) : u64 {
        arg0.price
    }

    public fun proceeds<T0>(arg0: &Sale<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.proceeds)
    }

    public fun quote_buy<T0>(arg0: &Market<T0>, arg1: u64) : u64 {
        amount_out(arg1 - fee_on(arg1, arg0.fee_bps), quote_reserve<T0>(arg0), 0x2::balance::value<KASHI>(&arg0.kashi))
    }

    fun quote_reserve<T0>(arg0: &Market<T0>) : u64 {
        arg0.virtual_quote + 0x2::balance::value<T0>(&arg0.quote)
    }

    public fun quote_sell<T0>(arg0: &Market<T0>, arg1: u64) : u64 {
        let v0 = amount_out(arg1, 0x2::balance::value<KASHI>(&arg0.kashi), quote_reserve<T0>(arg0));
        v0 - fee_on(v0, arg0.fee_bps)
    }

    public fun reserve_amount(arg0: &SaleReserve) : u64 {
        0x2::balance::value<KASHI>(&arg0.balance)
    }

    public fun sell_market<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<KASHI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<KASHI>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = amount_out(v0, 0x2::balance::value<KASHI>(&arg0.kashi), quote_reserve<T0>(arg0));
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.quote), 6);
        let v2 = fee_on(v1, arg0.fee_bps);
        let v3 = v1 - v2;
        assert!(v3 > 0, 6);
        assert!(v3 >= arg2, 5);
        0x2::balance::join<KASHI>(&mut arg0.kashi, 0x2::coin::into_balance<KASHI>(arg1));
        let v4 = 0x2::balance::split<T0>(&mut arg0.quote, v1);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v4, v2));
        let v5 = Sold{
            market_id : 0x2::object::id<Market<T0>>(arg0),
            seller    : 0x2::tx_context::sender(arg3),
            kashi_in  : v0,
            fee       : v2,
            received  : v3,
        };
        0x2::event::emit<Sold>(v5);
        0x2::coin::from_balance<T0>(v4, arg3)
    }

    public fun spot_price<T0>(arg0: &Market<T0>) : u64 {
        (((quote_reserve<T0>(arg0) as u128) * (1000000000 as u128) / (0x2::balance::value<KASHI>(&arg0.kashi) as u128)) as u64)
    }

    public fun withdraw_fees<T0>(arg0: &MarketAdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.market_id == 0x2::object::id<Market<T0>>(arg1), 3);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fees), arg2)
    }

    public fun withdraw_proceeds<T0>(arg0: &SaleAdminCap, arg1: &mut Sale<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.sale_id == 0x2::object::id<Sale<T0>>(arg1), 3);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.proceeds), arg2)
    }

    // decompiled from Move bytecode v7
}

