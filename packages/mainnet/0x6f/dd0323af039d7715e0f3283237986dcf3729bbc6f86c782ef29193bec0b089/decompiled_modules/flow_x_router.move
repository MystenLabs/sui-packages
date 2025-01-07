module 0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::flow_x_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * arg0.buy_fee / 10000;
        let v1 = arg2 - v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg2, 3);
        let v2 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<0x2::sui::SUI, T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4), arg4);
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg4));
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(arg3, 0x2::tx_context::sender(arg4));
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg4), arg0.admin);
        let v3 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg4),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<BuyEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun get_amount_in<T0, T1>(arg0: u64, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>) : u64 {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(arg1);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_in(arg0, v0, v1, 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T0, T1>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 90,
            sell_fee : 90,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= arg2, 3);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, 0x2::sui::SUI>(arg1, 0x2::coin::split<T0>(&mut arg3, arg2, arg4), arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg0.sell_fee / 10000;
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg4));
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg4));
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v2, arg4), arg0.admin);
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg4),
            amount_in  : arg2,
            amount_out : v1 - v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v2,
        };
        0x2::event::emit<FeeCollectedEvent>(v4);
    }

    public entry fun sell_exact_out<T0>(arg0: &FeeObject, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, 0x2::sui::SUI>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) >= arg5, 3);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_direct<T0, 0x2::sui::SUI>(arg1, arg4, arg3, arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0) * arg0.sell_fee / 10000;
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6));
        0x87b333cf2ad3984ff074e1e295237d3d8e6e71044828ed2c4dd80476c61438b2::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1, arg6), arg0.admin);
        let v2 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg6),
            amount_in  : get_amount_in<T0, 0x2::sui::SUI>(arg3, arg2),
            amount_out : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<SellEvent<T0>>(v2);
        let v3 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v1,
        };
        0x2::event::emit<FeeCollectedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

