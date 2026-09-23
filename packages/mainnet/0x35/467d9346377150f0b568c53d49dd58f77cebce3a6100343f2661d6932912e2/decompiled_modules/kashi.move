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

    public fun reserve_amount(arg0: &SaleReserve) : u64 {
        0x2::balance::value<KASHI>(&arg0.balance)
    }

    public fun withdraw_proceeds<T0>(arg0: &SaleAdminCap, arg1: &mut Sale<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.sale_id == 0x2::object::id<Sale<T0>>(arg1), 3);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.proceeds), arg2)
    }

    // decompiled from Move bytecode v7
}

